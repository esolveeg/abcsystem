package usecase

import (
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (u *CompanyUsecase) CompanyCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.CompanyCreateUpdateRequest]) (*devkitv1.CompanyCreateUpdateResponse, error) {
	sqlReq := u.adapter.CompanyCreateUpdateSqlFromGrpc(req.Msg)
	record, err := u.repo.CompanyCreateUpdate(ctx, sqlReq)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.CompanyEntityGrpcFromSql(record)
	return &devkitv1.CompanyCreateUpdateResponse{
		Company: resp,
	}, nil

}

func (u *CompanyUsecase) CompanyList(ctx context.Context, req *connect.Request[devkitv1.CompanyListRequest]) (*devkitv1.CompanyListResponse, error) {
	record, err := u.repo.CompanyList(ctx)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.CompanyListGrpcFromSql(record)
	return resp, nil

}

func (u *CompanyUsecase) CompanyDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.CompanyDeleteRestoreRequest]) (*devkitv1.CompanyDeleteRestoreResponse, error) {
	record, err := u.repo.CompanyDeleteRestore(ctx, req.Msg.Records)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.CompanyDeleteRestoreGrpcFromSql(record)
	return resp, nil
}
