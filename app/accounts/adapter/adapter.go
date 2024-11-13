package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/supabase-community/auth-go/types"
)

type AccountsAdapterInterface interface {
	UserPermissionsMapRedisFromSql(resp []db.UserPermissionsMapRow) ([]byte, error)
	AuthLoginSqlFromGrpc(req *devkitv1.AuthLoginRequest) (*db.UserFindParams, *types.TokenRequest)
	UserCreateUpdateRequestFromAuthRegister(req *devkitv1.AuthRegisterRequest) *devkitv1.UserCreateUpdateRequest
	AuthResetPasswordSupaFromGrpc(req *devkitv1.AuthResetPasswordRequest) *types.VerifyForUserRequest
	AuthLoginGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.AuthLoginResponse
	UserNavigationBarFindGrpcFromSql(resp *[]db.UserNavigationBarFindRow) ([]*devkitv1.NavigationBarItem, error)
	UserCreateUpdateGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.UserCreateUpdateResponse
	UserFindForUpdateUpdateGrpcFromSql(resp *db.UserFindForUpdateRow) *devkitv1.UserCreateUpdateRequest
	UserListInputGrpcFromSql(resp *[]db.UserListInputRow) *devkitv1.UserListInputResponse
	NavigationBarItemGrpcFromSql(resp *db.UserNavigationBarFindRow) *devkitv1.NavigationBarItem
	UserListGrpcFromSql(resp *[]db.AccountsSchemaUser) *devkitv1.UserListResponse
	UserCreateUpdateSqlFromGrpc(req *devkitv1.UserCreateUpdateRequest) *db.UserCreateUpdateParams
	UserEntityGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.AccountsSchemaUser
	RoleFindForUpdateUpdateGrpcFromSql(resp *db.RoleFindForUpdateRow) *devkitv1.RoleCreateUpdateRequest
	RoleListInputGrpcFromSql(resp *[]db.RoleListInputRow) *devkitv1.RoleListInputResponse
	RoleListGrpcFromSql(resp *[]db.AccountsSchemaRole) *devkitv1.RoleListResponse
	RoleEntityGrpcFromSql(resp *db.AccountsSchemaRole) *devkitv1.AccountsSchemaRole
	RoleCreateUpdateSqlFromGrpc(req *devkitv1.RoleCreateUpdateRequest) *db.RoleCreateUpdateParams
	RoleCreateUpdateGrpcFromSql(resp *db.AccountsSchemaRole) *devkitv1.RoleCreateUpdateResponse
}

type AccountsAdapter struct {
}

func NewAccountsAdapter() AccountsAdapterInterface {
	return &AccountsAdapter{}
}
