package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

type CompanyAdapterInterface interface {
	// INJECT INTERFACE

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
