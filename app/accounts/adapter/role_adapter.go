package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/dateutils"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
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

func (a *AccountsAdapter) RoleListRowGrpcFromSql(resp *db.RoleListRow) *devkitv1.RoleListRow {
	return &devkitv1.RoleListRow{
		RoleId:            int32(resp.RoleID),
		RoleName:          resp.RoleName,
		TenantName:        resp.TenantName,
		RoleSecurityLevel: resp.RoleSecurityLevel,
		UserCount:         int32(resp.UserCount),
		PermissionCount:   int32(resp.PermissionCount),
		TenantId:          resp.TenantID,
		CreatedAt:         dateutils.DateTimeToStringDigit(resp.CreatedAt.Time),
		UpdatedAt:         dateutils.DateTimeToStringDigit(resp.UpdatedAt.Time),
		DeletedAt:         dateutils.DateTimeToStringDigit(resp.DeletedAt.Time),
	}
}
func (a *AccountsAdapter) RoleListGrpcFromSql(resp *[]db.RoleListRow) *devkitv1.RoleListResponse {
	records := make([]*devkitv1.RoleListRow, 0)
	deletedRecords := make([]*devkitv1.RoleListRow, 0)
	for _, v := range *resp {
		record := a.RoleListRowGrpcFromSql(&v)
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
