package adapter

import (
	"strings"

	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *TenantAdapter) PageEntityGrpcFromSql(resp *db.TenantsSchemaPage) *devkitv1.TenantsSchemaPage {
	return &devkitv1.TenantsSchemaPage{
		PageId:              int32(resp.PageID),
		PageName:            resp.PageName,
		PageNameAr:          resp.PageNameAr.String,
		PageDescription:     resp.PageDescription.String,
		PageDescriptionAr:   resp.PageDescriptionAr.String,
		PageBreadcrumb:      resp.PageBreadcrumb.String,
		TenantId:            int32(resp.TenantID.Int32), // Handle nullable int
		PageRoute:           resp.PageRoute,
		PageCoverImage:      resp.PageCoverImage.String,
		PageCoverVideo:      resp.PageCoverVideo.String,
		PageKeyWords:        resp.PageKeyWords.String,
		PageMetaDescription: resp.PageMetaDescription.String,
		PageIcon:            resp.PageIcon.String,
		CreatedAt:           db.TimeToProtoTimeStamp(resp.CreatedAt.Time),
		UpdatedAt:           db.TimeToProtoTimeStamp(resp.UpdatedAt.Time),
		DeletedAt:           db.TimeToProtoTimeStamp(resp.DeletedAt.Time),
	}
}

func (a *TenantAdapter) PageEntityListGrpcFromSql(resp *[]db.TenantsSchemaPage) *[]*devkitv1.TenantsSchemaPage {
	records := make([]*devkitv1.TenantsSchemaPage, 0)
	for _, v := range *resp {
		record := a.PageEntityGrpcFromSql(&v)
		records = append(records, record)
	}
	return &records
}
func (a *TenantAdapter) PageListGrpcFromSql(resp *[]db.TenantsSchemaPage) *devkitv1.PageListResponse {
	records := make([]*devkitv1.TenantsSchemaPage, 0)
	deletedRecords := make([]*devkitv1.TenantsSchemaPage, 0)
	for _, v := range *resp {
		record := a.PageEntityGrpcFromSql(&v)
		if v.DeletedAt.Valid {
			deletedRecords = append(deletedRecords, record)
		} else {
			records = append(records, record)
		}
	}
	return &devkitv1.PageListResponse{
		DeletedRecords: deletedRecords,
		Records:        records,
	}
}

func (a *TenantAdapter) PageCreateUpdateSqlFromGrpc(req *devkitv1.PageCreateUpdateRequest) *db.PageCreateUpdateParams {
	return &db.PageCreateUpdateParams{
		PageID:              req.GetPageId(),
		PageName:            req.GetPageName(),
		PageNameAr:          req.GetPageNameAr(),
		PageDescription:     req.GetPageDescription(),
		PageDescriptionAr:   req.GetPageDescriptionAr(),
		PageBreadcrumb:      req.GetPageBreadcrumb(),
		TenantID:            req.GetTenantId(),
		PageRoute:           req.GetPageRoute(),
		PageCoverImage:      req.GetPageCoverImage(),
		PageCoverVideo:      req.GetPageCoverVideo(),
		PageKeyWords:        strings.Join(req.GetPageKeyWords(), ","),
		PageMetaDescription: req.GetPageMetaDescription(),
		PageIcon:            req.GetPageIcon(),
	}
}

func (a *TenantAdapter) PageFindForUpdateGrpcFromSql(resp *db.TenantsSchemaPage) *devkitv1.PageFindForUpdateResponse {
	return &devkitv1.PageFindForUpdateResponse{
		Request: &devkitv1.PageCreateUpdateRequest{
			PageId:              int32(resp.PageID),
			PageName:            resp.PageName,
			PageNameAr:          resp.PageNameAr.String,
			PageDescription:     resp.PageDescription.String,
			PageDescriptionAr:   resp.PageDescriptionAr.String,
			PageBreadcrumb:      resp.PageBreadcrumb.String,
			TenantId:            int32(resp.TenantID.Int32), // Handle nullable int
			PageRoute:           resp.PageRoute,
			PageCoverImage:      resp.PageCoverImage.String,
			PageCoverVideo:      resp.PageCoverVideo.String,
			PageMetaDescription: resp.PageMetaDescription.String,
			PageIcon:            resp.PageIcon.String,
		},
	}

}
