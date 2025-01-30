package adapter

import (
	"strings"

	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *TenantAdapter) SectionEntityGrpcFromSql(resp *db.TenantsSchemaSection) *devkitv1.TenantsSchemaSection {
	return &devkitv1.TenantsSchemaSection{
		SectionId:            int32(resp.SectionID),
		SectionName:          resp.SectionName,
		SectionNameAr:        resp.SectionNameAr.String,
		SectionDescription:   resp.SectionDescription.String,
		SectionDescriptionAr: resp.SectionDescriptionAr.String,
		TenantId:            int32(resp.TenantID.Int32),   // Handle nullable int
		SectionBackground:    resp.SectionBackground.String, // updated
		SectionIcon:          resp.SectionIcon.String,
		CreatedAt:            db.TimeToProtoTimeStamp(resp.CreatedAt.Time),
		UpdatedAt:            db.TimeToProtoTimeStamp(resp.UpdatedAt.Time),
		DeletedAt:            db.TimeToProtoTimeStamp(resp.DeletedAt.Time),
		SectionImages:        strings.Split(resp.SectionImages.String, ","),
	}
}

func (a *TenantAdapter) SectionEntityListGrpcFromSql(resp *[]db.TenantsSchemaSection) *[]*devkitv1.TenantsSchemaSection {
	records := make([]*devkitv1.TenantsSchemaSection, 0)
	for _, v := range *resp {
		record := a.SectionEntityGrpcFromSql(&v)
		records = append(records, record)
	}
	return &records
}
func (a *TenantAdapter) SectionListGrpcFromSql(resp *[]db.TenantsSchemaSection) *devkitv1.SectionListResponse {
	records := make([]*devkitv1.TenantsSchemaSection, 0)
	deletedRecords := make([]*devkitv1.TenantsSchemaSection, 0)
	for _, v := range *resp {
		record := a.SectionEntityGrpcFromSql(&v)
		if v.DeletedAt.Valid {
			deletedRecords = append(deletedRecords, record)
		} else {
			records = append(records, record)
		}
	}
	return &devkitv1.SectionListResponse{
		DeletedRecords: deletedRecords,
		Records:        records,
	}
}

func (a *TenantAdapter) SectionCreateUpdateSqlFromGrpc(req *devkitv1.SectionCreateUpdateRequest) *db.SectionCreateUpdateParams {
	return &db.SectionCreateUpdateParams{
		SectionID:            req.GetSectionId(),
		SectionName:          req.GetSectionName(),
		SectionNameAr:        req.GetSectionNameAr(),
		SectionDescription:   req.GetSectionDescription(),
		SectionDescriptionAr: req.GetSectionDescriptionAr(),
		TenantID:            req.GetTenantId(),
		SectionBackground:    req.GetSectionBackground(),
		SectionIcon:          req.GetSectionIcon(),
		SectionImages:        strings.Join(req.GetSectionImages(), ",")}
}
