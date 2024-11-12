package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

func (repo *PublicRepo) IconCreateUpdateBulk(ctx context.Context, req db.IconCreateUpdateBulkParams) (*[]db.Icon, error) {
	resp, err := repo.store.IconCreateUpdateBulk(context.Background(), req)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
func (repo *PublicRepo) IconList(ctx context.Context) (*[]db.Icon, error) {
	resp, err := repo.store.IconList(context.Background())

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
