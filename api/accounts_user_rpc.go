package api

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) UserList(ctx context.Context, req *connect.Request[devkitv1.UserListRequest]) (*connect.Response[devkitv1.UserListResponse], error) {
	// options, err := api.accountsUsecase.CheckForAccess(ctx, req.Header(), getCurrentFuncName(), true)
	// if err != nil {
	// 	return nil, err
	// }
	//
	response, err := api.accountsUsecase.UserList(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve users list: %w", err)
	}
	// response.Options = options
	return connect.NewResponse(response), nil
}

func (api *Api) UserCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.UserCreateUpdateRequest]) (*connect.Response[devkitv1.UserCreateUpdateResponse], error) {
	err := api.validator.Validate(req.Msg)
	if err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("validation error: %w", err))
	}
	if req.Msg.GetUserId() == 0 && (req.Msg.GetUserName() == "" || req.Msg.GetUserEmail() == "" || req.Msg.GetUserPhone() == "") {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("user ID is missing; name, email, and phone are required for creating a new user"))
	}
	_, err = api.authorizeRequestHeader(req.Header())
	response, err := api.accountsUsecase.UserCreateUpdate(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) UserDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.UserDeleteRestoreRequest]) (*connect.Response[devkitv1.UserDeleteRestoreResponse], error) {
	_, err := api.accountsUsecase.UserDeleteRestore(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&devkitv1.UserDeleteRestoreResponse{}), nil
}

func (api *Api) UserDelete(ctx context.Context, req *connect.Request[devkitv1.UserDeleteRequest]) (*connect.Response[devkitv1.UserDeleteResponse], error) {
	_, err := api.accountsUsecase.UserDelete(ctx, req.Msg.RecordId)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&devkitv1.UserDeleteResponse{}), nil
}
