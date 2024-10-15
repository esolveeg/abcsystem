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
		CreatedAt:       db.TimeToString(resp.CreatedAt.Time),
		DeletedAt:       db.TimeToString(resp.DeletedAt.Time),
	}
}

func (a *AccountsAdapter) RoleCreateUpdateSqlFromGrpc(req *devkitv1.RoleCreateUpdateRequest) *db.RoleCreateUpdateParams {
	resp := &db.RoleCreateUpdateParams{
		RoleID:          req.RoleId,
		RoleName:        req.RoleName,
		RoleDescription: req.RoleDescription,
		Permissions:     req.Permissions,
	}

	log.Debug().Interface("adapter here", resp).Msg("test adapter")
	return resp
}
func (a *AccountsAdapter) RoleCreateUpdateGrpcFromSql(resp *db.AccountsSchemaRole) *devkitv1.RoleCreateUpdateResponse {
	return &devkitv1.RoleCreateUpdateResponse{
		Role: a.RoleEntityGrpcFromSql(resp),
	}
}
