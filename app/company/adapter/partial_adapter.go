package adapter

import (
	"strings"

	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *CompanyAdapter) PartialEntityGrpcFromSql(resp *db.CompaniesSchemaPartial) *devkitv1.CompaniesSchemaPartial {
	return &devkitv1.CompaniesSchemaPartial{
		PartialId:      int32(resp.PartialID),
		PartialName:    resp.PartialName,
		PartialTypeId:  resp.PartialTypeID,
		CompanyId:      int32(resp.CompanyID.Int32),
		PartialImage:   resp.PartialImage.String,
		PartialImages:  strings.Split(resp.PartialImages.String, ","),
		PartialVideo:   resp.PartialVideo.String,
		IsFeatured:     resp.IsFeatured.Bool,
		PartialBrief:   resp.PartialBrief.String,
		PartialContent: resp.PartialContent.String,
		CreatedAt:      db.TimeToProtoTimeStamp(resp.CreatedAt.Time),
		UpdatedAt:      db.TimeToProtoTimeStamp(resp.UpdatedAt.Time),
		DeletedAt:      db.TimeToProtoTimeStamp(resp.DeletedAt.Time),
	}
}

func (a *CompanyAdapter) PartialEntityListGrpcFromSql(resp *[]db.CompaniesSchemaPartial) *[]*devkitv1.CompaniesSchemaPartial {
	records := make([]*devkitv1.CompaniesSchemaPartial, 0)
	for _, v := range *resp {
		record := a.PartialEntityGrpcFromSql(&v)
		records = append(records, record)
	}
	return &records
}

func (a *CompanyAdapter) PartialListGrpcFromSql(resp *[]db.CompaniesSchemaPartial) *devkitv1.PartialListResponse {
	records := make([]*devkitv1.CompaniesSchemaPartial, 0)
	deletedRecords := make([]*devkitv1.CompaniesSchemaPartial, 0)
	for _, v := range *resp {
		record := a.PartialEntityGrpcFromSql(&v)
		if v.DeletedAt.Valid {
			deletedRecords = append(deletedRecords, record)
		} else {
			records = append(records, record)
		}
	}
	return &devkitv1.PartialListResponse{
		DeletedRecords: deletedRecords,
		Records:        records,
	}
}

func (a *CompanyAdapter) PartialCreateUpdateSqlFromGrpc(req *devkitv1.PartialCreateUpdateRequest) *db.PartialCreateUpdateParams {
	return &db.PartialCreateUpdateParams{
		PartialID:      req.GetPartialId(),
		PartialName:    req.GetPartialName(),
		PartialTypeID:  req.GetPartialTypeId(),
		CompanyID:      req.GetCompanyId(),
		PartialImage:   req.GetPartialImage(),
		PartialImages:  strings.Join(req.GetPartialImages(), ","),
		PartialVideo:   req.GetPartialVideo(),
		IsFeatured:     req.GetIsFeatured(),
		PartialBrief:   req.GetPartialBrief(),
		PartialContent: req.GetPartialContent(),
	}
}
