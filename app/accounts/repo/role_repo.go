package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

func (repo *AccountsRepo) RoleCreateUpdate(ctx context.Context, req db.RoleCreateUpdateParams) (*db.AccountsSchemaRole, error) {
	resp, err := repo.store.RoleCreateUpdate(context.Background(), req)
	if err != nil {
		return nil, err
	}
	return &resp, nil
}
