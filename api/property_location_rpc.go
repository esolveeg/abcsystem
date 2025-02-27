package api

import (
	// INJECT IMPORTS
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) LocationList(ctx context.Context, req *connect.Request[devkitv1.LocationListRequest]) (*connect.Response[devkitv1.LocationListResponse], error) {
	resp, err := api.propertyUsecase.LocationList(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
func (api *Api) LocationListInput(ctx context.Context, req *connect.Request[devkitv1.LocationListInputRequest]) (*connect.Response[devkitv1.LocationListInputResponse], error) {
	resp, err := api.propertyUsecase.LocationListInput(ctx, req)
	if err != nil {
	     return nil, err
	}
	return connect.NewResponse(resp), nil
}

