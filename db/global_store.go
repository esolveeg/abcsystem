package db

import (
	"context"

	"connectrpc.com/connect"
	"github.com/jackc/pgx/v5/pgxpool"
)

// Store defines all functions to execute db queries and transactions
type Store interface {
	Querier
	ExecTX(ctx context.Context, fn func(*Queries) error) error
	AuthUserIDFindByEmail(ctx context.Context, email string) (string, error)
	DbErrorParser(err error, errorHandler map[string]string) *connect.Error
}

// Store provides all functions to execute SQL queries and transactions
type SQLStore struct {
	connPool *pgxpool.Pool
	*Queries
}

// NewStore creates a new store
func NewStore(connPool *pgxpool.Pool) Store {
	return &SQLStore{
		connPool: connPool,
		Queries:  New(connPool),
	}
}
