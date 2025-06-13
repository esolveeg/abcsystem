package usecase

import (
	"context"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
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

	err = u.redisClient.TenantDelete(ctx, req.Msg.GetTenantId())
	if err != nil {
		log.Error().Str("message", "clear cache failed :").Err(err).Msg("Cache Clear Failed")
	}
	return &devkitv1.PageCreateUpdateResponse{Record: resp}, nil

}

func (u *TenantUsecase) PageDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.PageDeleteRestoreRequest]) (*devkitv1.PageDeleteRestoreResponse, error) {
	record, err := u.repo.PageDeleteRestore(ctx, &req.Msg.Records)
	if err != nil {
		return nil, err
	}
	for _, r := range *record {
		if r.TenantID.Valid {
			err = u.redisClient.TenantDelete(ctx, r.TenantID.Int32)
			if err != nil {
				log.Error().Str("message", "clear cache failed :").Err(err).Msg("Cache Clear Failed")
			}
		}
	}
	resp := u.adapter.PageEntityListGrpcFromSql(record)
	return &devkitv1.PageDeleteRestoreResponse{Records: *resp}, nil

}

func (u *TenantUsecase) PageFindForUpdate(ctx context.Context, req *connect.Request[devkitv1.PageFindForUpdateRequest]) (*devkitv1.PageFindForUpdateResponse, error) {
	record, err := u.repo.PageFindForUpdate(ctx, db.PageFindForUpdateParams{PageID: req.Msg.RecordId})
	if err != nil {
		return nil, err
	}
	resp := u.adapter.PageFindForUpdateGrpcFromSql(record)
	return resp, nil
}
