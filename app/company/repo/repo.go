package repo

import (
	// INJECT IMPORTS
	"context"

	"github.com/darwishdev/devkit-api/db"
)

type CompanyRepoInterface interface {
	PartialDeleteRestore(ctx context.Context, req *[]int32) (*[]db.CompaniesSchemaPartial, error)
	PartialCreateUpdate(ctx context.Context, req *db.PartialCreateUpdateParams) (*db.CompaniesSchemaPartial, error)
	PartialList(ctx context.Context) (*[]db.CompaniesSchemaPartial, error)
	// INJECT INTERFACE
	SectionDeleteRestore(ctx context.Context, req *[]int32) (*[]db.CompaniesSchemaSection, error)
	SectionCreateUpdate(ctx context.Context, req *db.SectionCreateUpdateParams) (*db.CompaniesSchemaSection, error)
	SectionList(ctx context.Context) (*[]db.CompaniesSchemaSection, error)
	PageDeleteRestore(ctx context.Context, req *[]int32) (*[]db.CompaniesSchemaPage, error)
	PageCreateUpdate(ctx context.Context, req *db.PageCreateUpdateParams) (*db.CompaniesSchemaPage, error)
	PageList(ctx context.Context) (*[]db.CompaniesSchemaPage, error)
	CompanyDeleteRestore(ctx context.Context, req []int32) (*[]db.CompaniesSchemaCompany, error)
	CompanyList(ctx context.Context, companyId int32) (*[]db.CompaniesSchemaCompany, error)
	CompanyCreateUpdate(ctx context.Context, req *db.CompanyCreateUpdateParams) (*db.CompaniesSchemaCompany, error)
}

type CompanyRepo struct {
	store        db.Store
	errorHandler map[string]string
}

func NewCompanyRepo(store db.Store) CompanyRepoInterface {
	errorHandler := map[string]string{
		// INJECT ERROR
	}
	return &CompanyRepo{
		store:        store,
		errorHandler: errorHandler,
	}
}
