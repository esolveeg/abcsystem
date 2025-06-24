package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/redisclient"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/supabase-community/auth-go/types"
)

type AccountsAdapterInterface interface {
	UserPermissionsMapRedisFromSql(resp *[]db.UserPermissionsMapRow) (*redisclient.PermissionsMap, error)
	AuttSessionRedisFromGrpc(response *devkitv1.AuthLoginResponse, ipAddress string, userAgent string) (*redisclient.AuthSession, error)
	AuthLoginSqlFromGrpc(req *devkitv1.AuthLoginRequest) (*db.UserFindParams, *types.TokenRequest)
	UserCreateUpdateRequestFromAuthRegister(req *devkitv1.AuthRegisterRequest) *devkitv1.UserCreateUpdateRequest
	AuthSessionListGrpcFromRedis(resp []*redisclient.AuthSession) *devkitv1.AuthSessionListResponse
	AuthResetPasswordSupaFromGrpc(req *devkitv1.AuthResetPasswordRequest) *types.VerifyForUserRequest
	AuthLoginGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.AuthLoginResponse
	UserNavigationBarFindGrpcFromSql(dbResponse []db.UserNavigationBarFindRow) ([]*devkitv1.NavigationBarItem, error)
	UserCreateUpdateGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.UserCreateUpdateResponse
	UserFindForUpdateUpdateGrpcFromSql(resp *db.UserFindForUpdateRow) *devkitv1.UserCreateUpdateRequest
	UserTypeListInputGrpcFromSql(resp *[]db.UserTypeListInputRow) *devkitv1.UserTypeListInputResponse
	UserListInputGrpcFromSql(resp *[]db.UserListInputRow) *devkitv1.UserListInputResponse
	NavigationBarItemGrpcFromSql(resp *db.UserNavigationBarFindRow) *devkitv1.NavigationBarItem
	UserListGrpcFromSql(resp *[]db.AccountsSchemaUserView) *devkitv1.UserListResponse
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
