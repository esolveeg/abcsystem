package api

import (
	// INJECT IMPORTS
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) PageList(ctx context.Context, req *connect.Request[devkitv1.PageListRequest]) (*connect.Response[devkitv1.PageListResponse], error) {
	resp, err := api.tenantUsecase.PageList(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}

func (api *Api) PageCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.PageCreateUpdateRequest]) (*connect.Response[devkitv1.PageCreateUpdateResponse], error) {
	resp, err := api.tenantUsecase.PageCreateUpdate(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
func (api *Api) PageDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.PageDeleteRestoreRequest]) (*connect.Response[devkitv1.PageDeleteRestoreResponse], error) {
	resp, err := api.tenantUsecase.PageDeleteRestore(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
