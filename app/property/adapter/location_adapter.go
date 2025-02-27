package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *PropertyAdapter) LocationEntityGrpcFromSql(resp *db.PropertiesSchemaLocation) *devkitv1.PropertiesSchemaLocation {
	return &devkitv1.PropertiesSchemaLocation{
		LocationId:     int32(resp.LocationID),
		LocationName:   resp.LocationName,
		LocationNameAr: resp.LocationNameAr,
		LocationImage:  resp.LocationImage.String,
		CreatedAt:      db.TimeToString(resp.CreatedAt.Time),
		UpdatedAt:      db.TimeToString(resp.UpdatedAt.Time),
		DeletedAt:      db.TimeToString(resp.DeletedAt.Time),
	}
}
func (a *PropertyAdapter) LocationListGrpcFromSql(resp []db.PropertiesSchemaLocation) *devkitv1.LocationListResponse {

	records := make([]*devkitv1.PropertiesSchemaLocation, 0)
	deletedRecords := make([]*devkitv1.PropertiesSchemaLocation, 0)
	for _, v := range resp {
		record := a.LocationEntityGrpcFromSql(&v)
		if v.DeletedAt.Valid {
			deletedRecords = append(deletedRecords, record)
		} else {
			records = append(records, record)
		}
	}
	return &devkitv1.LocationListResponse{
		DeletedRecords: deletedRecords,
		Records:        records,
	}
}

func (a *PropertyAdapter) LocationListInputGrpcFromSql(resp []db.LocationListInputRow) *devkitv1.LocationListInputResponse {
	records := make([]*devkitv1.SelectInputOption, 0)
	for _, v := range resp {
		records = append(records, &devkitv1.SelectInputOption{
			Value: v.Value,
			Label: v.Label,
		})
	}
	return &devkitv1.LocationListInputResponse{
		Options: records,
	}

}
