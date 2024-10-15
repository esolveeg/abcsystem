package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

type AccountsAdapterInterface interface {
	UserCreateUpdateGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.UserCreateUpdateResponse
	UsersListGrpcFromSql(resp []db.AccountsSchemaUser) *devkitv1.UsersListResponse
	UserCreateUpdateSqlFromGrpc(req *devkitv1.UserCreateUpdateRequest) *db.UserCreateUpdateParams
	UserEntityGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.AccountsSchemaUser
	RolesListGrpcFromSql(resp []db.AccountsSchemaRole) *devkitv1.RolesListResponse
	RoleEntityGrpcFromSql(resp *db.AccountsSchemaRole) *devkitv1.AccountsSchemaRole
	RoleCreateUpdateSqlFromGrpc(req *devkitv1.RoleCreateUpdateRequest) *db.RoleCreateUpdateParams
	RoleCreateUpdateGrpcFromSql(resp *db.AccountsSchemaRole) *devkitv1.RoleCreateUpdateResponse
}

type AccountsAdapter struct {
}

func NewAccountsAdapter() AccountsAdapterInterface {
	return &AccountsAdapter{}
}
