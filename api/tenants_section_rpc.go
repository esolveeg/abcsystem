package api

import (
	// INJECT IMPORTS
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) SectionList(ctx context.Context, req *connect.Request[devkitv1.SectionListRequest]) (*connect.Response[devkitv1.SectionListResponse], error) {
	resp, err := api.tenantUsecase.SectionList(ctx, req)
	if err != nil {
		return nil, err
	}

	resp.Options = api.getAvailableOptions(req.Header())

	return connect.NewResponse(resp), nil
}

func (api *Api) SectionFindForUpdate(ctx context.Context, req *connect.Request[devkitv1.SectionFindForUpdateRequest]) (*connect.Response[devkitv1.SectionFindForUpdateResponse], error) {
	resp, err := api.tenantUsecase.SectionFindForUpdate(ctx, req)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(resp), nil
}

func (api *Api) SectionCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.SectionCreateUpdateRequest]) (*connect.Response[devkitv1.SectionCreateUpdateResponse], error) {
	resp, err := api.tenantUsecase.SectionCreateUpdate(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
func (api *Api) SectionDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.SectionDeleteRestoreRequest]) (*connect.Response[devkitv1.SectionDeleteRestoreResponse], error) {
	resp, err := api.tenantUsecase.SectionDeleteRestore(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
