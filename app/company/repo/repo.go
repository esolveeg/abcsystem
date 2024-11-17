package repo

import (
	// INJECT IMPORTS
	"context"
	"github.com/darwishdev/devkit-api/db"
)

type CompanyRepoInterface interface {
	// INJECT INTERFACE
	CompanyDeleteRestore(ctx context.Context, req []int32) (*[]db.CompaniesSchemaCompany, error)

	CompanyList(ctx context.Context) (*[]db.CompaniesSchemaCompany, error)
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
