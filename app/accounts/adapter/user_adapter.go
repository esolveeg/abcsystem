package adapter

import (
	"encoding/json"

	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/dateutils"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
	"golang.org/x/crypto/bcrypt"
)

func (a *AccountsAdapter) UserEntityGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.AccountsSchemaUser {
	return &devkitv1.AccountsSchemaUser{
		UserId:     int32(resp.UserID),
		UserName:   resp.UserName,
		UserImage:   resp.UserImage.String,
		UserTypeId: resp.UserTypeID,
		TenantId:   resp.TenantID.Int32,
		UserPhone:  resp.UserPhone.String,
		UserEmail:  resp.UserEmail, // User's email, unique in DB
		CreatedAt:  db.TimeToProtoTimeStamp(resp.CreatedAt.Time),
		DeletedAt:  db.TimeToString(resp.DeletedAt.Time),
	}
}

func (a *AccountsAdapter) UserCreateUpdateSqlFromGrpc(req *devkitv1.UserCreateUpdateRequest) *db.UserCreateUpdateParams {
	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(req.UserPassword), bcrypt.DefaultCost)
	resp := &db.UserCreateUpdateParams{
		UserID:       req.UserId,
		UserName:     req.UserName,
		UserImage:     req.UserImage,
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
		UserImage:   resp.UserImage.String,
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
func (a *AccountsAdapter) UserListGrpcFromSql(resp *[]db.AccountsSchemaUserView) *devkitv1.UserListResponse {
	records := make([]*devkitv1.AccountsSchemaUserView, 0)
	deletedRecords := make([]*devkitv1.AccountsSchemaUserView, 0)
	for _, v := range *resp {
		log.Debug().Interface("time is", v.DeletedAt.Time).Msg("time is")
		record := &devkitv1.AccountsSchemaUserView{
			UserId:     int32(v.UserID),
			UserImage:   v.UserImage.String,
			UserName:   v.UserName,
			UserTypeId: v.UserTypeID,
			UserTypeName: v.UserTypeName,
			TenantName: v.TenantName.(string),
			TenantId:   v.TenantID.(int32),
			UserPhone:  v.UserPhone.String,
			UserEmail:  v.UserEmail, // User's email, unique in DB
			CreatedAt: dateutils.DateTimeToStringDigit(v.CreatedAt.Time),
			UpdatedAt:  dateutils.DateTimeToStringDigit(v.UpdatedAt.Time),
			DeletedAt:  dateutils.DateTimeToStringDigit(v.DeletedAt.Time),
		}
		if len(v.Roles) > 0  {
			json.Unmarshal(v.Roles, &record.Roles) 
		}
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
