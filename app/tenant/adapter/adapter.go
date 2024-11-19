package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

type TenantAdapterInterface interface {
	PartialCreateUpdateSqlFromGrpc(req *devkitv1.PartialCreateUpdateRequest) *db.PartialCreateUpdateParams
	PartialListGrpcFromSql(resp *[]db.TenantsSchemaPartial) *devkitv1.PartialListResponse
	PartialEntityListGrpcFromSql(resp *[]db.TenantsSchemaPartial) *[]*devkitv1.TenantsSchemaPartial
	PartialEntityGrpcFromSql(resp *db.TenantsSchemaPartial) *devkitv1.TenantsSchemaPartial
	SectionEntityGrpcFromSql(resp *db.TenantsSchemaSection) *devkitv1.TenantsSchemaSection
	SectionEntityListGrpcFromSql(resp *[]db.TenantsSchemaSection) *[]*devkitv1.TenantsSchemaSection
	SectionListGrpcFromSql(resp *[]db.TenantsSchemaSection) *devkitv1.SectionListResponse
	SectionCreateUpdateSqlFromGrpc(req *devkitv1.SectionCreateUpdateRequest) *db.SectionCreateUpdateParams
	PageCreateUpdateSqlFromGrpc(req *devkitv1.PageCreateUpdateRequest) *db.PageCreateUpdateParams
	PageEntityGrpcFromSql(resp *db.TenantsSchemaPage) *devkitv1.TenantsSchemaPage
	PageListGrpcFromSql(resp *[]db.TenantsSchemaPage) *devkitv1.PageListResponse
	PageEntityListGrpcFromSql(req *[]db.TenantsSchemaPage) *[]*devkitv1.TenantsSchemaPage
	TenantDeleteRestoreGrpcFromSql(resp *[]db.TenantsSchemaTenant) *devkitv1.TenantDeleteRestoreResponse
	TenantListGrpcFromSql(resp *[]db.TenantsSchemaTenant) *devkitv1.TenantListResponse
	TenantEntityGrpcFromSql(resp *db.TenantsSchemaTenant) *devkitv1.TenantsSchemaTenant
	TenantCreateUpdateSqlFromGrpc(req *devkitv1.TenantCreateUpdateRequest) *db.TenantCreateUpdateParams
}

type TenantAdapter struct {
}

func NewTenantAdapter() TenantAdapterInterface {
	return &TenantAdapter{}
}
