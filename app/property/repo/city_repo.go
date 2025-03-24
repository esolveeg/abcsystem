package repo

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
)

func (repo *PropertyRepo) CityList(ctx context.Context) ([]db.PropertiesSchemaCity, error) {
	resp, err := repo.store.CityList(ctx)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return resp, nil
}
func (repo *PropertyRepo) CityListInput(ctx context.Context) ([]db.CityListInputRow, error) {
	resp, err := repo.store.CityListInput(ctx)

	if err != nil {
		return nil, repo.store.DbErrorParser(err, repo.errorHandler)
	}
	return resp, nil
}
