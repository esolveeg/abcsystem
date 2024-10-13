package usecase

import (
	"context"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/proto/devkit/v1"
)

func (u *AccountsUsecase) RoleCreate(ctx context.Context, req *apiv1.RoleCreateRequest) (*apiv1.RoleCreateResponse, error) {
	roleCreateParams := u.adapter.RoleCreateSqlFromGrpc(req)
	role, err := u.repo.RoleCreate(ctx, *roleCreateParams)

	if err != nil {
		return nil, err
	}
	response := u.adapter.RoleCreateGrpcFromSql(role)
	return response, nil
}
