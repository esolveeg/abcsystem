package usecase

import (
	"context"

	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (s *PublicUsecase) TranslationsDelete(ctx context.Context, req *devkitv1.TranslationsDeleteRequest) (*devkitv1.TranslationsListResponse, error) {
	resp, err := s.repo.TranslationsDelete(ctx, req.Keys)
	if err != nil {
		return nil, err
	}
	response := s.adapter.TranslationsListGrpcFromSql(resp)
	return &response, nil
}

func (s *PublicUsecase) TranslationsCreateUpdateBulk(ctx context.Context, req *devkitv1.TranslationsCreateUpdateBulkRequest) (*devkitv1.TranslationsListResponse, error) {
	params := s.adapter.TranslationsCreateUpdateBulkSqlFromGrpc(req)
	resp, err := s.repo.TranslationsCreateUpdateBulk(ctx, *params)
	if err != nil {
		return nil, err
	}
	response := s.adapter.TranslationsCreateUpdateBulkGrpcFromSql(resp)
	return &response, nil
}

func (u *PublicUsecase) TranslationsList(ctx context.Context) (*devkitv1.TranslationsListResponse, error) {
	settings, err := u.repo.TranslationsList(ctx)

	if err != nil {
		return nil, err
	}
	resp := u.adapter.TranslationsListGrpcFromSql(settings)
	return &resp, nil
}
