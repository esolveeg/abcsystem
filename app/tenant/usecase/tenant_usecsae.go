package usecase

import (
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
)

func (u *TenantUsecase) TenantCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.TenantCreateUpdateRequest]) (*devkitv1.TenantCreateUpdateResponse, error) {
	sqlReq := u.adapter.TenantCreateUpdateSqlFromGrpc(req.Msg)
	record, err := u.repo.TenantCreateUpdate(ctx, sqlReq)
	if err != nil {
		return nil, err
	}
	err = u.redisClient.TenantDelete(ctx, req.Msg.GetTenantId())
	if err != nil {
		log.Error().Str("message", "clear cache failed :").Err(err).Msg("Cache Clear Failed")
	}
	resp := u.adapter.TenantEntityGrpcFromSql(record)
	return &devkitv1.TenantCreateUpdateResponse{
		Tenant: resp,
	}, nil

}

func (u *TenantUsecase) TenantFind(ctx context.Context, req *connect.Request[devkitv1.TenantFindRequest]) (*devkitv1.TenantFindResponse, error) {
	cachedTenant, err := u.redisClient.TenantFind(ctx, req.Msg.TenantId)
	if cachedTenant != nil {
		if cachedTenant.TenantID != 0 && err == nil {
			log.Debug().Interface("cache found", cachedTenant).Msg("cahchow found")
			return u.adapter.TenantFindGrpcFromSql(cachedTenant), nil
		}
	}

	log.Debug().Interface("cache not found", err).Msg("cahchow not found")
	record, err := u.repo.TenantFind(ctx, req.Msg.TenantId)
	if err != nil {
		return nil, err
	}
	_, err = u.redisClient.TenantCreate(ctx, req.Msg.TenantId, record)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.TenantFindGrpcFromSql(record)
	return resp, nil

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
	record, err := u.repo.TenantDeleteRestore(ctx, req.Msg.GetRecords())
	if err != nil {
		return nil, err
	}
	err = u.redisClient.TenantDeleteBulk(ctx, req.Msg.GetRecords())
	if err != nil {
		log.Error().Str("message", "clear cache failed :").Err(err).Msg("Cache Clear Failed")
	}
	resp := u.adapter.TenantDeleteRestoreGrpcFromSql(record)
	return resp, nil
}
