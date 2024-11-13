package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

type AccountsRepoInterface interface {
	UserNavigationBarFind(ctx context.Context, req db.UserNavigationBarFindParams) ([]db.UserNavigationBarFindRow, error)
	UserFind(ctx context.Context, req db.UserFindParams) (*db.AccountsSchemaUser, error)
	UserDeleteRestore(ctx context.Context, req db.UserDeleteRestoreParams) (*db.AccountsSchemaUser, error)
	UserDelete(ctx context.Context, req db.UserDeleteParams) (*db.AccountsSchemaUser, error)
	UserPermissionsMap(ctx context.Context, userID int32) (*[]db.UserPermissionsMapRow, error)
	UserCreateUpdate(ctx context.Context, req db.UserCreateUpdateParams) (*db.AccountsSchemaUser, error)
	UserList(ctx context.Context) (*[]db.AccountsSchemaUser, error)
	RoleList(ctx context.Context) (*[]db.AccountsSchemaRole, error)
	AuthUserIDFindByEmail(ctx context.Context, req string) (*string, error)
	RoleCreateUpdate(ctx context.Context, req db.RoleCreateUpdateParams) (*db.AccountsSchemaRole, error)
	RoleDeleteRestore(ctx context.Context, req []int32) error
}

type AccountsRepo struct {
	store        db.Store
	errorHandler map[string]string
}

func NewAccountsRepo(store db.Store) AccountsRepoInterface {
	errorHandler := map[string]string{
		"roles_role_name_key":  "roleName",
		"users_user_name_key":  "userName",
		"users_user_email_key": "userEmail",
		"users_user_phone_key": "userPhone",
	}
	return &AccountsRepo{
		store:        store,
		errorHandler: errorHandler,
	}
}
