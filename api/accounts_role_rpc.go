package api

import (
	"context"

	"connectrpc.com/connect"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/proto/devkit/v1"
)

func (api *Api) RoleCreate(ctx context.Context, req *connect.Request[apiv1.RoleCreateRequest]) (*connect.Response[apiv1.RoleCreateResponse], error) {
	response, err := api.accountsUscase.RoleCreate(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}
