package api

import (
	"connectrpc.com/connect"
	"context"
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) EmailSend(ctx context.Context, req *connect.Request[devkitv1.EmailSendRequest]) (*connect.Response[devkitv1.EmailSendResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	response, err := api.publicUsecase.EmailSend(ctx, req.Msg)
	return connect.NewResponse(response), err
}
