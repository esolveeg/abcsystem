package repo

import (
	"context"
)

func (repo *PublicRepo) FileDelete(ctx context.Context, req []string) (string, error) {
	resp, err := repo.store.StorageFileDelete(context.Background(), req)
	if err != nil {
		return "", repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return resp, nil
}

func (repo *PublicRepo) FileDeleteByBucket(ctx context.Context, req []string, bucket string) (string, error) {
	resp, err := repo.store.StorageFileDeleteByBucket(context.Background(), req, bucket)
	if err != nil {
		return "", repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return resp, nil
}
