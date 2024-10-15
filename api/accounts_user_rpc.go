package api

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) UsersList(ctx context.Context, req *connect.Request[apiv1.Empty]) (*connect.Response[apiv1.UsersListResponse], error) {
	response, err := api.accountsUscase.UsersList(ctx)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}
func (api *Api) UserCreateUpdate(ctx context.Context, req *connect.Request[apiv1.UserCreateUpdateRequest]) (*connect.Response[apiv1.UserCreateUpdateResponse], error) {
	err := api.validator.Validate(req.Msg)
	if err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, err)
	}
	if req.Msg.GetUserId() == 0 && (req.Msg.GetUserName() == "" || req.Msg.GetUserEmail() == "" || req.Msg.GetUserPhone() == "") {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("field is required if user id not passed 'create cenario'"))
	}
	response, err := api.accountsUscase.UserCreateUpdate(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) UsersDeleteRestore(ctx context.Context, req *connect.Request[apiv1.DeleteRestoreRequest]) (*connect.Response[apiv1.Empty], error) {
	err := api.accountsUscase.UsersDeleteRestore(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&apiv1.Empty{}), nil
}
