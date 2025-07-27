package db

import (
	"context"
	"os"

	"github.com/jackc/pgx/v5"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

type DbTracer struct {
	isDevelopment bool
}

func NewDbTracer(isDevelopment bool) *DbTracer {
	return &DbTracer{
		isDevelopment: isDevelopment,
	}
}

func (tracer *DbTracer) TraceQueryStart(
	ctx context.Context,
	_ *pgx.Conn,
	data pgx.TraceQueryStartData) context.Context {
	log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stderr})
	logger := log.Info()
	if tracer.isDevelopment {
		logger.Interface("arguments", data.Args).
			Str("query", data.SQL).
			Msg("DB Call Start")

	}
	return ctx
}

func (tracer *DbTracer) TraceQueryEnd(ctx context.Context, conn *pgx.Conn, data pgx.TraceQueryEndData) {
	log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stderr})
	logger := log.Info()
	if tracer.isDevelopment {
		logger.Interface("arguments", data).
			Err(data.Err).
			Msg("DB Call End")
	}
}
