package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

func (repo *CompanyRepo) PartialList(ctx context.Context) (*[]db.CompaniesSchemaPartial, error) {
	resp, err := repo.store.PartialList(ctx)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *CompanyRepo) PartialCreateUpdate(ctx context.Context, req *db.PartialCreateUpdateParams) (*db.CompaniesSchemaPartial, error) {
	resp, err := repo.store.PartialCreateUpdate(ctx, *req)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *CompanyRepo) PartialDeleteRestore(ctx context.Context, req *[]int32) (*[]db.CompaniesSchemaPartial, error) {
	resp, err := repo.store.PartialDeleteRestore(ctx, *req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
