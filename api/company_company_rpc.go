package api

import (
	// INJECT IMPORTS
	"connectrpc.com/connect"
	"context"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) CompanyCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.CompanyCreateUpdateRequest]) (*connect.Response[devkitv1.CompanyCreateUpdateResponse], error) {
	resp, err := api.companyUsecase.CompanyCreateUpdate(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
func (api *Api) CompanyList(ctx context.Context, req *connect.Request[devkitv1.CompanyListRequest]) (*connect.Response[devkitv1.CompanyListResponse], error) {
	resp, err := api.companyUsecase.CompanyList(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil

}
func (api *Api) CompanyDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.CompanyDeleteRestoreRequest]) (*connect.Response[devkitv1.CompanyDeleteRestoreResponse], error) {
	resp, err := api.companyUsecase.CompanyDeleteRestore(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil

}
