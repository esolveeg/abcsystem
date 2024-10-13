package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

type AccountsRepoInterface interface {
	RoleCreate(ctx context.Context, req db.RoleCreateParams) (*db.AccountsSchemaRole, error)
}

type AccountsRepo struct {
	store db.Store
}

func NewAccountsRepo(store db.Store) AccountsRepoInterface {
	return &AccountsRepo{
		store: store,
	}
}
