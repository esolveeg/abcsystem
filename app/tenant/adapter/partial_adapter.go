package adapter

import (
	"strings"

	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *TenantAdapter) PartialEntityGrpcFromSql(resp *db.TenantsSchemaPartial) *devkitv1.TenantsSchemaPartial {
	return &devkitv1.TenantsSchemaPartial{
		PartialId:      int32(resp.PartialID),
		PartialName:    resp.PartialName,
		PartialTypeId:  resp.PartialTypeID,
		TenantId:      int32(resp.TenantID.Int32),
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

func (a *TenantAdapter) PartialEntityListGrpcFromSql(resp *[]db.TenantsSchemaPartial) *[]*devkitv1.TenantsSchemaPartial {
	records := make([]*devkitv1.TenantsSchemaPartial, 0)
	for _, v := range *resp {
		record := a.PartialEntityGrpcFromSql(&v)
		records = append(records, record)
	}
	return &records
}

func (a *TenantAdapter) PartialListGrpcFromSql(resp *[]db.TenantsSchemaPartial) *devkitv1.PartialListResponse {
	records := make([]*devkitv1.TenantsSchemaPartial, 0)
	deletedRecords := make([]*devkitv1.TenantsSchemaPartial, 0)
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

func (a *TenantAdapter) PartialCreateUpdateSqlFromGrpc(req *devkitv1.PartialCreateUpdateRequest) *db.PartialCreateUpdateParams {
	return &db.PartialCreateUpdateParams{
		PartialID:      req.GetPartialId(),
		PartialName:    req.GetPartialName(),
		PartialTypeID:  req.GetPartialTypeId(),
		TenantID:      req.GetTenantId(),
		PartialImage:   req.GetPartialImage(),
		PartialImages:  strings.Join(req.GetPartialImages(), ","),
		PartialVideo:   req.GetPartialVideo(),
		IsFeatured:     req.GetIsFeatured(),
		PartialBrief:   req.GetPartialBrief(),
		PartialContent: req.GetPartialContent(),
	}
}
