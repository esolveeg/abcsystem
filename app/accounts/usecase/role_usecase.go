package usecase

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/pkg/contextkeys"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
)

func (u *AccountsUsecase) RoleDeleteRestore(ctx context.Context, req *connect.Request[apiv1.RoleDeleteRestoreRequest]) (*apiv1.RoleDeleteRestoreResponse, error) {
	err := u.repo.RoleDeleteRestore(ctx, req.Msg.Records)
	if err != nil {
		return nil, err
	}
	return &apiv1.RoleDeleteRestoreResponse{}, nil
}
func (u *AccountsUsecase) RoleList(ctx context.Context) (*apiv1.RoleListResponse, error) {
	roles, err := u.repo.RoleList(ctx)
	if err != nil {
		return nil, err
	}
	response := u.adapter.RoleListGrpcFromSql(roles)
	return response, nil
}
func (u *AccountsUsecase) RoleCreateUpdate(ctx context.Context, req *connect.Request[apiv1.RoleCreateUpdateRequest]) (*apiv1.RoleCreateUpdateResponse, error) {
	callerID, ok := contextkeys.CallerID(ctx)
	if !ok {
		return nil, fmt.Errorf("caller ID not found in context")
	}
	log.Debug().Interface("rowle", callerID).Msg("holaefroms usecasles	")
	roleCreateParams := u.adapter.RoleCreateUpdateSqlFromGrpc(req.Msg)
	role, err := u.repo.RoleCreateUpdate(ctx, *roleCreateParams)

	if err != nil {
		return nil, err
	}
	response := u.adapter.RoleCreateUpdateGrpcFromSql(role)
	return response, nil
}
