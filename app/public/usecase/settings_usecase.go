package usecase

import (
	"context"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (s *PublicUsecase) SettingUpdate(ctx context.Context, req *devkitv1.SettingUpdateRequest) error {
	params := s.adapter.SettingUpdateSqlFromGrpc(req)
	err := s.repo.SettingUpdate(ctx, params)
	if err != nil {
		return err
	}
	return nil

}

func (u *PublicUsecase) SettingFindForUpdate(ctx context.Context, req *devkitv1.SettingFindForUpdateRequest) (*devkitv1.SettingFindForUpdateResponse, error) {
	settings, err := u.repo.SettingFindForUpdate(ctx)

	if err != nil {
		return nil, err
	}
	resp := u.adapter.SettingFindForUpdateGrpcFromSql(settings)

	return resp, nil
}
