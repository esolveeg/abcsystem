package usecase

import (
	"context"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/contextkeys"
	"github.com/darwishdev/devkit-api/pkg/redisclient"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
	"github.com/supabase-community/auth-go/types"
)

func (u *AccountsUsecase) userGenerateTokens(username string, userId int32, tenantId int32, userSecurityLevel int32) (*devkitv1.LoginInfo, error) {
	accessToken, accessPayload, err := u.tokenMaker.CreateToken(username, userId, userSecurityLevel, tenantId, u.tokenDuration)
	if err != nil {
		return nil, err
	}
	return &devkitv1.LoginInfo{
		AccessToken:          accessToken,
		AccessTokenExpiresAt: accessPayload.ExpiredAt.Format("2006-01-02 15:04:05"),
	}, nil
}

func (u *AccountsUsecase) AppLogin(ctx context.Context, loginCode string) (*devkitv1.AuthLoginResponse, redisclient.PermissionsMap, error) {
	user, err := u.repo.UserFind(ctx, db.UserFindParams{SearchKey: loginCode})
	if err != nil {
		return nil, nil, err
	}
	permissions, err := u.repo.UserPermissionsMap(ctx, user.UserID)
	if err != nil {
		return nil, nil, err
	}
	response := u.adapter.AuthLoginGrpcFromSql(user)
	if len(*permissions) > 0 {
		permissionsMap, err := u.redisClient.AuthSessionCreate(ctx, user.UserID, permissions)
		if err != nil {
			return nil, nil, err
		}
		return response, permissionsMap, nil
	}
	return response, nil, nil
}

func (u *AccountsUsecase) AuthRegister(ctx context.Context, req *connect.Request[devkitv1.AuthRegisterRequest]) (*devkitv1.AuthRegisterResponse, error) {
	userCreateRequest := u.adapter.UserCreateUpdateRequestFromAuthRegister(req.Msg)
	user, err := u.UserCreateUpdate(contextkeys.WithCallerID(ctx, 1), connect.NewRequest(userCreateRequest))
	if err != nil {
		return nil, err
	}
	loginInfo, err := u.userGenerateTokens(user.User.UserEmail, user.User.UserId, user.User.UserSecurityLevel, user.User.CompanyId)
	if err != nil {
		return nil, err
	}
	return &devkitv1.AuthRegisterResponse{
		User:      user.User,
		LoginInfo: loginInfo,
	}, nil
}

func (u *AccountsUsecase) AuthLogin(ctx context.Context, req *connect.Request[devkitv1.AuthLoginRequest]) (*devkitv1.AuthLoginResponse, error) {
	userFindParams, supabaseRequest := u.adapter.AuthLoginSqlFromGrpc(req.Msg)
	_, err := u.supaapi.AuthClient.Token(*supabaseRequest)
	if err != nil {
		log.Debug().Interface("supa err here", err).Msg("error")
		return nil, err
	}
	response, _, err := u.AppLogin(ctx, userFindParams.SearchKey)
	if err != nil {
		return nil, err
	}
	loginInfo, err := u.userGenerateTokens(req.Msg.LoginCode, response.User.UserId, response.User.UserSecurityLevel, response.User.CompanyId)
	if err != nil {
		return nil, err
	}
	response.LoginInfo = loginInfo
	if response.User.UserTypeId == 1 {
		navigtionBarRequest := db.UserNavigationBarFindParams{
			UserID:          response.User.UserId,
			NavigationBarID: 1,
		}
		navigationBar, err := u.repo.UserNavigationBarFind(ctx, navigtionBarRequest)
		if err != nil {
			return nil, err
		}
		navigations, err := u.adapter.UserNavigationBarFindGrpcFromSql(*navigationBar)
		if err != nil {
			return nil, err
		}

		response.NavigationBar = navigations
	}
	return response, nil
}

func (u *AccountsUsecase) AuthLoginProvider(ctx context.Context, req *connect.Request[devkitv1.AuthLoginProviderRequest]) (*devkitv1.AuthLoginProviderResponse, error) {
	resp, err := u.supaapi.ProviderLogin(types.Provider(req.Msg.Provider), req.Msg.RedirectUrl)
	if err != nil {
		return nil, err
	}
	return &devkitv1.AuthLoginProviderResponse{Url: resp.AuthorizationURL}, nil
}

func (u *AccountsUsecase) AuthInvite(ctx context.Context, req *connect.Request[devkitv1.AuthInviteRequest]) (*devkitv1.AuthInviteResponse, error) {
	_, err := u.supaapi.AuthClient.Invite(types.InviteRequest{Email: req.Msg.UserEmail})
	if err != nil {
		return nil, err
	}
	return &devkitv1.AuthInviteResponse{Message: "invitation sent"}, nil
}

func (u *AccountsUsecase) AuthResetPassword(ctx context.Context, req *connect.Request[devkitv1.AuthResetPasswordRequest]) (*devkitv1.AuthResetPasswordResponse, error) {
	if len(req.Msg.ResetToken) == 6 {
		resp, err := u.supaapi.AuthClient.VerifyForUser(*u.adapter.AuthResetPasswordSupaFromGrpc(req.Msg))
		if err != nil {
			return nil, err
		}
		req.Msg.ResetToken = resp.AccessToken
	}
	user, err := u.supaapi.AuthClient.WithToken(req.Msg.ResetToken).GetUser()
	if err != nil {
		return nil, err
	}
	_, err = u.supaapi.AuthClient.AdminUpdateUser(types.AdminUpdateUserRequest{UserID: user.ID, Email: req.Msg.Email, Password: req.Msg.NewPassword})
	if err != nil {
		return nil, err
	}
	return &devkitv1.AuthResetPasswordResponse{}, nil
}

func (u *AccountsUsecase) AuthResetPasswordEmail(ctx context.Context, req *connect.Request[devkitv1.AuthResetPasswordEmailRequest]) (*devkitv1.AuthResetPasswordEmailResponse, error) {
	err := u.supaapi.AuthClient.Recover(types.RecoverRequest{Email: req.Msg.Email})
	if err != nil {
		return nil, err
	}
	return &devkitv1.AuthResetPasswordEmailResponse{}, nil
}

func (u *AccountsUsecase) AuthLoginProviderCallback(ctx context.Context, req *connect.Request[devkitv1.AuthLoginProviderCallbackRequest]) (*devkitv1.AuthLoginResponse, error) {
	user, err := u.supaapi.AuthClient.WithToken(req.Msg.AccessToken).GetUser()
	if err != nil {
		return nil, err
	}
	resp, _, err := u.AppLogin(ctx, user.Email)
	if err != nil {
		return nil, err
	}
	return resp, nil
}
