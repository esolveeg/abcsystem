package usecase

import (
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (u *TenantUsecase) TenantCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.TenantCreateUpdateRequest]) (*devkitv1.TenantCreateUpdateResponse, error) {
	sqlReq := u.adapter.TenantCreateUpdateSqlFromGrpc(req.Msg)
	record, err := u.repo.TenantCreateUpdate(ctx, sqlReq)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.TenantEntityGrpcFromSql(record)
	return &devkitv1.TenantCreateUpdateResponse{
		Tenant: resp,
	}, nil

}

func (u *TenantUsecase) TenantList(ctx context.Context, req *connect.Request[devkitv1.TenantListRequest]) (*devkitv1.TenantListResponse, error) {
	record, err := u.repo.TenantList(ctx, 0)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.TenantListGrpcFromSql(record)
	return resp, nil

}

func (u *TenantUsecase) TenantDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.TenantDeleteRestoreRequest]) (*devkitv1.TenantDeleteRestoreResponse, error) {
	record, err := u.repo.TenantDeleteRestore(ctx, req.Msg.Records)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.TenantDeleteRestoreGrpcFromSql(record)
	return resp, nil
}
