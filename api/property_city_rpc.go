package api

import (
	// INJECT IMPORTS
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) CityList(ctx context.Context, req *connect.Request[devkitv1.CityListRequest]) (*connect.Response[devkitv1.CityListResponse], error) {
	resp, err := api.propertyUsecase.CityList(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
func (api *Api) CityListInput(ctx context.Context, req *connect.Request[devkitv1.CityListInputRequest]) (*connect.Response[devkitv1.CityListInputResponse], error) {
	resp, err := api.propertyUsecase.CityListInput(ctx, req)
	if err != nil {
	     return nil, err
	}
	return connect.NewResponse(resp), nil
}

