package usecase

import (
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (u *PropertyUsecase) CityList(ctx context.Context, req *connect.Request[devkitv1.CityListRequest]) (*devkitv1.CityListResponse, error) {
	record, err := u.repo.CityList(ctx)
	if err != nil {
		return nil, err
	}
	resp := u.adapter.CityListGrpcFromSql(record)
	return resp, nil
}

func (u *PropertyUsecase) CityListInput(ctx context.Context, req *connect.Request[devkitv1.CityListInputRequest]) (*devkitv1.CityListInputResponse, error) {
	record, err := u.repo.CityListInput(ctx)
	if err != nil {
		return nil, err
	}

	resp := u.adapter.CityListInputGrpcFromSql(record)
	return resp, nil

}
