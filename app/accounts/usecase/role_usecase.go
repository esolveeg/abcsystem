package usecase

import (
	"context"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (u *AccountsUsecase) RoleDelete(ctx context.Context, req *connect.Request[devkitv1.RoleDeleteRequest]) (*devkitv1.AccountsSchemaRole, error) {
	params := db.RoleDeleteParams{
		RoleID: req.Msg.Record,
	}
	user, err := u.repo.RoleDelete(ctx, params)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.RoleEntityGrpcFromSql(user)
	return resp, nil
}
func (u *AccountsUsecase) RoleDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.RoleDeleteRestoreRequest]) (*devkitv1.RoleDeleteRestoreResponse, error) {
	response := make([]*devkitv1.AccountsSchemaRole, 0)
	for _, rec := range req.Msg.Records {
		params := db.RoleDeleteRestoreParams{
			RoleID: rec,
		}
		resp, err := u.repo.RoleDeleteRestore(ctx, params)
		if err != nil {
			return nil, err
		}
		response = append(response, u.adapter.RoleEntityGrpcFromSql(resp))
	}
	return &devkitv1.RoleDeleteRestoreResponse{
		Records: response,
	}, nil
}
func (u *AccountsUsecase) RoleFindForUpdate(ctx context.Context, req *connect.Request[devkitv1.RoleFindForUpdateRequest]) (*devkitv1.RoleFindForUpdateResponse, error) {
	role, err := u.repo.RoleFindForUpdate(ctx, req.Msg.RecordId)
	if err != nil {
		return nil, err
	}
	request := u.adapter.RoleFindForUpdateUpdateGrpcFromSql(role)
	return &devkitv1.RoleFindForUpdateResponse{
		Request: request,
	}, nil
}
func (u *AccountsUsecase) RoleListInput(ctx context.Context) (*devkitv1.RoleListInputResponse, error) {
	roles, err := u.repo.RoleListInput(ctx)
	if err != nil {
		return nil, err
	}
	response := u.adapter.RoleListInputGrpcFromSql(roles)
	return response, nil
}

func (u *AccountsUsecase) RoleList(ctx context.Context) (*devkitv1.RoleListResponse, error) {
	roles, err := u.repo.RoleList(ctx)
	if err != nil {
		return nil, err
	}
	response := u.adapter.RoleListGrpcFromSql(roles)
	return response, nil
}

func (u *AccountsUsecase) RoleCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.RoleCreateUpdateRequest]) (*devkitv1.RoleCreateUpdateResponse, error) {
	roleCreateParams := u.adapter.RoleCreateUpdateSqlFromGrpc(req.Msg)
	role, err := u.repo.RoleCreateUpdate(ctx, *roleCreateParams)
	if err != nil {
		return nil, err
	}
	response := u.adapter.RoleCreateUpdateGrpcFromSql(role)
	return response, nil
}
