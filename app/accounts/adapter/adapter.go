package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/proto/devkit/v1"
)

type AccountsAdapterInterface interface {
	RoleCreateGrpcFromSql(resp *db.AccountsSchemaRole) *devkitv1.RoleCreateResponse
	RoleCreateSqlFromGrpc(req *devkitv1.RoleCreateRequest) *db.RoleCreateParams
}

type AccountsAdapter struct {
	dateFormat string
}

func NewAccountsAdapter() AccountsAdapterInterface {
	return &AccountsAdapter{
		dateFormat: "2006-01-02 15:04:05",
	}
}
