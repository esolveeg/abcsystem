package api

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
)

func (api *Api) UsersList(ctx context.Context, req *connect.Request[emptypb.Empty]) (*connect.Response[apiv1.UsersListResponse], error) {
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
	response, err := api.accountsUscase.UserLoginProvider(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) UserResetPassword(ctx context.Context, req *connect.Request[apiv1.UserResetPasswordRequest]) (*connect.Response[apiv1.UserLoginResponse], error) {
	response, err := api.accountsUscase.UserResetPassword(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) UserResetPasswordEmail(ctx context.Context, req *connect.Request[apiv1.UserResetPasswordEmailRequest]) (*connect.Response[apiv1.UserResetPasswordEmailResponse], error) {
	response, err := api.accountsUscase.UserResetPasswordEmail(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) UserInvite(ctx context.Context, req *connect.Request[apiv1.UserInviteRequest]) (*connect.Response[apiv1.UserInviteResponse], error) {
	response, err := api.accountsUscase.UserInvite(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) UserLogin(ctx context.Context, req *connect.Request[apiv1.UserLoginRequest]) (*connect.Response[apiv1.UserLoginResponse], error) {
	response, err := api.accountsUscase.UserLogin(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}
func (api *Api) UsersDeleteRestore(ctx context.Context, req *connect.Request[apiv1.DeleteRestoreRequest]) (*connect.Response[emptypb.Empty], error) {
	err := api.accountsUscase.UsersDeleteRestore(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&emptypb.Empty{}), nil
}
