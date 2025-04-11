package usecase

import (
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
)

func (u *TenantUsecase) SectionList(ctx context.Context, req *connect.Request[devkitv1.SectionListRequest]) (*devkitv1.SectionListResponse, error) {
	record, err := u.repo.SectionList(ctx, 0)
	if err != nil {
		return nil, err
	}

	resp := u.adapter.SectionListGrpcFromSql(record)
	return resp, nil

}

func (u *TenantUsecase) SectionFindForUpdate(ctx context.Context, req *connect.Request[devkitv1.SectionFindForUpdateRequest]) (*devkitv1.SectionFindForUpdateResponse, error) {
	params := u.adapter.SectionFindForUpdateSqlFromGrpc(req.Msg)
	record, err := u.repo.SectionFind(ctx, *params)
	if err != nil {
		return nil, err
	}

	resp := u.adapter.SectionFindForUpdateGrpcFromSql(record)
	return resp, nil

}
func (u *TenantUsecase) SectionCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.SectionCreateUpdateRequest]) (*devkitv1.SectionCreateUpdateResponse, error) {
	sqlReq := u.adapter.SectionCreateUpdateSqlFromGrpc(req.Msg)
	record, err := u.repo.SectionCreateUpdate(ctx, sqlReq)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.SectionEntityGrpcFromSql(record)

	err = u.redisClient.DeleteAllTenants(ctx)
	if err != nil {
		log.Error().Str("message", "clear cache failed :").Err(err).Msg("Cache Clear Failed")
	}
	return &devkitv1.SectionCreateUpdateResponse{Record: resp}, nil
}

func (u *TenantUsecase) SectionDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.SectionDeleteRestoreRequest]) (*devkitv1.SectionDeleteRestoreResponse, error) {
	record, err := u.repo.SectionDeleteRestore(ctx, &req.Msg.Records)
	if err != nil {
		return nil, err
	}

	err = u.redisClient.DeleteAllTenants(ctx)
	if err != nil {
		log.Error().Str("message", "clear cache failed :").Err(err).Msg("Cache Clear Failed")
	}
	resp := u.adapter.SectionEntityListGrpcFromSql(record)
	return &devkitv1.SectionDeleteRestoreResponse{Records: *resp}, nil

}

func (u *TenantUsecase) SectionListInpt(ctx context.Context, req *connect.Request[devkitv1.SectionListInptRequest]) (*devkitv1.SectionListInptResponse, error) {
	record, err := u.repo.SectionListInpt(ctx)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.SectionListInptGrpcFromSql(&record)
	return resp, nil

}
