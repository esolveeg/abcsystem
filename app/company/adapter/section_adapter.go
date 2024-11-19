package adapter

import (
	"strings"

	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *CompanyAdapter) SectionEntityGrpcFromSql(resp *db.CompaniesSchemaSection) *devkitv1.CompaniesSchemaSection {
	return &devkitv1.CompaniesSchemaSection{
		SectionId:            int32(resp.SectionID),
		SectionName:          resp.SectionName,
		SectionNameAr:        resp.SectionNameAr.String,
		SectionDescription:   resp.SectionDescription.String,
		SectionDescriptionAr: resp.SectionDescriptionAr.String,
		CompanyId:            int32(resp.CompanyID.Int32),   // Handle nullable int
		SectionBackground:    resp.SectionBackground.String, // updated
		SectionIcon:          resp.SectionIcon.String,
		CreatedAt:            db.TimeToProtoTimeStamp(resp.CreatedAt.Time),
		UpdatedAt:            db.TimeToProtoTimeStamp(resp.UpdatedAt.Time),
		DeletedAt:            db.TimeToProtoTimeStamp(resp.DeletedAt.Time),
		SectionImages:        strings.Split(resp.SectionImages.String, ","),
	}
}

func (a *CompanyAdapter) SectionEntityListGrpcFromSql(resp *[]db.CompaniesSchemaSection) *[]*devkitv1.CompaniesSchemaSection {
	records := make([]*devkitv1.CompaniesSchemaSection, 0)
	for _, v := range *resp {
		record := a.SectionEntityGrpcFromSql(&v)
		records = append(records, record)
	}
	return &records
}
func (a *CompanyAdapter) SectionListGrpcFromSql(resp *[]db.CompaniesSchemaSection) *devkitv1.SectionListResponse {
	records := make([]*devkitv1.CompaniesSchemaSection, 0)
	deletedRecords := make([]*devkitv1.CompaniesSchemaSection, 0)
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

func (a *CompanyAdapter) SectionCreateUpdateSqlFromGrpc(req *devkitv1.SectionCreateUpdateRequest) *db.SectionCreateUpdateParams {
	return &db.SectionCreateUpdateParams{
		SectionID:            req.GetSectionId(),
		SectionName:          req.GetSectionName(),
		SectionNameAr:        req.GetSectionNameAr(),
		SectionDescription:   req.GetSectionDescription(),
		SectionDescriptionAr: req.GetSectionDescriptionAr(),
		CompanyID:            req.GetCompanyId(),
		SectionBackground:    req.GetSectionBackground(),
		SectionIcon:          req.GetSectionIcon(),
		SectionImages:        strings.Join(req.GetSectionImages(), ",")}
}
