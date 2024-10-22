package api

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
)

func (api *Api) UsersList(ctx context.Context, req *connect.Request[emptypb.Empty]) (*connect.Response[apiv1.UsersListResponse], error) {
	userPayload, err := api.authorizeRequestHeader(ctx, req.Header())
	if err != nil {
		return nil, fmt.Errorf("invalid access token: %s", err)
	}

	permissionMap, err := api.authrorizedUserPermissions(ctx, userPayload)
	_, ok := permissionMap["users"]
	if !ok {
		return nil, fmt.Errorf("user don't have the permissions")
	}

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

func (api *Api) UserLoginProvider(ctx context.Context, req *connect.Request[apiv1.UserLoginProviderRequest]) (*connect.Response[apiv1.UserLoginProviderResponse], error) {
	err := api.validator.Validate(req.Msg)
	if err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, err)
	}
	response, err := api.accountsUscase.UserLoginProvider(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) UserResetPassword(ctx context.Context, req *connect.Request[apiv1.UserResetPasswordRequest]) (*connect.Response[apiv1.UserLoginResponse], error) {
	err := api.validator.Validate(req.Msg)
	if err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, err)
	}

	if req.Msg.NewPassword != req.Msg.NewPasswordConfirmation {

		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("password confirmation not match"))
	}
	response, err := api.accountsUscase.UserResetPassword(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) UserResetPasswordEmail(ctx context.Context, req *connect.Request[apiv1.UserResetPasswordEmailRequest]) (*connect.Response[apiv1.UserResetPasswordEmailResponse], error) {
	err := api.validator.Validate(req.Msg)
	if err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, err)
	}
	response, err := api.accountsUscase.UserResetPasswordEmail(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) UserInvite(ctx context.Context, req *connect.Request[apiv1.UserInviteRequest]) (*connect.Response[apiv1.UserInviteResponse], error) {
	err := api.validator.Validate(req.Msg)
	if err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, err)
	}
	response, err := api.accountsUscase.UserInvite(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) UserLogin(ctx context.Context, req *connect.Request[apiv1.UserLoginRequest]) (*connect.Response[apiv1.UserLoginResponse], error) {
	err := api.validator.Validate(req.Msg)
	if err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, err)
	}
	response, err := api.accountsUscase.UserLogin(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}
func (api *Api) UsersDeleteRestore(ctx context.Context, req *connect.Request[apiv1.DeleteRestoreRequest]) (*connect.Response[emptypb.Empty], error) {
	err := api.validator.Validate(req.Msg)
	if err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, err)
	}
	err = api.accountsUscase.UsersDeleteRestore(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&emptypb.Empty{}), nil
}
func (api *Api) UserAuthorize(ctx context.Context, req *connect.Request[emptypb.Empty]) (*connect.Response[apiv1.UserLoginResponse], error) {
	payload, err := api.authorizeRequestHeader(ctx, req.Header())
	if err != nil {
		return nil, fmt.Errorf("invalid access token: %s", err)
	}
	response, _, err := api.accountsUscase.AppLogin(ctx, payload.Username)

	return connect.NewResponse(response), nil
}
