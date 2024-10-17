package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

func (repo *AccountsRepo) UsersList(ctx context.Context) ([]db.AccountsSchemaUser, error) {
	resp, err := repo.store.UsersList(context.Background())
	if err != nil {
		return nil, err
	}
	return resp, nil
}
func (repo *AccountsRepo) UserCreateUpdate(ctx context.Context, req db.UserCreateUpdateParams) (*db.AccountsSchemaUser, error) {
	resp, err := repo.store.UserCreateUpdate(context.Background(), req)
	if err != nil {
		return nil, err
	}
	return &resp, nil
}

func (repo *AccountsRepo) AuthUserIDFindByEmail(ctx context.Context, req string) (*string, error) {
	id, err := repo.store.AuthUserIDFindByEmail(context.Background(), req)
	if err != nil {
		return nil, err
	}

	return &id, nil
}
func (repo *AccountsRepo) UsersDeleteRestore(ctx context.Context, req []int32) error {
	err := repo.store.UsersDeleteRestore(context.Background(), req)
	if err != nil {
		return err
	}
	return nil
}
func (repo *AccountsRepo) UserFind(ctx context.Context, req db.UserFindParams) (*db.AccountsSchemaUser, error) {
	resp, err := repo.store.UserFind(context.Background(), req)
	if err != nil {
		return nil, err
	}
	return &resp, nil
}
