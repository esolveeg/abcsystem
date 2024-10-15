package usecase

import (
	"context"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (u *AccountsUsecase) UsersDeleteRestore(ctx context.Context, req *apiv1.DeleteRestoreRequest) error {
	err := u.repo.UsersDeleteRestore(ctx, req.Records)
	if err != nil {
		return err
	}
	return nil
}
func (u *AccountsUsecase) UsersList(ctx context.Context) (*apiv1.UsersListResponse, error) {
	roles, err := u.repo.UsersList(ctx)
	if err != nil {
		return nil, err
	}
	response := u.adapter.UsersListGrpcFromSql(roles)
	return response, nil
}
func (u *AccountsUsecase) UserCreateUpdate(ctx context.Context, req *apiv1.UserCreateUpdateRequest) (*apiv1.UserCreateUpdateResponse, error) {

	roleCreateParams := u.adapter.UserCreateUpdateSqlFromGrpc(req)

	role, err := u.repo.UserCreateUpdate(ctx, *roleCreateParams)

	if err != nil {
		return nil, err
	}
	response := u.adapter.UserCreateUpdateGrpcFromSql(role)
	return response, nil
}
