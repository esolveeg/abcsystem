package api

import (
	"context"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) UploadFile(ctx context.Context, req *connect.Request[devkitv1.UploadFileRequest]) (*connect.Response[devkitv1.UploadFileResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}

	resp, err := api.publicUsecase.UploadFile(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
func (api *Api) UploadFiles(ctx context.Context, req *connect.Request[devkitv1.UploadFilesRequest]) (*connect.Response[devkitv1.UploadFileResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}

	resp, err := api.publicUsecase.UploadFiles(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}
