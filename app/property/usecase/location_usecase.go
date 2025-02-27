package usecase

import (
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (u *PropertyUsecase) LocationList(ctx context.Context, req *connect.Request[devkitv1.LocationListRequest]) (*devkitv1.LocationListResponse, error) {
	record, err := u.repo.LocationList(ctx)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.LocationListGrpcFromSql(record)
	return resp, nil
}

func (u *PropertyUsecase) LocationListInput(ctx context.Context, req *connect.Request[devkitv1.LocationListInputRequest]) (*devkitv1.LocationListInputResponse, error) {
	record, err := u.repo.LocationListInput(ctx, req.Msg.CityId)
	if err != nil {
		return nil, err
	}

	resp := u.adapter.LocationListInputGrpcFromSql(record)
	return resp, nil

}
