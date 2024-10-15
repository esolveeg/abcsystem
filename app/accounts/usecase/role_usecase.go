package usecase

import (
	"context"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (u *AccountsUsecase) RoleCreateUpdate(ctx context.Context, req *apiv1.RoleCreateUpdateRequest) (*apiv1.RoleCreateUpdateResponse, error) {

	roleCreateParams := u.adapter.RoleCreateUpdateSqlFromGrpc(req)

	role, err := u.repo.RoleCreateUpdate(ctx, *roleCreateParams)

	if err != nil {
		return nil, err
	}
	response := u.adapter.RoleCreateUpdateGrpcFromSql(role)
	return response, nil
}
