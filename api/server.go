package api

import (
	"net/http"

	"time"

	"connectrpc.com/connect"
	"connectrpc.com/grpchealth"
	"connectrpc.com/grpcreflect"
	"github.com/bufbuild/protovalidate-go"
	"github.com/esolveeg/abcsystem/config"
	"github.com/esolveeg/abcsystem/erpapiclient"
	"github.com/esolveeg/abcsystem/proto_gen/abcsystem/v1/abcsystemv1connect"
	"github.com/rs/cors"
	"github.com/rs/zerolog/log"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

type Server struct {
	config    config.Config
	validator *protovalidate.Validator
	ERP       *erpapiclient.Client
	api       abcsystemv1connect.AbcsystemServiceHandler
}

func NewServer(config config.Config, ERP *erpapiclient.Client, validator *protovalidate.Validator) (*Server, error) {
	api, err := NewApi(config, ERP, validator)

	if err != nil {
		return nil, err
	}
	return &Server{
		config:    config,
		ERP:       ERP,
		validator: validator,
		api:       api,
	}, nil
}

func (s Server) NewGrpcHttpServer() *http.Server {
	mux := http.NewServeMux()
	mux.Handle("/", http.RedirectHandler("https://conchahotel.com", http.StatusFound))
	// here we can find examples of diffrent compression method 	https://connectrpc.com/docs/go/serialization-and-compression/#compression
	compress1KB := connect.WithCompressMinBytes(1024)
	interceptors := connect.WithInterceptors(s.NewLoggerInterceptor())

	name, handler := abcsystemv1connect.NewAbcsystemServiceHandler(
		s.api,
		interceptors,
		compress1KB,
	)
	mux.Handle(name, handler)

	mux.Handle(grpchealth.NewHandler(
		grpchealth.NewStaticChecker(abcsystemv1connect.AbcsystemServiceName),
		compress1KB,
	))
	mux.Handle(grpcreflect.NewHandlerV1(
		grpcreflect.NewStaticReflector(abcsystemv1connect.AbcsystemServiceName),
		compress1KB,
	))
	mux.Handle(grpcreflect.NewHandlerV1Alpha(
		grpcreflect.NewStaticReflector(abcsystemv1connect.AbcsystemServiceName),
		compress1KB,
	))
	allowedMap := make(map[string]bool)
	for _, origin := range s.config.AllowedOrigins {

		allowedMap[origin] = true
	}
	cors := cors.New(cors.Options{
		AllowedMethods: []string{
			http.MethodHead,
			http.MethodGet,
			http.MethodPost,
			http.MethodPut,
			http.MethodPatch,
			http.MethodDelete,
		},
		AllowOriginFunc: func(origin string) bool {
			// Allow all origins, which effectively disables CORS.
			allowed := allowedMap[origin]
			if !allowed && origin != "" {
				log.Printf("Blocked CORS origin: %s", origin)
				return false
			}
			return allowed
		},
		AllowedHeaders: []string{"*"},
		ExposedHeaders: []string{
			// Content-Type is in the default safelist.
			"Accept",
			"Accept-Encoding",
			"Accept-Post",
			"Connect-Accept-Encoding",
			"Connect-Content-Encoding",
			"Content-Encoding",
			"Grpc-Accept-Encoding",
			"Grpc-Encoding",
			"Grpc-Message",
			"Grpc-Status",
			"Grpc-Status-Details-Bin",
		},
		AllowCredentials: true,
		MaxAge:           int(2 * time.Hour / time.Second),
	})
	server := &http.Server{
		Addr:    s.config.GRPCServerAddress,
		Handler: h2c.NewHandler(cors.Handler(mux), &http2.Server{}),
	}
	return server

}
