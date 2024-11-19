package usecase

import (
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (u *CompanyUsecase) PartialList(ctx context.Context, req *connect.Request[devkitv1.PartialListRequest]) (*devkitv1.PartialListResponse, error) {
	record, err := u.repo.PartialList(ctx)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.PartialListGrpcFromSql(record)
	return resp, nil

}

func (u *CompanyUsecase) PartialCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.PartialCreateUpdateRequest]) (*devkitv1.PartialCreateUpdateResponse, error) {
	sqlReq := u.adapter.PartialCreateUpdateSqlFromGrpc(req.Msg)
	record, err := u.repo.PartialCreateUpdate(ctx, sqlReq)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.PartialEntityGrpcFromSql(record)
	return &devkitv1.PartialCreateUpdateResponse{Record: resp}, nil

}

func (u *CompanyUsecase) PartialDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.PartialDeleteRestoreRequest]) (*devkitv1.PartialDeleteRestoreResponse, error) {
	record, err := u.repo.PartialDeleteRestore(ctx, &req.Msg.Records)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.PartialEntityListGrpcFromSql(record)
	return &devkitv1.PartialDeleteRestoreResponse{Records: *resp}, nil

}
