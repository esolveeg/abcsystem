package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

func (repo *PublicRepo) IconsInputList(ctx context.Context) (*[]db.Icon, error) {
	resp, err := repo.store.IconsInputList(context.Background())

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return &resp, nil
}
