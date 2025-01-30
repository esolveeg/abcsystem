package usecase

import (
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (u *TenantUsecase) SectionList(ctx context.Context, req *connect.Request[devkitv1.SectionListRequest]) (*devkitv1.SectionListResponse, error) {
	record, err := u.repo.SectionList(ctx, 0)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.SectionListGrpcFromSql(record)
	return resp, nil

}

func (u *TenantUsecase) SectionCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.SectionCreateUpdateRequest]) (*devkitv1.SectionCreateUpdateResponse, error) {
	sqlReq := u.adapter.SectionCreateUpdateSqlFromGrpc(req.Msg)
	record, err := u.repo.SectionCreateUpdate(ctx, sqlReq)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.SectionEntityGrpcFromSql(record)
	return &devkitv1.SectionCreateUpdateResponse{Record: resp}, nil
}

func (u *TenantUsecase) SectionDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.SectionDeleteRestoreRequest]) (*devkitv1.SectionDeleteRestoreResponse, error) {
	record, err := u.repo.SectionDeleteRestore(ctx, &req.Msg.Records)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.SectionEntityListGrpcFromSql(record)
	return &devkitv1.SectionDeleteRestoreResponse{Records: *resp}, nil

}
