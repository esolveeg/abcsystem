package usecase

import (
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (u *TenantUsecase) PageList(ctx context.Context, req *connect.Request[devkitv1.PageListRequest]) (*devkitv1.PageListResponse, error) {
	record, err := u.repo.PageList(ctx, 0)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.PageListGrpcFromSql(record)
	return resp, nil

}

func (u *TenantUsecase) PageCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.PageCreateUpdateRequest]) (*devkitv1.PageCreateUpdateResponse, error) {

	sqlReq := u.adapter.PageCreateUpdateSqlFromGrpc(req.Msg)
	record, err := u.repo.PageCreateUpdate(ctx, sqlReq)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.PageEntityGrpcFromSql(record)
	return &devkitv1.PageCreateUpdateResponse{Record: resp}, nil

}

func (u *TenantUsecase) PageDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.PageDeleteRestoreRequest]) (*devkitv1.PageDeleteRestoreResponse, error) {
	record, err := u.repo.PageDeleteRestore(ctx, &req.Msg.Records)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.PageEntityListGrpcFromSql(record)
	return &devkitv1.PageDeleteRestoreResponse{Records: *resp}, nil

}
