package api

import (
	"context"
	"strings"
	"time"

	"connectrpc.com/connect"
	"github.com/rs/zerolog/log"
)

// Extract action name from function
func (s *Server) extractAction(fn string) string {
	fn = strings.ToLower(fn)
	switch {
	case strings.Contains(fn, "create"):
		return "create"
	case strings.Contains(fn, "update"):
		return "update"
	case strings.Contains(fn, "deleterestore"):
		return "restore"
	case strings.Contains(fn, "delete"):
		return "delete"
	default:
		return "unknown"
	}
}

// Print dev logs for local inspection
func (s *Server) printDevLog(
	req connect.AnyRequest,
	result connect.AnyResponse,
	duration time.Duration,
) {
	log.Info().
		Str("procedure", req.Spec().Procedure).
		Interface("request", req.Any()).
		Interface("response", result).
		Dur("duration", duration).
		Msg("gRPC request handled")
}

func (s *Server) printErrorLog(
	req connect.AnyRequest,
	result connect.AnyResponse,
	duration time.Duration,
) {
	log.Info().
		Str("procedure", req.Spec().Procedure).
		Interface("request", req.Any()).
		Interface("response", result).
		Dur("duration", duration).
		Msg("gRPC request handled")
}

// Interceptor for logging all gRPC calls
func (s *Server) NewLoggerInterceptor() connect.UnaryInterceptorFunc {
	return connect.UnaryInterceptorFunc(func(next connect.UnaryFunc) connect.UnaryFunc {
		return connect.UnaryFunc(func(ctx context.Context, req connect.AnyRequest) (connect.AnyResponse, error) {
			startTime := time.Now()
			result, err := next(ctx, req)
			duration := time.Since(startTime)
			if err != nil {
				s.printErrorLog(req, result, duration)
				return result, err
			}

			if s.config.State == "dev" {
				s.printDevLog(req, result, duration)
			}
			return result, nil
		})
	})
}
