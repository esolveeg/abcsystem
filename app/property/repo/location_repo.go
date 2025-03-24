package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

func (repo *PropertyRepo) LocationList(ctx context.Context) ([]db.PropertiesSchemaLocation, error) {
	resp, err := repo.store.LocationList(ctx)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return resp, nil
}

func (repo *PropertyRepo) LocationListInput(ctx context.Context, req db.LocationListInputParams) ([]db.LocationListInputRow, error) {
	resp, err := repo.store.LocationListInput(ctx, req)
	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return resp, nil
}
