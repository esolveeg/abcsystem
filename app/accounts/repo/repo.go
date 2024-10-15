package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

type AccountsRepoInterface interface {
	RoleCreateUpdate(ctx context.Context, req db.RoleCreateUpdateParams) (*db.AccountsSchemaRole, error)
}

type AccountsRepo struct {
	store db.Store
}

func NewAccountsRepo(store db.Store) AccountsRepoInterface {
	return &AccountsRepo{
		store: store,
	}
}
