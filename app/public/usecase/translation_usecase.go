package usecase

import (
	"context"

	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (s *PublicUsecase) TranslationDelete(ctx context.Context, req *devkitv1.TranslationDeleteRequest) (*devkitv1.TranslationDeleteResponse, error) {
	resp, err := s.repo.TranslationDelete(ctx, req.Keys)
	if err != nil {
		return nil, err
	}
	response := s.adapter.TranslationListGrpcFromSql(resp)
	return &devkitv1.TranslationDeleteResponse{
		Translations: response.Translations,
	}, nil

}

func (s *PublicUsecase) TranslationCreateUpdateBulk(ctx context.Context, req *devkitv1.TranslationCreateUpdateBulkRequest) (*devkitv1.TranslationCreateUpdateBulkResponse, error) {
	params := s.adapter.TranslationCreateUpdateBulkSqlFromGrpc(req)
	resp, err := s.repo.TranslationCreateUpdateBulk(ctx, *params)
	if err != nil {
		return nil, err
	}
	response := s.adapter.TranslationCreateUpdateBulkGrpcFromSql(resp)
	return &devkitv1.TranslationCreateUpdateBulkResponse{
		Translations: response.Translations,
	}, nil
}

func (u *PublicUsecase) TranslationList(ctx context.Context) (*devkitv1.TranslationListResponse, error) {
	settings, err := u.repo.TranslationList(ctx)

	if err != nil {
		return nil, err
	}
	resp := u.adapter.TranslationListGrpcFromSql(settings)
	return &resp, nil
}
