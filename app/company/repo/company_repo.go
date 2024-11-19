package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/contextkeys"
	"github.com/rs/zerolog/log"
)

func (repo *CompanyRepo) CompanyCreateUpdate(ctx context.Context, req *db.CompanyCreateUpdateParams) (*db.CompaniesSchemaCompany, error) {
	resp, err := repo.store.CompanyCreateUpdate(ctx, *req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}

func (repo *CompanyRepo) CompanyList(ctx context.Context, companyId int32) (*[]db.CompaniesSchemaCompany, error) {

	tenateID, _ := contextkeys.TenantID(ctx)
	log.Debug().Interface("T", tenateID).Msg("repo")
	if tenateID > 0 {
		companyId = tenateID
	}
	resp, err := repo.store.CompanyList(ctx, companyId)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}

func (repo *CompanyRepo) CompanyDeleteRestore(ctx context.Context, req []int32) (*[]db.CompaniesSchemaCompany, error) {
	resp, err := repo.store.CompanyDeleteRestore(ctx, req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
