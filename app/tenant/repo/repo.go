package repo

import (
	// INJECT IMPORTS
	"context"

	"github.com/darwishdev/devkit-api/db"
)

type TenantRepoInterface interface {
	PartialDeleteRestore(ctx context.Context, req *[]int32) (*[]db.TenantsSchemaPartial, error)
	PartialCreateUpdate(ctx context.Context, req *db.PartialCreateUpdateParams) (*db.TenantsSchemaPartial, error)
	PartialList(ctx context.Context, tenantId int32) (*[]db.TenantsSchemaPartial, error)
	// INJECT INTERFACE
	SectionDeleteRestore(ctx context.Context, req *[]int32) (*[]db.TenantsSchemaSection, error)
	SectionCreateUpdate(ctx context.Context, req *db.SectionCreateUpdateParams) (*db.TenantsSchemaSection, error)
	SectionList(ctx context.Context, tenantId int32) (*[]db.TenantsSchemaSection, error)
	PageDeleteRestore(ctx context.Context, req *[]int32) (*[]db.TenantsSchemaPage, error)
	PageCreateUpdate(ctx context.Context, req *db.PageCreateUpdateParams) (*db.TenantsSchemaPage, error)
	PageList(ctx context.Context, tenantId int32) (*[]db.TenantsSchemaPage, error)
	TenantDeleteRestore(ctx context.Context, req []int32) (*[]db.TenantsSchemaTenant, error)
	TenantList(ctx context.Context, tenantId int32) (*[]db.TenantsSchemaTenant, error)
	TenantCreateUpdate(ctx context.Context, req *db.TenantCreateUpdateParams) (*db.TenantsSchemaTenant, error)
}

type TenantRepo struct {
	store        db.Store
	errorHandler map[string]string
}

func NewTenantRepo(store db.Store) TenantRepoInterface {
	errorHandler := map[string]string{
		// INJECT ERROR
	}
	return &TenantRepo{
		store:        store,
		errorHandler: errorHandler,
	}
}
