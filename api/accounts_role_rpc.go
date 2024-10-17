package api

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
)

func (api *Api) RolesList(ctx context.Context, req *connect.Request[emptypb.Empty]) (*connect.Response[apiv1.RolesListResponse], error) {
	response, err := api.accountsUscase.RolesList(ctx)
	if err != nil {
		return nil, err
	}
	options, err := api.getAccessableActionsForGroup(ctx, req.Header(), "roles")
	if err != nil {
		return nil, err
	}
	response.Options = options
	return connect.NewResponse(response), nil
}
func (api *Api) RoleCreateUpdate(ctx context.Context, req *connect.Request[apiv1.RoleCreateUpdateRequest]) (*connect.Response[apiv1.RoleCreateUpdateResponse], error) {
	_, err := api.authorizeRequestHeader(ctx, req.Header())
	if err != nil {
		return nil, fmt.Errorf("invalid access token: %s", err)
	}
	err = api.validator.Validate(req.Msg)
	if err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, err)
	}
	if req.Msg.GetRoleId() == 0 && req.Msg.GetRoleName() == "" {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("role name is required if role id not passed 'create cenario'"))
	}
	response, err := api.accountsUscase.RoleCreateUpdate(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) RolesDeleteRestore(ctx context.Context, req *connect.Request[apiv1.DeleteRestoreRequest]) (*connect.Response[emptypb.Empty], error) {
	err := api.accountsUscase.RolesDeleteRestore(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&emptypb.Empty{}), nil
}
