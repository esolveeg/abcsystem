package api

import (
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) IconCreateUpdateBulk(ctx context.Context, req *connect.Request[devkitv1.IconCreateUpdateBulkRequest]) (*connect.Response[devkitv1.IconCreateUpdateBulkResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	_, err := api.checkForAccess(req.Header(), "icon", "create")
	if err != nil {
		return nil, err
	}
	_, err = api.publicUsecase.IconCreateUpdateBulk(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&devkitv1.IconCreateUpdateBulkResponse{}), nil
}

func (api *Api) IconFind(ctx context.Context, req *connect.Request[devkitv1.IconFindRequest]) (*connect.Response[devkitv1.IconFindResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	resp, err := api.publicUsecase.IconFind(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
func (api *Api) IconList(ctx context.Context, req *connect.Request[devkitv1.IconListRequest]) (*connect.Response[devkitv1.IconListResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	resp, err := api.publicUsecase.IconList(ctx)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
