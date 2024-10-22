package usecase

import (
	"context"

	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (s *PublicUsecase) IconsInputList(ctx context.Context) (*devkitv1.IconsInputListResponse, error) {
	icons, err := s.repo.IconsInputList(ctx)
	if err != nil {
		return nil, err
	}
	res := s.adapter.IconsInputListGrpcFromSql(icons)
	return res, nil
}
