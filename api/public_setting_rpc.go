package api

import (
	"context"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) SettingUpdate(ctx context.Context, req *connect.Request[devkitv1.SettingUpdateRequest]) (*connect.Response[devkitv1.SettingUpdateResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	err := api.publicUsecase.SettingUpdate(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&devkitv1.SettingUpdateResponse{}), nil
}

func (api *Api) SettingFindForUpdate(ctx context.Context, req *connect.Request[devkitv1.SettingFindForUpdateRequest]) (*connect.Response[devkitv1.SettingFindForUpdateResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	resp, err := api.publicUsecase.SettingFindForUpdate(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
