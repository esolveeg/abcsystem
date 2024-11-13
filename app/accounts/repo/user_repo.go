package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/contextkeys"
)

func (repo *AccountsRepo) UserNavigationBarFind(ctx context.Context, req db.UserNavigationBarFindParams) ([]db.UserNavigationBarFindRow, error) {
	resp, err := repo.store.UserNavigationBarFind(context.Background(), req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return resp, nil
}

func (repo *AccountsRepo) UserDelete(ctx context.Context, req db.UserDeleteParams) (*db.AccountsSchemaUser, error) {
	resp, err := repo.store.UserDelete(context.Background(), req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}

func (repo *AccountsRepo) UserList(ctx context.Context) (*[]db.AccountsSchemaUser, error) {
	resp, err := repo.store.UserList(context.Background())
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *AccountsRepo) UserCreateUpdate(ctx context.Context, req db.UserCreateUpdateParams) (*db.AccountsSchemaUser, error) {
	callerId, ok := contextkeys.CallerID(ctx)
	if ok {
		req.CallerID = callerId
	}
	resp, err := repo.store.UserCreateUpdate(context.Background(), req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}

func (repo *AccountsRepo) AuthUserIDFindByEmail(ctx context.Context, req string) (*string, error) {
	id, err := repo.store.AuthUserIDFindByEmail(context.Background(), req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}

	return &id, nil
}
func (repo *AccountsRepo) UserDeleteRestore(ctx context.Context, req db.UserDeleteRestoreParams) (*db.AccountsSchemaUser, error) {
	resp, err := repo.store.UserDeleteRestore(context.Background(), req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *AccountsRepo) UserFind(ctx context.Context, req db.UserFindParams) (*db.AccountsSchemaUser, error) {
	resp, err := repo.store.UserFind(context.Background(), req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *AccountsRepo) UserPermissionsMap(ctx context.Context, userID int32) (*[]db.UserPermissionsMapRow, error) {
	resp, err := repo.store.UserPermissionsMap(context.Background(), userID)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
