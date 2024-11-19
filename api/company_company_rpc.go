package api

import (
	// INJECT IMPORTS
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) TenantCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.TenantCreateUpdateRequest]) (*connect.Response[devkitv1.TenantCreateUpdateResponse], error) {
	resp, err := api.tenantUsecase.TenantCreateUpdate(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
func (api *Api) TenantList(ctx context.Context, req *connect.Request[devkitv1.TenantListRequest]) (*connect.Response[devkitv1.TenantListResponse], error) {
	resp, err := api.tenantUsecase.TenantList(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil

}
func (api *Api) TenantDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.TenantDeleteRestoreRequest]) (*connect.Response[devkitv1.TenantDeleteRestoreResponse], error) {
	resp, err := api.tenantUsecase.TenantDeleteRestore(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil

}
