package api

import (
	"context"

	"connectrpc.com/connect"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
)

func (api *Api) RoleCreate(ctx context.Context, req *connect.Request[apiv1.RoleCreateRequest]) (*connect.Response[apiv1.RoleCreateResponse], error) {
	log.Debug().Msg("validatiing")
	err := api.validator.Validate(req.Msg)

	log.Debug().Interface("validate err is", err).Msg("err")
	if err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, err)
	}
	response, err := api.accountsUscase.RoleCreate(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}
