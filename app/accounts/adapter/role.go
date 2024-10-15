package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
)

func (a *AccountsAdapter) RoleEntityGrpcFromSql(resp *db.AccountsSchemaRole) *devkitv1.AccountsSchemaRole {
	return &devkitv1.AccountsSchemaRole{
		RoleId:          int32(resp.RoleID),
		RoleName:        resp.RoleName,
		RoleDescription: resp.RoleDescription.String,
		CreatedAt:       resp.CreatedAt.Time.Format(a.dateFormat),
		DeletedAt:       resp.DeletedAt.Time.Format(a.dateFormat),
	}
}

func (a *AccountsAdapter) RoleCreateSqlFromGrpc(req *devkitv1.RoleCreateRequest) *db.RoleCreateParams {
	resp := &db.RoleCreateParams{
		RoleName:        req.RoleName,
		RoleDescription: req.RoleDescription,
		Permissions:     req.Permissions,
	}

	log.Debug().Interface("adapter here", resp).Msg("test adapter")
	return resp
}
func (a *AccountsAdapter) RoleCreateGrpcFromSql(resp *db.AccountsSchemaRole) *devkitv1.RoleCreateResponse {
	return &devkitv1.RoleCreateResponse{
		Role: a.RoleEntityGrpcFromSql(resp),
	}
}
