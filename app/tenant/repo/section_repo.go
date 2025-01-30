package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/contextkeys"
)

func (repo *TenantRepo) SectionList(ctx context.Context, tenantId int32) (*[]db.TenantsSchemaSection, error) {
	loggedInUserTenantId, _ := contextkeys.TenantID(ctx)
	if loggedInUserTenantId > 0 {
		tenantId = loggedInUserTenantId
	}

	resp, err := repo.store.SectionList(ctx, tenantId)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *TenantRepo) SectionCreateUpdate(ctx context.Context, req *db.SectionCreateUpdateParams) (*db.TenantsSchemaSection, error) {
	loggedInUserTenantId, _ := contextkeys.TenantID(ctx)
	if loggedInUserTenantId > 0 {
		req.TenantID = loggedInUserTenantId
	}

	resp, err := repo.store.SectionCreateUpdate(ctx, *req)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *TenantRepo) SectionDeleteRestore(ctx context.Context, req *[]int32) (*[]db.TenantsSchemaSection, error) {

	resp, err := repo.store.SectionDeleteRestore(ctx, *req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
