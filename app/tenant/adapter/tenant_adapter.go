package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *TenantAdapter) TenantEntityGrpcFromSql(resp *db.TenantsSchemaTenant) *devkitv1.TenantsSchemaTenant {
	return &devkitv1.TenantsSchemaTenant{
		TenantId:               int32(resp.TenantID),
		TenantName:             resp.TenantName,
		TenantNameAr:           resp.TenantNameAr.String,
		TenantPhone:            resp.TenantPhone.String,
		TenantAddress:          resp.TenantAddress.String,
		TenantAddressAr:        resp.TenantAddressAr.String,
		TenantDescription:      resp.TenantDescription.String,
		TenantDescriptionAr:    resp.TenantDescriptionAr.String,
		TenantEmail:            resp.TenantEmail.String,
		TenantLogo:             resp.TenantLogo.String,
		TenantValues:           resp.TenantValues.String,
		TenantVision:           resp.TenantVision.String,
		TenantMission:          resp.TenantMission.String,
		TenantLogoVertical:     resp.TenantLogoVertical.String,
		TenantLogoDark:         resp.TenantLogoDark.String,
		TenantLogoDarkVertical: resp.TenantLogoDarkVertical.String,
		CreatedAt:               db.TimeToString(resp.CreatedAt.Time),
		DeletedAt:               db.TimeToString(resp.DeletedAt.Time),
	}
}

func (a *TenantAdapter) TenantCreateUpdateSqlFromGrpc(req *devkitv1.TenantCreateUpdateRequest) *db.TenantCreateUpdateParams {
	resp := &db.TenantCreateUpdateParams{
		TenantID:               req.TenantId,
		TenantName:             req.TenantName,
		TenantNameAr:           req.TenantNameAr,
		TenantPhone:            req.TenantPhone,
		TenantAddress:          req.TenantAddress,
		TenantAddressAr:        req.TenantAddressAr,
		TenantValues:           req.TenantValues,
		TenantVision:           req.TenantVision,
		TenantMission:          req.TenantMission,
		TenantEmail:            req.TenantEmail,
		TenantDescription:      req.TenantDescription,
		TenantDescriptionAr:    req.TenantDescriptionAr,
		TenantLogo:             req.TenantLogo,
		TenantLogoVertical:     req.TenantLogoVertical,
		TenantLogoDark:         req.TenantLogoDark,
		TenantLogoDarkVertical: req.TenantLogoDarkVertical,
	}
	return resp
}
func (a *TenantAdapter) TenantListGrpcFromSql(resp *[]db.TenantsSchemaTenant) *devkitv1.TenantListResponse {
	records := make([]*devkitv1.TenantsSchemaTenant, 0)
	deletedRecords := make([]*devkitv1.TenantsSchemaTenant, 0)
	for _, v := range *resp {
		record := a.TenantEntityGrpcFromSql(&v)
		if v.DeletedAt.Valid {
			deletedRecords = append(deletedRecords, record)
		} else {
			records = append(records, record)
		}
	}
	return &devkitv1.TenantListResponse{
		DeletedRecords: deletedRecords,
		Records:        records,
	}
}

func (a *TenantAdapter) TenantDeleteRestoreGrpcFromSql(resp *[]db.TenantsSchemaTenant) *devkitv1.TenantDeleteRestoreResponse {
	records := make([]*devkitv1.TenantsSchemaTenant, 0)
	for _, v := range *resp {
		record := a.TenantEntityGrpcFromSql(&v)
		records = append(records, record)
	}
	return &devkitv1.TenantDeleteRestoreResponse{
		Records: records,
	}

}
