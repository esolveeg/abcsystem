package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

type CompanyAdapterInterface interface {
	PartialCreateUpdateSqlFromGrpc(req *devkitv1.PartialCreateUpdateRequest) *db.PartialCreateUpdateParams
	PartialListGrpcFromSql(resp *[]db.CompaniesSchemaPartial) *devkitv1.PartialListResponse
	PartialEntityListGrpcFromSql(resp *[]db.CompaniesSchemaPartial) *[]*devkitv1.CompaniesSchemaPartial
	PartialEntityGrpcFromSql(resp *db.CompaniesSchemaPartial) *devkitv1.CompaniesSchemaPartial
	SectionEntityGrpcFromSql(resp *db.CompaniesSchemaSection) *devkitv1.CompaniesSchemaSection
	SectionEntityListGrpcFromSql(resp *[]db.CompaniesSchemaSection) *[]*devkitv1.CompaniesSchemaSection
	SectionListGrpcFromSql(resp *[]db.CompaniesSchemaSection) *devkitv1.SectionListResponse
	SectionCreateUpdateSqlFromGrpc(req *devkitv1.SectionCreateUpdateRequest) *db.SectionCreateUpdateParams
	PageCreateUpdateSqlFromGrpc(req *devkitv1.PageCreateUpdateRequest) *db.PageCreateUpdateParams
	PageEntityGrpcFromSql(resp *db.CompaniesSchemaPage) *devkitv1.CompaniesSchemaPage
	PageListGrpcFromSql(resp *[]db.CompaniesSchemaPage) *devkitv1.PageListResponse
	PageEntityListGrpcFromSql(req *[]db.CompaniesSchemaPage) *[]*devkitv1.CompaniesSchemaPage
	CompanyDeleteRestoreGrpcFromSql(resp *[]db.CompaniesSchemaCompany) *devkitv1.CompanyDeleteRestoreResponse
	CompanyListGrpcFromSql(resp *[]db.CompaniesSchemaCompany) *devkitv1.CompanyListResponse
	CompanyEntityGrpcFromSql(resp *db.CompaniesSchemaCompany) *devkitv1.CompaniesSchemaCompany
	CompanyCreateUpdateSqlFromGrpc(req *devkitv1.CompanyCreateUpdateRequest) *db.CompanyCreateUpdateParams
}

type CompanyAdapter struct {
}

func NewCompanyAdapter() CompanyAdapterInterface {
	return &CompanyAdapter{}
}
