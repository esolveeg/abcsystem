package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

func (repo *CompanyRepo) SectionList(ctx context.Context) (*[]db.CompaniesSchemaSection, error) {
	resp, err := repo.store.SectionList(ctx)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *CompanyRepo) SectionCreateUpdate(ctx context.Context, req *db.SectionCreateUpdateParams) (*db.CompaniesSchemaSection, error) {
	resp, err := repo.store.SectionCreateUpdate(ctx, *req)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *CompanyRepo) SectionDeleteRestore(ctx context.Context, req *[]int32) (*[]db.CompaniesSchemaSection, error) {
	resp, err := repo.store.SectionDeleteRestore(ctx, *req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
