package repo

import (
	// INJECT IMPORTS
	"context"

	"github.com/darwishdev/devkit-api/db"
)

type PropertyRepoInterface interface {
	// INJECT INTERFACE
	CityListInput(ctx context.Context) ([]db.CityListInputRow, error)
	CityList(ctx context.Context) ([]db.PropertiesSchemaCity, error)
	LocationListInput(ctx context.Context, req int32) ([]db.LocationListInputRow, error)
	LocationList(ctx context.Context) ([]db.PropertiesSchemaLocation, error)
}

type PropertyRepo struct {
	store        db.Store
	errorHandler map[string]string
}

func NewPropertyRepo(store db.Store) PropertyRepoInterface {
	errorHandler := map[string]string{
		// INJECT ERROR
		"cities_city_name_key":    "cityName",
		"cities_city_name_ar_key": "cityNameAr",
	}
	return &PropertyRepo{
		store:        store,
		errorHandler: errorHandler,
	}
}
