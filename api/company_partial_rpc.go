package api

import (
	// INJECT IMPORTS
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) PartialList(ctx context.Context, req *connect.Request[devkitv1.PartialListRequest]) (*connect.Response[devkitv1.PartialListResponse], error) {
	resp, err := api.companyUsecase.PartialList(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}

func (api *Api) PartialCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.PartialCreateUpdateRequest]) (*connect.Response[devkitv1.PartialCreateUpdateResponse], error) {
	resp, err := api.companyUsecase.PartialCreateUpdate(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
func (api *Api) PartialDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.PartialDeleteRestoreRequest]) (*connect.Response[devkitv1.PartialDeleteRestoreResponse], error) {
	resp, err := api.companyUsecase.PartialDeleteRestore(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
