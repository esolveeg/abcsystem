package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *CompanyAdapter) CompanyEntityGrpcFromSql(resp *db.CompaniesSchemaCompany) *devkitv1.CompaniesSchemaCompany {
	return &devkitv1.CompaniesSchemaCompany{
		CompanyId:               int32(resp.CompanyID),
		CompanyName:             resp.CompanyName,
		CompanyNameAr:           resp.CompanyNameAr.String,
		CompanyPhone:            resp.CompanyPhone.String,
		CompanyAddress:          resp.CompanyAddress.String,
		CompanyAddressAr:        resp.CompanyAddressAr.String,
		CompanyDescription:      resp.CompanyDescription.String,
		CompanyDescriptionAr:    resp.CompanyDescriptionAr.String,
		CompanyEmail:            resp.CompanyEmail.String,
		CompanyLogo:             resp.CompanyLogo.String,
		CompanyValues:           resp.CompanyValues.String,
		CompanyVision:           resp.CompanyVision.String,
		CompanyMission:          resp.CompanyMission.String,
		CompanyLogoVertical:     resp.CompanyLogoVertical.String,
		CompanyLogoDark:         resp.CompanyLogoDark.String,
		CompanyLogoDarkVertical: resp.CompanyLogoDarkVertical.String,
		CreatedAt:               db.TimeToString(resp.CreatedAt.Time),
		DeletedAt:               db.TimeToString(resp.DeletedAt.Time),
	}
}

func (a *CompanyAdapter) CompanyCreateUpdateSqlFromGrpc(req *devkitv1.CompanyCreateUpdateRequest) *db.CompanyCreateUpdateParams {
	resp := &db.CompanyCreateUpdateParams{
		CompanyID:               req.CompanyId,
		CompanyName:             req.CompanyName,
		CompanyNameAr:           req.CompanyNameAr,
		CompanyPhone:            req.CompanyPhone,
		CompanyAddress:          req.CompanyAddress,
		CompanyAddressAr:        req.CompanyAddressAr,
		CompanyValues:           req.CompanyValues,
		CompanyVision:           req.CompanyVision,
		CompanyMission:          req.CompanyMission,
		CompanyEmail:            req.CompanyEmail,
		CompanyDescription:      req.CompanyDescription,
		CompanyDescriptionAr:    req.CompanyDescriptionAr,
		CompanyLogo:             req.CompanyLogo,
		CompanyLogoVertical:     req.CompanyLogoVertical,
		CompanyLogoDark:         req.CompanyLogoDark,
		CompanyLogoDarkVertical: req.CompanyLogoDarkVertical,
	}
	return resp
}
func (a *CompanyAdapter) CompanyListGrpcFromSql(resp *[]db.CompaniesSchemaCompany) *devkitv1.CompanyListResponse {
	records := make([]*devkitv1.CompaniesSchemaCompany, 0)
	deletedRecords := make([]*devkitv1.CompaniesSchemaCompany, 0)
	for _, v := range *resp {
		record := a.CompanyEntityGrpcFromSql(&v)
		if v.DeletedAt.Valid {
			deletedRecords = append(deletedRecords, record)
		} else {
			records = append(records, record)
		}
	}
	return &devkitv1.CompanyListResponse{
		DeletedRecords: deletedRecords,
		Records:        records,
	}
}

func (a *CompanyAdapter) CompanyDeleteRestoreGrpcFromSql(resp *[]db.CompaniesSchemaCompany) *devkitv1.CompanyDeleteRestoreResponse {
	records := make([]*devkitv1.CompaniesSchemaCompany, 0)
	for _, v := range *resp {
		record := a.CompanyEntityGrpcFromSql(&v)
		records = append(records, record)
	}
	return &devkitv1.CompanyDeleteRestoreResponse{
		Records: records,
	}

}
