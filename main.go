package main

import (
	"context"
	"errors"
	"net/http"
	"os"
	"os/signal"
	"sync"
	"syscall"
	"time"

	"github.com/bufbuild/protovalidate-go"
	"github.com/esolveeg/abcsystem/api"
	"github.com/esolveeg/abcsystem/config"
	"github.com/esolveeg/abcsystem/erpapiclient"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

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
	zerolog.TimeFieldFormat = zerolog.TimeFormatUnix
	log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stderr})
	ctx := context.Background()
	state, err := config.LoadState("./config")
	if err != nil {
		log.Fatal().Err(err).Msg("cannot load the state config")
	}
	config, err := config.LoadConfig("./config", state.State)
	validator, err := protovalidate.New()
	if err != nil {
		log.Fatal().Err(err).Msg("can't get the validator")
	}
	erp, err := erpapiclient.New(
		config.ERPAPIUrl,
		erpapiclient.WithToken(config.ERPAPIToken), // "token key:secret"
		erpapiclient.WithTimeout(8*time.Second),
	)

	server, err := api.NewServer(config, erp, validator) // Start the server in a goroutine
	if err != nil {
		log.Fatal().Err(err).Msg("server initialization failed")
	}
	httpServer := server.NewGrpcHttpServer()
	go func() {
		log.Info().Str("server address", config.GRPCServerAddress).Msg("GRPC server start")
		if err := httpServer.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
			log.Fatal().Err(err).Msg("HTTP listen and serve failed")
		}
	}()

	signals := make(chan os.Signal, 1)
	signal.Notify(signals, os.Interrupt, syscall.SIGTERM)
	wait := gracefulShutdown(ctx, 3*time.Second, map[string]operation{
		"http-server": func(ctx context.Context) error {
			return httpServer.Shutdown(ctx)
		},
		// Add other cleanup operations here
	})
	<-wait
}
