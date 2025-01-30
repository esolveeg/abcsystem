package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/iancoleman/strcase"
	"github.com/rs/zerolog/log"
)

func (a *AccountsAdapter) RoleFindForUpdateUpdateGrpcFromSql(resp *db.RoleFindForUpdateRow) *devkitv1.RoleCreateUpdateRequest {
	return &devkitv1.RoleCreateUpdateRequest{
		RoleId:            resp.RoleID,
		RoleSecurityLevel: resp.RoleSecurityLevel,
		TenantId:          resp.TenantID.Int32,
		RoleName:          resp.RoleName,
		RoleDescription:   resp.RoleDescription.String,
		Permissions:       resp.Permissions,
	}
}
func (a *AccountsAdapter) RoleListInputGrpcFromSql(resp *[]db.RoleListInputRow) *devkitv1.RoleListInputResponse {
	records := make([]*devkitv1.SelectInputOption, 0)
	for _, v := range *resp {
		records = append(records, &devkitv1.SelectInputOption{
			Value: v.Value,
			Note:  v.Note,
			Label: v.Label,
		})
	}
	return &devkitv1.RoleListInputResponse{
		Options: records,
	}
}
func (a *AccountsAdapter) RoleEntityGrpcFromSql(resp *db.AccountsSchemaRole) *devkitv1.AccountsSchemaRole {
	return &devkitv1.AccountsSchemaRole{
		RoleId:          int32(resp.RoleID),
		RoleName:        resp.RoleName,
		TenantId:        resp.TenantID.Int32,
		RoleDescription: resp.RoleDescription.String,
		CreatedAt:       db.TimeToString(resp.CreatedAt.Time),
		DeletedAt:       db.TimeToString(resp.DeletedAt.Time),
	}
}

func (a *AccountsAdapter) RoleCreateUpdateSqlFromGrpc(req *devkitv1.RoleCreateUpdateRequest) *db.RoleCreateUpdateParams {
	resp := &db.RoleCreateUpdateParams{
		RoleID:            req.RoleId,
		TenantID:          req.TenantId,
		RoleName:          req.RoleName,
		RoleSecurityLevel: req.RoleSecurityLevel,
		RoleDescription:   req.RoleDescription,
		Permissions:       req.Permissions,
	}

	return resp
}

func (a *AccountsAdapter) RoleListSqlFromGrpc(req *devkitv1.RoleListRequest) *db.RoleListParams {

	log.Debug().Interface("not empty params", "nottt").Msg("not empty")
	if req.PaginationParams == nil {
		log.Debug().Interface("empty params", "em").Msg("a;ready empty")
		req.PaginationParams = &devkitv1.PaginationParams{PageNumber: 1, PageSize: 10, SortColumn: "roleId", IsDeleted: false}
	}
	if req.Filters == nil {
		req.Filters = &devkitv1.RoleFilters{}
	}
	if req.PaginationParams.SortColumn == "" {
		req.PaginationParams.SortColumn = "roleId"
	}
	return &db.RoleListParams{
		InRoleName:        req.Filters.RoleName,
		InRoleDescription: req.Filters.RoleDescription,
		PageNumber:        req.PaginationParams.PageNumber,
		// InCreatedAtTo:     db.StringToPgdate(req.Filters.CreatedAtTo),
		// InCreatedAtFrom:   db.StringToPgdate(req.Filters.CreatedAtFrom),
		SortFunction: req.PaginationParams.SortFunction,
		PageSize:     req.PaginationParams.PageSize,
		InIsDeleted:  req.PaginationParams.IsDeleted,
		SortColumn:   strcase.ToSnake(req.PaginationParams.SortColumn),
	}
}
func (a *AccountsAdapter) RoleListGrpcFromSql(resp *[]db.RoleListRow) *devkitv1.RoleListResponse {
	records := make([]*devkitv1.AccountsSchemaRole, 0)
	deletedRecords := make([]*devkitv1.AccountsSchemaRole, 0)
	for _, v := range *resp {
		record := &devkitv1.AccountsSchemaRole{RoleId: v.RoleID, RoleName: v.RoleName}
		records = append(records, record)
	}
	return &devkitv1.RoleListResponse{
		DeletedRecords: deletedRecords,
		Records:        records,
	}
}
func (a *AccountsAdapter) RoleCreateUpdateGrpcFromSql(resp *db.AccountsSchemaRole) *devkitv1.RoleCreateUpdateResponse {
	return &devkitv1.RoleCreateUpdateResponse{
		Role: a.RoleEntityGrpcFromSql(resp),
	}
}
