package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

type PropertyAdapterInterface interface {
	// INJECT INTERFACE

	CityListInputGrpcFromSql(resp []db.CityListInputRow) *devkitv1.CityListInputResponse
	CityListGrpcFromSql(resp []db.PropertiesSchemaCity) *devkitv1.CityListResponse
	LocationListGrpcFromSql(resp []db.PropertiesSchemaLocation) *devkitv1.LocationListResponse
	LocationEntityGrpcFromSql(resp *db.PropertiesSchemaLocation) *devkitv1.PropertiesSchemaLocation
	LocationListInputGrpcFromSql(resp []db.LocationListInputRow) *devkitv1.LocationListInputResponse
}

type PropertyAdapter struct {
}

func NewPropertyAdapter() PropertyAdapterInterface {
	return &PropertyAdapter{}
}
