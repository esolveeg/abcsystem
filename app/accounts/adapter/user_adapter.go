package adapter

import (
	"encoding/json"

	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/dateutils"
	"github.com/darwishdev/devkit-api/pkg/redisclient"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
	"golang.org/x/crypto/bcrypt"
)

func (a *AccountsAdapter) UserEntityGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.AccountsSchemaUser {
	return &devkitv1.AccountsSchemaUser{
		UserId:     int32(resp.UserID),
		UserName:   resp.UserName,
		UserImage:  resp.UserImage.String,
		UserTypeId: resp.UserTypeID,
		TenantId:   resp.TenantID.Int32,
		UserPhone:  resp.UserPhone.String,
		UserEmail:  resp.UserEmail, // User's email, unique in DB
		CreatedAt:  db.TimeToString(resp.CreatedAt.Time),
		DeletedAt:  db.TimeToString(resp.DeletedAt.Time),
	}
}

func (a *AccountsAdapter) UserFindRowGrpcFromSql(resp *db.UserFindRow) *devkitv1.UserFindRow {
	record := &devkitv1.UserFindRow{
		UserId:            int32(resp.UserID),
		UserImage:         resp.UserImage,
		UserName:          resp.UserName,
		UserTypeId:        resp.UserTypeID,
		UserTypeName:      resp.UserTypeName,
		UserSecurityLevel: resp.UserSecurityLevel,
		PermissionCount:   int32(resp.PermissionCount),
		TenantName:        resp.TenantName,
		TenantId:          resp.TenantID,
		UserPhone:         resp.UserPhone,
		UserEmail:         resp.UserEmail,
		CreatedAt:         dateutils.DateTimeToStringDigit(resp.CreatedAt.Time),
		UpdatedAt:         dateutils.DateTimeToStringDigit(resp.UpdatedAt.Time),
		DeletedAt:         dateutils.DateTimeToStringDigit(resp.DeletedAt.Time),
	}
	if len(resp.Roles) > 0 {
		json.Unmarshal(resp.Roles, &record.Roles)
	}
	if len(resp.Logs) > 0 {
		json.Unmarshal(resp.Logs, &record.Logs)
	}
	return record
}
func (a *AccountsAdapter) UserSessionGrpcFropmSql(resp *redisclient.AuthSession) *devkitv1.UserSession {
	return &devkitv1.UserSession{
		UserId:                        int32(resp.UserID),
		SessionKey:                    resp.SessionKey,
		IpAddress:                     resp.IPAddress,
		IsBlocked:                     resp.IsBlocked,
		CreatedAt:                     dateutils.DateTimeToStringDigit(resp.CreatedAt),
		AccessTokenExpiresAt:          dateutils.DateTimeToStringDigit(resp.AccessTokenExpiresAt),
		RefreshTokenExpiresAt:         dateutils.DateTimeToStringDigit(resp.RefreshTokenExpiresAt),
		SupabaseAccessTokenExpiresAt:  dateutils.DateTimeToStringDigit(resp.SupabaseAccessTokenExpiresAt),
		SupabaseRefreshTokenExpiresAt: dateutils.DateTimeToStringDigit(resp.SupabaseRefreshTokenExpiresAt),
	}
}
func (a *AccountsAdapter) UserSessionsGrpcFropmSql(sessions []*redisclient.AuthSession) []*devkitv1.UserSession {
	response := make([]*devkitv1.UserSession, len(sessions))

	for index, session := range sessions {
		response[index] = a.UserSessionGrpcFropmSql(session)
	}
	return response
}
func (a *AccountsAdapter) UserViewEntityGrpcFromSql(resp *db.AccountsSchemaUserView) *devkitv1.AccountsSchemaUserView {
	record := &devkitv1.AccountsSchemaUserView{
		UserId:       int32(resp.UserID),
		UserImage:    resp.UserImage,
		UserName:     resp.UserName,
		UserTypeId:   resp.UserTypeID,
		UserTypeName: resp.UserTypeName,

		UserSecurityLevel: resp.UserSecurityLevel,
		TenantName:        resp.TenantName,
		TenantId:          resp.TenantID,
		UserPhone:         resp.UserPhone,
		UserEmail:         resp.UserEmail,
		CreatedAt:         dateutils.DateTimeToStringDigit(resp.CreatedAt.Time),
		UpdatedAt:         dateutils.DateTimeToStringDigit(resp.UpdatedAt.Time),
		DeletedAt:         dateutils.DateTimeToStringDigit(resp.DeletedAt.Time),
	}
	if len(resp.Roles) > 0 {
		json.Unmarshal(resp.Roles, &record.Roles)
	}
	return record
}
func (a *AccountsAdapter) UserCreateUpdateSqlFromGrpc(req *devkitv1.UserCreateUpdateRequest) *db.UserCreateUpdateParams {
	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(req.UserPassword), bcrypt.DefaultCost)
	resp := &db.UserCreateUpdateParams{
		UserID:       req.UserId,
		UserName:     req.UserName,
		UserImage:    req.UserImage,
		UserTypeID:   req.UserTypeId,
		UserPhone:    req.UserPhone,
		UserEmail:    req.UserEmail,
		UserPassword: string(hashedPassword),
		Roles:        req.Roles,
	}
	return resp
}
func (a *AccountsAdapter) UserFindForUpdateUpdateGrpcFromSql(resp *db.UserFindForUpdateRow) *devkitv1.UserCreateUpdateRequest {
	return &devkitv1.UserCreateUpdateRequest{
		UserId:     resp.UserID,
		TenantId:   resp.TenantID.Int32,
		UserName:   resp.UserName,
		UserImage:  resp.UserImage.String,
		UserTypeId: resp.UserTypeID,
		UserPhone:  resp.UserPhone.String,
		UserEmail:  resp.UserEmail,
		Roles:      resp.Roles,
	}
}
func (a *AccountsAdapter) UserTypeListInputGrpcFromSql(resp *[]db.UserTypeListInputRow) *devkitv1.UserTypeListInputResponse {
	records := make([]*devkitv1.SelectInputOption, 0)
	for _, v := range *resp {
		records = append(records, &devkitv1.SelectInputOption{
			Value: v.Value,
			Label: v.Label,
		})
	}
	return &devkitv1.UserTypeListInputResponse{
		Options: records,
	}
}

func (a *AccountsAdapter) UserListInputGrpcFromSql(resp *[]db.UserListInputRow) *devkitv1.UserListInputResponse {
	records := make([]*devkitv1.SelectInputOption, 0)
	for _, v := range *resp {
		records = append(records, &devkitv1.SelectInputOption{
			Value: v.Value,
			Note:  v.Note,
			Label: v.Label,
		})
	}
	return &devkitv1.UserListInputResponse{
		Options: records,
	}
}
func (a *AccountsAdapter) UserPermissionListInputGrpcFromSql(resp *[]db.UserPermissionListInputRow) *devkitv1.UserPermissionListInputResponse {
	groupedOptions := make([]*devkitv1.SelectInputOptionWithGroup, len(*resp))

	for groupIndex, v := range *resp {
		items := make([]*devkitv1.SelectInputOption, len(v.Options))
		if err := json.Unmarshal(v.Options, &items); err != nil {
			continue
		}
		groupedOptions[groupIndex] = &devkitv1.SelectInputOptionWithGroup{
			GroupName: v.PermissionGroup,
			Items:     items,
		}
	}
	return &devkitv1.UserPermissionListInputResponse{
		Options: groupedOptions,
	}
}

func (a *AccountsAdapter) UserListRowGrpcFromSql(resp *db.AccountsSchemaUserView) *devkitv1.UserListRow {
	record := &devkitv1.UserListRow{
		UserId:            int32(resp.UserID),
		UserImage:         resp.UserImage,
		UserName:          resp.UserName,
		UserTypeId:        resp.UserTypeID,
		UserTypeName:      resp.UserTypeName,
		UserSecurityLevel: resp.UserSecurityLevel,
		TenantName:        resp.TenantName,
		TenantId:          resp.TenantID,
		UserPhone:         resp.UserPhone,
		UserEmail:         resp.UserEmail,
		CreatedAt:         dateutils.DateTimeToStringDigit(resp.CreatedAt.Time),
		UpdatedAt:         dateutils.DateTimeToStringDigit(resp.UpdatedAt.Time),
		DeletedAt:         dateutils.DateTimeToStringDigit(resp.DeletedAt.Time),
	}
	if len(resp.Roles) > 0 {
		err := json.Unmarshal(resp.Roles, &record.Roles)
		if err != nil {
			log.Error().Err(err).Msg("error parsinng user roles into json")
		}
	}
	roleIds := make([]int32, len(record.Roles))
	for index, v := range record.Roles {
		roleIds[index] = v.RoleId
	}
	record.RoleIds = roleIds
	return record
}
func (a *AccountsAdapter) UserListGrpcFromSql(resp *[]db.AccountsSchemaUserView) *devkitv1.UserListResponse {
	records := make([]*devkitv1.UserListRow, 0)
	deletedRecords := make([]*devkitv1.UserListRow, 0)
	for _, v := range *resp {
		record := a.UserListRowGrpcFromSql(&v)
		if v.DeletedAt.Valid {
			deletedRecords = append(deletedRecords, record)
		} else {
			records = append(records, record)
		}
	}
	return &devkitv1.UserListResponse{
		DeletedRecords: deletedRecords,
		Records:        records,
	}
}
func (a *AccountsAdapter) UserCreateUpdateGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.UserCreateUpdateResponse {
	return &devkitv1.UserCreateUpdateResponse{
		User: a.UserEntityGrpcFromSql(resp),
	}
}
