package main

import (
	"net/http"

	"context"
	"errors"
	"fmt"
	"os"
	"os/signal"
	"sync"
	"syscall"
	"time"

	"connectrpc.com/connect"
	"connectrpc.com/grpchealth"
	"connectrpc.com/grpcreflect"
	"github.com/darwishdev/devkit-api/config"
	"github.com/darwishdev/devkit-api/gen/db"
	apiv1 "github.com/darwishdev/devkit-api/gen/pb/proto/devkit/v1"
	"github.com/darwishdev/devkit-api/gen/pb/proto/devkit/v1/devkitv1connect"
	"github.com/jackc/pgx/v5/pgtype"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/rs/cors"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

func GrpcLogger() connect.UnaryInterceptorFunc {
	interceptor := func(next connect.UnaryFunc) connect.UnaryFunc {
		return connect.UnaryFunc(func(
			ctx context.Context,
			req connect.AnyRequest,
		) (connect.AnyResponse, error) {
			startTime := time.Now()
			result, err := next(ctx, req)
			duration := time.Since(startTime)
			zerolog.TimeFieldFormat = zerolog.TimeFormatUnix
			log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stderr})
			logger := log.Info()
			if err != nil {
				logger = log.Error().Err(err)
			}
			logger.
				Str("Procedure", req.Spec().Procedure).
				Interface("request", req.Any()).
				Interface("response", result).
				Dur("duration", duration).
				Msg("received a gRPC request")
			return result, err
		})
	}
	return connect.UnaryInterceptorFunc(interceptor)
}

type Api struct {
	devkitv1connect.UnimplementedDevkitServiceHandler
	store db.Store
}

func NewApi(store db.Store) devkitv1connect.DevkitServiceHandler {
	return &Api{
		store: store,
	}

}
func (api *Api) HelloWorld(ctx context.Context, req *connect.Request[apiv1.HelloWorldRequest]) (*connect.Response[apiv1.HelloWorldResponse], error) {
	return connect.NewResponse(&apiv1.HelloWorldResponse{Greet: "hello " + req.Msg.GetName()}), nil
}
func (api *Api) RoleCreate(ctx context.Context, req *connect.Request[apiv1.RoleCreateRequest]) (*connect.Response[apiv1.RoleCreateResponse], error) {
	roleCreateParams := db.RoleCreateParams{RoleName: req.Msg.GetRoleName(), RoleDescription: pgtype.Text{String: req.Msg.GetRoleDescription(), Valid: true}}
	role, err := api.store.RoleCreate(ctx, roleCreateParams)
	if err != nil {
		return nil, err
	}
	response := apiv1.RoleCreateResponse{Role: &apiv1.AccountsSchemaRole{
		RoleId:          role.RoleID,
		RoleName:        role.RoleName,
		RoleDescription: role.RoleDescription.String,
		CreatedAt:       role.CreatedAt.Time.Format("2024-10-01"),
		DeletedAt:       role.CreatedAt.Time.Format("2024-10-01"),
	}}
	return connect.NewResponse(&response), nil
}

// operation is a clean up function on shutting down
type operation func(ctx context.Context) error

// gracefulShutdown waits for termination syscalls and doing clean up operations after received it
func gracefulShutdown(ctx context.Context, timeout time.Duration, ops map[string]operation) <-chan struct{} {
	wait := make(chan struct{})
	go func() {
		s := make(chan os.Signal, 1)

		// add any other syscalls that you want to be notified with
		signal.Notify(s, syscall.SIGINT, syscall.SIGTERM, syscall.SIGHUP)
		<-s

		log.Info().Msg("shutting down")

		// set timeout for the ops to be done to prevent system hang
		timeoutFunc := time.AfterFunc(timeout, func() {
			log.Printf("timeout %d ms has been elapsed, force exit", timeout.Milliseconds())
			os.Exit(0)
		})

		defer timeoutFunc.Stop()

		var wg sync.WaitGroup

		// Do the operations asynchronously to save time
		for key, op := range ops {
			wg.Add(1)
			innerOp := op
			innerKey := key
			go func() {
				defer wg.Done()

				log.Printf("cleaning up: %s", innerKey)
				if err := innerOp(ctx); err != nil {
					log.Printf("%s: clean up failed: %s", innerKey, err.Error())
					return
				}

				log.Printf("%s was shutdown gracefully", innerKey)
			}()
		}

		wg.Wait()

		close(wait)
	}()

	return wait
}
func main() {
	// first we need to simply create our grpc server
	// in order to do that we will use buf build , buf connect
	zerolog.TimeFieldFormat = zerolog.TimeFormatUnix
	log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stderr})
	ctx := context.Background()

	state, err := config.LoadState("./config")
	if err != nil {
		log.Fatal().Err(err).Msg("cannot load the state config")
	}
	dbTracer := db.NewDbTracer()
	config, err := config.LoadConfig("./config", state.State)
	dbConfig, err := pgxpool.ParseConfig(config.DBSource)
	if err != nil {
		log.Fatal().Err(err).Msg("cannot load the config")
	}
	dbConfig.ConnConfig.Tracer = dbTracer
	connPool, err := pgxpool.NewWithConfig(ctx, dbConfig)
	if err != nil {
		log.Fatal().Err(err).Interface("conntection", config.DBSource).Msg("cannot get the connection pool")
	}
	// Attempt to ping the database to ensure the connection is working.
	if err := connPool.Ping(ctx); err != nil {
		connPool.Close()
		log.Fatal().Str("conn", config.DBSource).Err(err).Msg("database ping failed")
	}
	store := db.NewStore(connPool)
	fmt.Println("connected to", config.DBSource, store)
	mux := http.NewServeMux()
	mux.Handle("/", http.RedirectHandler("https://darwishdev.com", http.StatusFound))
	// here we can find examples of diffrent compression method 	https://connectrpc.com/docs/go/serialization-and-compression/#compression
	compress1KB := connect.WithCompressMinBytes(1024)
	interceptors := connect.WithInterceptors(GrpcLogger())
	api := NewApi(store)

	mux.Handle(devkitv1connect.NewDevkitServiceHandler(
		api,
		interceptors,
		compress1KB,
	))

	mux.Handle(grpchealth.NewHandler(
		grpchealth.NewStaticChecker(devkitv1connect.DevkitServiceName),
		compress1KB,
	))
	mux.Handle(grpcreflect.NewHandlerV1(
		grpcreflect.NewStaticReflector(devkitv1connect.DevkitServiceName),
		compress1KB,
	))
	mux.Handle(grpcreflect.NewHandlerV1Alpha(
		grpcreflect.NewStaticReflector(devkitv1connect.DevkitServiceName),
		compress1KB,
	))
	cors := cors.New(cors.Options{})
	server := &http.Server{
		Addr:    config.GRPCServerAddress,
		Handler: h2c.NewHandler(cors.Handler(mux), &http2.Server{}),
	}
	// Start the server in a goroutine
	go func() {
		log.Info().Str("server address", config.GRPCServerAddress).Msg("GRPC server start")
		if err := server.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
			log.Fatal().Err(err).Msg("HTTP listen and serve failed")
		}
	}()

	signals := make(chan os.Signal, 1)
	signal.Notify(signals, os.Interrupt, syscall.SIGTERM)
	wait := gracefulShutdown(ctx, 3*time.Second, map[string]operation{
		"database": func(ctx context.Context) error {
			connPool.Close()
			return nil
		},
		"http-server": func(ctx context.Context) error {
			return server.Shutdown(ctx)
		},
		// Add other cleanup operations here
	})

	<-wait
}
