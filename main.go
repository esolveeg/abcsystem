package main

import (
	"net/http"

	"context"
	"fmt"

	"connectrpc.com/connect"
	"connectrpc.com/grpchealth"
	"connectrpc.com/grpcreflect"
	"github.com/darwishdev/devkit-api/gen/db"
	apiv1 "github.com/darwishdev/devkit-api/gen/proto/devkit/v1"
	"github.com/darwishdev/devkit-api/gen/proto/devkit/v1/devkitv1connect"
	"github.com/jackc/pgx/v5/pgtype"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/rs/cors"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

func GrpcLogger() connect.UnaryInterceptorFunc {
	interceptor := func(next connect.UnaryFunc) connect.UnaryFunc {
		return connect.UnaryFunc(func(
			ctx context.Context,
			req connect.AnyRequest,
		) (connect.AnyResponse, error) {
			result, err := next(ctx, req)
			return result, err
		})
	}
	return connect.UnaryInterceptorFunc(interceptor)
}

type Api struct {
	devkitv1connect.UnimplementedDevkitServiceHandler
}

func NewApi() devkitv1connect.DevkitServiceHandler {
	return &Api{}

}
func (api *Api) HelloWorld(ctx context.Context, req *connect.Request[apiv1.HelloWorldRequest]) (*connect.Response[apiv1.HelloWorldResponse], error) {
	return connect.NewResponse(&apiv1.HelloWorldResponse{Greet: "hello " + req.Msg.GetName()}), nil
}
func main() {
	// first we need to simply create our grpc server
	// in order to do that we will use buf build , buf connect
	ctx := context.Background()
	connectionString := "postgres://postgres:postgres@localhost:54322/postgres"
	dbConfig, err := pgxpool.ParseConfig(connectionString)
	if err != nil {
		panic(err)
	}
	connPool, err := pgxpool.NewWithConfig(ctx, dbConfig)
	if err != nil {
		panic(err)
	}
	// Attempt to ping the database to ensure the connection is working.
	if err := connPool.Ping(ctx); err != nil {
		connPool.Close()
		panic(err)
	}
	store := db.NewStore(connPool)
	role, err := store.RoleCreate(ctx, db.RoleCreateParams{RoleName: "new test role", RoleDescription: pgtype.Text{
		String: "test desciption",
		Valid:  true,
	}})
	if err := connPool.Ping(ctx); err != nil {
		panic(err)
	}
	fmt.Println("connected to", connectionString, role)

	mux := http.NewServeMux()
	mux.Handle("/", http.RedirectHandler("https://darwishdev.com", http.StatusFound))
	// here we can find examples of diffrent compression method 	https://connectrpc.com/docs/go/serialization-and-compression/#compression
	compress1KB := connect.WithCompressMinBytes(1024)

	interceptors := connect.WithInterceptors(GrpcLogger())
	api := NewApi()
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
		Addr:    "192.168.1.40:9091",
		Handler: h2c.NewHandler(cors.Handler(mux), &http2.Server{}),
	}

	err = server.ListenAndServe()
	if err != nil {
		panic("can't start the server")
	}

}
