package api

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/pkg/contextkeys"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) AuthRegister(ctx context.Context, req *connect.Request[devkitv1.AuthRegisterRequest]) (*connect.Response[devkitv1.AuthRegisterResponse], error) {
	response, err := api.accountsUsecase.AuthRegister(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}
func (api *Api) AuthLogin(ctx context.Context, req *connect.Request[devkitv1.AuthLoginRequest]) (*connect.Response[devkitv1.AuthLoginResponse], error) {
	response, err := api.accountsUsecase.AuthLogin(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) AuthResetPasswordEmail(ctx context.Context, req *connect.Request[devkitv1.AuthResetPasswordEmailRequest]) (*connect.Response[devkitv1.AuthResetPasswordEmailResponse], error) {
	response, err := api.accountsUsecase.AuthResetPasswordEmail(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}
func (api *Api) AuthResetPassword(ctx context.Context, req *connect.Request[devkitv1.AuthResetPasswordRequest]) (*connect.Response[devkitv1.AuthResetPasswordResponse], error) {
	err := api.validator.Validate(req.Msg)
	if err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("validation error: %w", err))
	}
	if req.Msg.NewPassword != req.Msg.NewPasswordConfirmation {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("password and confirmation do not match"))
	}
	payload, err := api.authorizeRequestHeader(req.Header())
	if err != nil {
		return nil, connect.NewError(connect.CodeUnauthenticated, fmt.Errorf("invalid access token: %w", err))
	}
	req.Msg.Email = payload.Username
	response, err := api.accountsUsecase.AuthResetPassword(ctx, req)
	if err != nil {
		return nil, fmt.Errorf("failed to reset password: %w", err)
	}
	return connect.NewResponse(response), nil
}

func (api *Api) AuthAuthorize(ctx context.Context, req *connect.Request[devkitv1.AuthAuthorizeRequest]) (*connect.Response[devkitv1.AuthAuthorizeResponse], error) {
	callerID, ok := contextkeys.CallerID(ctx)
	if !ok {
		return nil, fmt.Errorf("unauthorized")
	}
	response, _, err := api.accountsUsecase.AppLogin(ctx, "", callerID)
	if err != nil {
		return nil, fmt.Errorf("failed to authorize user: %w", err)
	}
	return connect.NewResponse(&devkitv1.AuthAuthorizeResponse{
		User: response.User,
	}), nil
}
