package api

import (
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"google.golang.org/protobuf/types/known/emptypb"
)

func (api *Api) IconsCreateUpdateBulk(ctx context.Context, req *connect.Request[devkitv1.IconsCreateUpdateBulkRequest]) (*connect.Response[devkitv1.IconsListResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	resp, err := api.publicUsecase.IconsCreateUpdateBulk(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}

func (api *Api) IconsInputList(ctx context.Context, req *connect.Request[emptypb.Empty]) (*connect.Response[devkitv1.IconsListResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	resp, err := api.publicUsecase.IconsInputList(ctx)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
