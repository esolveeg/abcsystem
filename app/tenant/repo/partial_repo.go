package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/contextkeys"
)

func (repo *TenantRepo) PartialList(ctx context.Context, tenantId int32) (*[]db.TenantsSchemaPartial, error) {
	loggedInUserTenantId, _ := contextkeys.TenantID(ctx)
	if loggedInUserTenantId > 0 {
		tenantId = loggedInUserTenantId
	}

	resp, err := repo.store.PartialList(ctx, tenantId)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *TenantRepo) PartialCreateUpdate(ctx context.Context, req *db.PartialCreateUpdateParams) (*db.TenantsSchemaPartial, error) {
	resp, err := repo.store.PartialCreateUpdate(ctx, *req)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *TenantRepo) PartialDeleteRestore(ctx context.Context, req *[]int32) (*[]db.TenantsSchemaPartial, error) {
	resp, err := repo.store.PartialDeleteRestore(ctx, *req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
