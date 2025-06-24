package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/contextkeys"
)

func (repo *AccountsRepo) UserListInput(ctx context.Context) (*[]db.UserListInputRow, error) {
	callerID, _ := contextkeys.CallerID(ctx)
	resp, err := repo.store.UserListInput(ctx, callerID)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}

func (repo *AccountsRepo) UserTypeListInput(ctx context.Context) (*[]db.UserTypeListInputRow, error) {
	resp, err := repo.store.UserTypeListInput(ctx)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}

func (repo *AccountsRepo) UserFindForToken(ctx context.Context, req *db.UserFindForTokenParams) (*db.UserFindForTokenRow, error) {
	resp, err := repo.store.UserFindForToken(ctx, *req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *AccountsRepo) UseriFindForUpdate(ctx context.Context, req int32) (*db.UserFindForUpdateRow, error) {
	resp, err := repo.store.UserFindForUpdate(ctx, req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *AccountsRepo) UserNavigationBarFind(ctx context.Context, req db.UserNavigationBarFindParams) (*[]db.UserNavigationBarFindRow, error) {
	resp, err := repo.store.UserNavigationBarFind(ctx, req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}

func (repo *AccountsRepo) UserDelete(ctx context.Context, req db.UserDeleteParams) (*db.AccountsSchemaUser, error) {
	callerId, ok := contextkeys.CallerID(ctx)
	if ok {
		req.CallerID = callerId
	}
	resp, err := repo.store.UserDelete(ctx, req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}

func (repo *AccountsRepo) UserList(ctx context.Context) (*[]db.AccountsSchemaUserView, error) {
	resp, err := repo.store.UserList(ctx)
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
	resp, err := repo.store.UserCreateUpdate(ctx, req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}

func (repo *AccountsRepo) AuthUserIDFindByEmail(ctx context.Context, req string) (*string, error) {
	id, err := repo.store.AuthUserIDFindByEmail(ctx, req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}

	return &id, nil
}
func (repo *AccountsRepo) UserDeleteRestore(ctx context.Context, req db.UserDeleteRestoreParams) (*db.AccountsSchemaUser, error) {
	callerId, ok := contextkeys.CallerID(ctx)
	if ok {
		req.CallerID = callerId
	}
	resp, err := repo.store.UserDeleteRestore(ctx, req)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *AccountsRepo) UserFind(ctx context.Context, req db.UserFindParams) (*db.AccountsSchemaUser, error) {
	resp, err := repo.store.UserFind(ctx, req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *AccountsRepo) UserPermissionsMap(ctx context.Context, userID int32) (*[]db.UserPermissionsMapRow, error) {
	resp, err := repo.store.UserPermissionsMap(ctx, userID)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
