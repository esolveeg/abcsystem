package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

type AccountsRepoInterface interface {
	UsersDeleteRestore(ctx context.Context, req []int32) error
	UserCreateUpdate(ctx context.Context, req db.UserCreateUpdateParams) (*db.AccountsSchemaUser, error)
	UsersList(ctx context.Context) ([]db.AccountsSchemaUser, error)
	RolesList(ctx context.Context) ([]db.AccountsSchemaRole, error)
	RoleCreateUpdate(ctx context.Context, req db.RoleCreateUpdateParams) (*db.AccountsSchemaRole, error)
	RolesDeleteRestore(ctx context.Context, req []int32) error
}

type AccountsRepo struct {
	store db.Store
}

func NewAccountsRepo(store db.Store) AccountsRepoInterface {
	return &AccountsRepo{
		store: store,
	}
}
