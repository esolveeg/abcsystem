package usecase

import (
	"context"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
)

func (u *TenantUsecase) PartialList(ctx context.Context, req *connect.Request[devkitv1.PartialListRequest]) (*devkitv1.PartialListResponse, error) {
	record, err := u.repo.PartialList(ctx, 0)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.PartialListGrpcFromSql(record)
	return resp, nil

}

func (u *TenantUsecase) PartialCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.PartialCreateUpdateRequest]) (*devkitv1.PartialCreateUpdateResponse, error) {
	sqlReq := u.adapter.PartialCreateUpdateSqlFromGrpc(req.Msg)
	record, err := u.repo.PartialCreateUpdate(ctx, sqlReq)
	if err != nil {
		return nil, err
	}

	err = u.redisClient.DeleteAllTenants(ctx)
	if err != nil {
		log.Error().Str("message", "clear cache failed :").Err(err).Msg("Cache Clear Failed")
	}
	resp := u.adapter.PartialEntityGrpcFromSql(record)
	return &devkitv1.PartialCreateUpdateResponse{Record: resp}, nil

}

func (u *TenantUsecase) PartialDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.PartialDeleteRestoreRequest]) (*devkitv1.PartialDeleteRestoreResponse, error) {
	record, err := u.repo.PartialDeleteRestore(ctx, &req.Msg.Records)
	if err != nil {
		return nil, err
	}

	err = u.redisClient.DeleteAllTenants(ctx)
	if err != nil {
		log.Error().Str("message", "clear cache failed :").Err(err).Msg("Cache Clear Failed")
	}
	resp := u.adapter.PartialEntityListGrpcFromSql(record)
	return &devkitv1.PartialDeleteRestoreResponse{Records: *resp}, nil

}

func (u *TenantUsecase) PartialFindForUpdate(ctx context.Context, req *connect.Request[devkitv1.PartialFindForUpdateRequest]) (*devkitv1.PartialFindForUpdateResponse, error) {

	record, err := u.repo.PartialFindForUpdate(ctx, &db.PartialFindForUpdateParams{PartialID: req.Msg.RecordId})

	if err != nil {
		return nil, err
	}

	resp := u.adapter.PartialFindForUpdateGrpcFromSql(record)
	return resp, nil

}

func (u *TenantUsecase) PartialTypeListInput(ctx context.Context, req *connect.Request[devkitv1.PartialTypeListInputRequest]) (*devkitv1.PartialTypeListInputResponse, error) {
	record, err := u.repo.PartialTypeListInput(ctx)

	if err != nil {
		return nil, err
	}

	resp := u.adapter.PartialTypeListInputGrpcFromSql(record)
	return resp, nil

}
