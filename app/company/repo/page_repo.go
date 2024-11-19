package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

func (repo *CompanyRepo) PageList(ctx context.Context) (*[]db.CompaniesSchemaPage, error) {
	resp, err := repo.store.PageList(ctx)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *CompanyRepo) PageCreateUpdate(ctx context.Context, req *db.PageCreateUpdateParams) (*db.CompaniesSchemaPage, error) {
	resp, err := repo.store.PageCreateUpdate(ctx, *req)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *CompanyRepo) PageDeleteRestore(ctx context.Context, req *[]int32) (*[]db.CompaniesSchemaPage, error) {
	resp, err := repo.store.PageDeleteRestore(ctx, *req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
