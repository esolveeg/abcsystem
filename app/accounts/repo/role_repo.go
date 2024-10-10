package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/gen/db"
)

func (repo *AccountsRepo) RoleCreate(ctx context.Context, req db.RoleCreateParams) (*db.AccountsSchemaRole, error) {
	resp, err := repo.store.RoleCreate(context.Background(), req)
	if err != nil {
		return nil, err
	}
	return &resp, nil
}
