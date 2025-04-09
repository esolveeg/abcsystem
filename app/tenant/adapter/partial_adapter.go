package adapter

import (
	"encoding/json"
	"strings"

	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
)

func (a *TenantAdapter) PartialEntityGrpcFromSql(resp *db.TenantsSchemaPartial) *devkitv1.TenantsSchemaPartial {
	var partialLinks map[string]string
	if len(resp.PartialLinks) > 0 {
		if err := json.Unmarshal(resp.PartialLinks, &partialLinks); err == nil {
			log.Error().Err(err).Msg("error parsing partial links")
		}
	}
	return &devkitv1.TenantsSchemaPartial{
		PartialId:            int32(resp.PartialID),
		PartialName:          resp.PartialName,
		PartialNameAr:        resp.PartialNameAr.String,
		PartialTypeId:        resp.PartialTypeID,
		SectionId:            int32(resp.SectionID),
		PartialImage:         resp.PartialImage.String,
		PartialImages:        strings.Split(resp.PartialImages.String, ","),
		PartialVideo:         resp.PartialVideo.String,
		IsFeatured:           resp.IsFeatured.Bool,
		PartialBrief:         resp.PartialBrief.String,
		PartialBriefAr:       resp.PartialBriefAr.String,
		PartialContent:       resp.PartialContent.String,
		PartialContentAr:     resp.PartialContentAr.String,
		PartialButtonLabel:   resp.PartialButtonLabel.String,
		PartialButtonLabelAr: resp.PartialButtonLabelAr.String,
		PartialButtonIcon:    resp.PartialButtonIcon.String,
		PartialButtonLink:    resp.PartialButtonLink.String,

		PartialButtonPageId: int32(resp.PartialButtonPageID.Int32),
		PartialIcons:        strings.Split(resp.PartialIcons.String, ","),
		Address:             resp.Address.String,
		PartialLinks:        partialLinks,
		PartialLink:         resp.PartialLink.String,
		CreatedAt:           db.TimeToProtoTimeStamp(resp.CreatedAt.Time),
		UpdatedAt:           db.TimeToProtoTimeStamp(resp.UpdatedAt.Time),
		DeletedAt:           db.TimeToProtoTimeStamp(resp.DeletedAt.Time),
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
	partialLinks, err := json.Marshal(req.GetPartialLinks())
	if err != nil {
		log.Error().Err(err).Msg("error parsing partial links")
	}
	return &db.PartialCreateUpdateParams{
		PartialID:            req.GetPartialId(),
		PartialName:          req.GetPartialName(),
		PartialNameAr:        req.GetPartialNameAr(),
		PartialTypeID:        req.GetPartialTypeId(),
		SectionID:            req.GetSectionId(),
		PartialImage:         req.GetPartialImage(),
		PartialImages:        strings.Join(req.GetPartialImages(), ","),
		PartialVideo:         req.GetPartialVideo(),
		IsFeatured:           req.GetIsFeatured(),
		PartialBrief:         req.GetPartialBrief(),
		PartialBriefAr:       req.GetPartialBriefAr(),
		PartialContent:       req.GetPartialContent(),
		PartialContentAr:     req.GetPartialContentAr(),
		PartialButtonLabel:   req.GetPartialButtonLabel(),
		PartialButtonLabelAr: req.GetPartialButtonLabelAr(),
		PartialButtonIcon:    req.GetPartialButtonIcon(),
		PartialButtonLink:    req.GetPartialButtonLink(),
		PartialButtonPageID:  req.GetPartialButtonPageId(),
		PartialIcons:         req.GetPartialIcons(),
		Address:              req.GetAddress(),
		PartialLinks:         partialLinks,
		PartialLink:          req.GetPartialLink(),
	}
}

func (a *TenantAdapter) PartialFindForUpdateGrpcFromSql(resp *db.TenantsSchemaPartial) *devkitv1.PartialFindForUpdateResponse {
	return &devkitv1.PartialFindForUpdateResponse{
		Request: &devkitv1.PartialCreateUpdateRequest{
			PartialId:            int32(resp.PartialID),
			PartialName:          resp.PartialName,
			PartialNameAr:        resp.PartialNameAr.String,
			PartialTypeId:        resp.PartialTypeID,
			SectionId:            int32(resp.SectionID),
			PartialImage:         resp.PartialImage.String,
			PartialImages:        strings.Split(resp.PartialImages.String, ","),
			PartialVideo:         resp.PartialVideo.String,
			IsFeatured:           resp.IsFeatured.Bool,
			PartialBrief:         resp.PartialBrief.String,
			PartialBriefAr:       resp.PartialBriefAr.String,
			PartialContent:       resp.PartialContent.String,
			PartialContentAr:     resp.PartialContentAr.String,
			PartialButtonLabel:   resp.PartialButtonLabel.String,
			PartialButtonLabelAr: resp.PartialButtonLabelAr.String,
			PartialButtonIcon:    resp.PartialButtonIcon.String,
			PartialButtonLink:    resp.PartialButtonLink.String,
			PartialButtonPageId:  int32(resp.PartialButtonPageID.Int32),
			Address:              resp.Address.String,
			PartialLink:          resp.PartialLink.String,
		},
	}

}
