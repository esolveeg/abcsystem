package adapter

import (
	"encoding/json"
	"strings"

	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/iancoleman/strcase"
	"github.com/supabase-community/auth-go/types"
	"golang.org/x/crypto/bcrypt"
)

func (a *AccountsAdapter) UserCreateUpdateRequestFromAuthRegister(req *devkitv1.AuthRegisterRequest) *devkitv1.UserCreateUpdateRequest {
	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(req.UserPassword), bcrypt.DefaultCost)
	resp := &devkitv1.UserCreateUpdateRequest{
		UserName:     req.UserName,
		UserTypeId:   req.UserTypeId,
		UserPhone:    req.UserPhone,
		UserEmail:    req.UserEmail,
		UserPassword: string(hashedPassword),
	}
	return resp
}
func (a *AccountsAdapter) UserPermissionsMapRedisFromSql(resp []db.UserPermissionsMapRow) ([]byte, error) {
	respMap := make(map[string]map[string]bool)
	for _, rec := range resp {
		perms := make(map[string]bool)
		err := json.Unmarshal(rec.Permissions, &perms)
		if err != nil {
			return nil, err
		}
		respMap[rec.PermissionGroup] = perms
	}
	respoinse, err := json.Marshal(respMap)
	return respoinse, err
}

func (a *AccountsAdapter) AuthLoginSqlFromGrpc(req *devkitv1.AuthLoginRequest) (*db.UserFindParams, *types.TokenRequest) {
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

func (a *AccountsAdapter) AuthLoginGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.AuthLoginResponse {
	return &devkitv1.AuthLoginResponse{
		User: a.UserEntityGrpcFromSql(resp),
	}
}
func (a *AccountsAdapter) NavigationBarItemGrpcFromSql(resp *db.UserNavigationBarFindRow) *devkitv1.NavigationBarItem {
	if !resp.LabelAr.Valid {
		resp.LabelAr.String = resp.Label
	}
	return &devkitv1.NavigationBarItem{
		Key:     resp.MenuKey,
		Label:   resp.Label,
		LabelAr: resp.LabelAr.String,
		Icon:    resp.Icon.String,
		Route:   resp.Route.String,
	}
}

func (a *AccountsAdapter) AuthResetPasswordSupaFromGrpc(req *devkitv1.AuthResetPasswordRequest) *types.VerifyForUserRequest {
	return &types.VerifyForUserRequest{
		Type:       types.VerificationTypeRecovery,
		Token:      req.ResetToken,
		Email:      req.Email,
		RedirectTo: req.RedirectUrl,
	}
}

func (a *AccountsAdapter) PermissionGroupFromFunctionName(funName string) string {
	functionNameSnake := strcase.ToSnake(funName)
	functionNameParts := strings.Split(functionNameSnake, "_")
	group := functionNameParts[0]

	return group
}
