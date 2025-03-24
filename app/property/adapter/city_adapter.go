package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *PropertyAdapter) CityEntityGrpcFromSql(resp *db.PropertiesSchemaCity) *devkitv1.PropertiesSchemaCity {
	return &devkitv1.PropertiesSchemaCity{
		CityId:     int32(resp.CityID),
		CityName:   resp.CityName,
		CityNameAr: resp.CityNameAr.String,
		CityImage:  resp.CityImage.String,
		CreatedAt:  db.TimeToString(resp.CreatedAt.Time),
		UpdatedAt:  db.TimeToString(resp.UpdatedAt.Time),
		DeletedAt:  db.TimeToString(resp.DeletedAt.Time),
	}
}
func (a *PropertyAdapter) CityListGrpcFromSql(resp []db.PropertiesSchemaCity) *devkitv1.CityListResponse {

	records := make([]*devkitv1.PropertiesSchemaCity, 0)
	deletedRecords := make([]*devkitv1.PropertiesSchemaCity, 0)
	for _, v := range resp {
		record := a.CityEntityGrpcFromSql(&v)
		if v.DeletedAt.Valid {
			deletedRecords = append(deletedRecords, record)
		} else {
			records = append(records, record)
		}
	}
	return &devkitv1.CityListResponse{
		DeletedRecords: deletedRecords,
		Records:        records,
	}
}

func (a *PropertyAdapter) CityListInputGrpcFromSql(resp []db.CityListInputRow) *devkitv1.CityListInputResponse {
	records := make([]*devkitv1.SelectInputOption, 0)
	for _, v := range resp {
		records = append(records, &devkitv1.SelectInputOption{
			Value: v.Value,
			Label: v.Label,
		})
	}
	return &devkitv1.CityListInputResponse{
		Options: records,
	}

}
