package adapter

import (
	"strings"

	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/supabase-community/auth-go/types"
	"golang.org/x/crypto/bcrypt"
)

func (a *AccountsAdapter) UserEntityGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.AccountsSchemaUser {
	return &devkitv1.AccountsSchemaUser{
		UserId:            int32(resp.UserID),
		UserName:          resp.UserName,
		UserSecurityLevel: resp.UserSecurityLevel, // Security level of the user
		UserTypeId:        resp.UserTypeID,
		UserPhone:         resp.UserPhone.String,
		UserEmail:         resp.UserEmail, // User's email, unique in DB
		CreatedAt:         db.TimeToString(resp.CreatedAt.Time),
		DeletedAt:         db.TimeToString(resp.DeletedAt.Time),
	}
}

func (a *AccountsAdapter) UserCreateUpdateSqlFromGrpc(req *devkitv1.UserCreateUpdateRequest) *db.UserCreateUpdateParams {
	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(req.UserPassword), bcrypt.DefaultCost)
	resp := &db.UserCreateUpdateParams{
		UserID:            req.UserId,
		UserName:          req.UserName,
		UserSecurityLevel: req.UserSecurityLevel,
		UserTypeID:        req.UserTypeId,
		UserPhone:         req.UserPhone,
		UserEmail:         req.UserEmail,
		UserPassword:      string(hashedPassword),
		Roles:             req.Roles,
	}
	return resp
}
func (a *AccountsAdapter) UsersListGrpcFromSql(resp []db.AccountsSchemaUser) *devkitv1.UsersListResponse {
	records := make([]*devkitv1.AccountsSchemaUser, 0)
	deletedRecords := make([]*devkitv1.AccountsSchemaUser, 0)
	for _, v := range resp {
		record := a.UserEntityGrpcFromSql(&v)
		if v.DeletedAt.Valid {
			deletedRecords = append(deletedRecords, record)
		} else {
			records = append(records, record)
		}
	}
	return &devkitv1.UsersListResponse{
		DeletedRecords: deletedRecords,
		Records:        records,
	}
}
func (a *AccountsAdapter) UserCreateUpdateGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.UserCreateUpdateResponse {
	return &devkitv1.UserCreateUpdateResponse{
		User: a.UserEntityGrpcFromSql(resp),
	}
}
func (a *AccountsAdapter) UserLoginSqlFromGrpc(req *devkitv1.UserLoginRequest) (*db.UserFindParams, *types.TokenRequest) {
	isEmail := strings.Contains(req.LoginCode, "@") && strings.Contains(req.LoginCode, ".")
	supabseRequest := &types.TokenRequest{Password: req.UserPassword}
	if isEmail {
		supabseRequest.Email = req.LoginCode
	} else {
		supabseRequest.Phone = req.LoginCode
	}
	supabseRequest.GrantType = "password"
	return &db.UserFindParams{
		SearchKey: req.LoginCode,
	}, supabseRequest
}

func (a *AccountsAdapter) UserLoginGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.UserLoginResponse {
	return &devkitv1.UserLoginResponse{
		User: a.UserEntityGrpcFromSql(resp),
	}
}
