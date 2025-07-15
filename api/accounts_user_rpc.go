package api

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) UserPermissionListInput(ctx context.Context, req *connect.Request[devkitv1.UserPermissionListInputRequest]) (*connect.Response[devkitv1.UserPermissionListInputResponse], error) {
	response, err := api.accountsUsecase.UserPermissionListInput(ctx, req)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve users find: %w", err)
	}
	return connect.NewResponse(response), nil
}
func (api *Api) UserFind(ctx context.Context, req *connect.Request[devkitv1.UserFindRequest]) (*connect.Response[devkitv1.UserFindResponse], error) {
	response, err := api.accountsUsecase.UserFind(ctx, req)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve users find: %w", err)
	}
	response.Options = api.getAvailableOptions(req.Header(), "find")
	if response.Record.DeletedAt == "" {
		response.Options.DeleteHandler = nil
	}
	return connect.NewResponse(response), nil
}
func (api *Api) UserFindForUpdate(ctx context.Context, req *connect.Request[devkitv1.UserFindForUpdateRequest]) (*connect.Response[devkitv1.UserFindForUpdateResponse], error) {
	response, err := api.accountsUsecase.UserFindForUpdate(ctx, req)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve users list: %w", err)
	}
	return connect.NewResponse(response), nil
}
func (api *Api) UserTypeListInput(ctx context.Context, req *connect.Request[devkitv1.UserTypeListInputRequest]) (*connect.Response[devkitv1.UserTypeListInputResponse], error) {
	response, err := api.accountsUsecase.UserTypeListInput(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve users list input: %w", err)
	}
	return connect.NewResponse(response), nil
}

func (api *Api) UserListInput(ctx context.Context, req *connect.Request[devkitv1.UserListInputRequest]) (*connect.Response[devkitv1.UserListInputResponse], error) {
	response, err := api.accountsUsecase.UserListInput(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve users list input: %w", err)
	}
	return connect.NewResponse(response), nil
}
func (api *Api) UserList(ctx context.Context, req *connect.Request[devkitv1.UserListRequest]) (*connect.Response[devkitv1.UserListResponse], error) {
	response, err := api.accountsUsecase.UserList(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve users list: %w", err)
	}
	response.Options = api.getAvailableOptions(req.Header())
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
	records, err := api.accountsUsecase.UserDelete(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(records), nil
}
