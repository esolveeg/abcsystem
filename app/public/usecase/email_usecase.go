package usecase

import (
	"context"

	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (s *PublicUsecase) EmailSend(ctx context.Context, req *devkitv1.EmailSendRequest) (*devkitv1.EmailSendResponse, error) {
	params := s.adapter.EmailSendResendFromGrpc(req)
	resp, err := s.resendClient.SendEmail(&params)
	if err != nil {
		return nil, err
	}
	return &devkitv1.EmailSendResponse{
		Id: resp.Id,
	}, nil

}
