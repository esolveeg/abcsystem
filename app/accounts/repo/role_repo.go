package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/contextkeys"
)

func (repo *AccountsRepo) RoleList(ctx context.Context) (*[]db.AccountsSchemaRole, error) {
	resp, err := repo.store.RoleList(context.Background())
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *AccountsRepo) RoleCreateUpdate(ctx context.Context, req db.RoleCreateUpdateParams) (*db.AccountsSchemaRole, error) {
	callerId, ok := contextkeys.CallerID(ctx)
	if ok {
		req.CalledByUserID = callerId
	}
	resp, err := repo.store.RoleCreateUpdate(context.Background(), req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *AccountsRepo) RoleDeleteRestore(ctx context.Context, req []int32) error {
	err := repo.store.RoleDeleteRestore(context.Background(), req)
	if err != nil {
		return repo.store.DbErrorParser(err, repo.errorHandler)

	}
	return nil
}
