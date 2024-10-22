package db

import (
	"context"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/rs/zerolog/log"
)

func InitDB(ctx context.Context, source string, isDevelopment bool) (Store, *pgxpool.Pool, error) {
	dbTracer := NewDbTracer(isDevelopment)

	dbConfig, err := pgxpool.ParseConfig(source)
	if err != nil {
		return nil, nil, err
	}

	dbConfig.ConnConfig.Tracer = dbTracer
	connPool, err := pgxpool.NewWithConfig(ctx, dbConfig)
	if err != nil {
		return nil, nil, err
	}
	// Attempt to ping the database to ensure the connection is working.
	if err := connPool.Ping(ctx); err != nil {
		connPool.Close()
		return nil, nil, err
	}
	log.Info().Str("DBSource", source).Msg("db connected")
	store := NewStore(connPool)

	return store, connPool, nil
}
