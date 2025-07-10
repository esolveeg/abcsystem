package api

import (
	// INJECT IMPORTS
	"context"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/pkg/headerkeys"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) SectionListInpt(ctx context.Context, req *connect.Request[devkitv1.SectionListInptRequest]) (*connect.Response[devkitv1.SectionListInptResponse], error) {
	resp, err := api.tenantUsecase.SectionListInpt(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}

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
	resp.Options = api.getAvailableOptions(req.Header())
	if resp.Options.UpdateHandler != nil {
		resp.Options.UpdateHandler.FindEndpoint = "tenantFind"
		resp.Options.UpdateHandler.FindRequestProperty = "tenantId"
		resp.Options.UpdateHandler.FindResponseProperty = "tenant"
	}
	return connect.NewResponse(resp), nil

}
func (api *Api) TenantListInput(ctx context.Context, req *connect.Request[devkitv1.TenantListInputRequest]) (*connect.Response[devkitv1.TenantListInputResponse], error) {
	resp, err := api.tenantUsecase.TenantListInput(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil

}

func (api *Api) TenantFind(ctx context.Context, req *connect.Request[devkitv1.TenantFindRequest]) (*connect.Response[devkitv1.TenantFindResponse], error) {
	resp, err := api.tenantUsecase.TenantFind(ctx, req)
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

func (api *Api) TenantDashboard(ctx context.Context, req *connect.Request[devkitv1.TenantDashboardRequest]) (*connect.Response[devkitv1.TenantDashboardResponse], error) {
	resp, err := api.tenantUsecase.TenantDashboard(ctx, req)
	if err != nil {
		return nil, err
	}
	pageListReq := connect.NewRequest(&devkitv1.PageListRequest{})
	permissGroup, err := api.CheckForAccess(ctx, "PageList", "page")
	if err != nil {
		return nil, err
	}

	// pageListReq.Header().Add(key string, value string)
	headerkeys.WithPermissionGroup(pageListReq.Header(), "page")
	headerkeys.WithPermittedActions(pageListReq.Header(), *permissGroup)
	pagesResponse, err := api.PageList(ctx, pageListReq)
	if err != nil {
		return nil, err
	}
	resp.Pages = pagesResponse.Msg
	return connect.NewResponse(resp), nil
}
func (api *Api) PartialTypeListInput(ctx context.Context, req *connect.Request[devkitv1.PartialTypeListInputRequest]) (*connect.Response[devkitv1.PartialTypeListInputResponse], error) {
	resp, err := api.tenantUsecase.PartialTypeListInput(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
