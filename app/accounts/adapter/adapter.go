package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

type AccountsAdapterInterface interface {
	RoleEntityGrpcFromSql(resp *db.AccountsSchemaRole) *devkitv1.AccountsSchemaRole
	RoleCreateUpdateSqlFromGrpc(req *devkitv1.RoleCreateUpdateRequest) *db.RoleCreateUpdateParams
	RoleCreateUpdateGrpcFromSql(resp *db.AccountsSchemaRole) *devkitv1.RoleCreateUpdateResponse
}

type AccountsAdapter struct {
}

func NewAccountsAdapter() AccountsAdapterInterface {
	return &AccountsAdapter{}
}
