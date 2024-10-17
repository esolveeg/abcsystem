package usecase

import (
	"context"

	"github.com/darwishdev/devkit-api/db"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/darwishdev/devkit-api/redisclient"
	"github.com/google/uuid"
	"github.com/rs/zerolog/log"
	"github.com/supabase-community/auth-go/types"
)

func (u *AccountsUsecase) UsersDeleteRestore(ctx context.Context, req *apiv1.DeleteRestoreRequest) error {
	err := u.repo.UsersDeleteRestore(ctx, req.Records)
	if err != nil {
		return err
	}
	return nil
}
func (u *AccountsUsecase) UsersList(ctx context.Context) (*apiv1.UsersListResponse, error) {
	users, err := u.repo.UsersList(ctx)
	if err != nil {
		return nil, err
	}
	response := u.adapter.UsersListGrpcFromSql(users)
	return response, nil
}
func (u *AccountsUsecase) UserCreateUpdate(ctx context.Context, req *apiv1.UserCreateUpdateRequest) (*apiv1.UserCreateUpdateResponse, error) {
	supabasRequest := types.AdminUpdateUserRequest{
		Email:    req.UserEmail,
		Password: req.UserPassword,
	}
	if req.UserId != 0 {
		userID, err := u.repo.AuthUserIDFindByEmail(ctx, req.UserEmail)
		if err != nil {
			return nil, err
		}
		uuid, err := uuid.Parse(*userID)
		if err != nil {
			return nil, err
		}
		supabasRequest.Phone = req.UserPhone
		supabasRequest.UserID = uuid
	}
	_, err := u.supaapi.UserCreateUpdate(supabasRequest)
	if err != nil {
		return nil, err
	}
	userCreateParams := u.adapter.UserCreateUpdateSqlFromGrpc(req)
	user, err := u.repo.UserCreateUpdate(ctx, *userCreateParams)
	if err != nil {
		return nil, err
	}

	resp := u.adapter.UserCreateUpdateGrpcFromSql(user)
	return resp, nil
}
func (u *AccountsUsecase) userGenerateTokens(ctx context.Context, username string, userID int32) (*apiv1.LoginInfo, error) {
	accessToken, accessPayload, err := u.tokenMaker.CreateToken(username, userID, u.tokenDuration)
	if err != nil {
		return nil, err
	}
	loginInfo := &devkitv1.LoginInfo{
		AccessToken:          accessToken,
		AccessTokenExpiresAt: accessPayload.ExpiredAt.Format("2006-01-02 15:04:05"),
	}
	return loginInfo, nil
}
func (u *AccountsUsecase) AppLogin(ctx context.Context, loginCode string) (*apiv1.UserLoginResponse, redisclient.PermissionsMap, error) {
	user, err := u.repo.UserFind(ctx, db.UserFindParams{SearchKey: loginCode})
	if err != nil {
		return nil, nil, err
	}
	permissions, err := u.repo.UserPermissionsMap(ctx, user.UserID)
	if err != nil {
		return nil, nil, err
	}
	permissionsMap, err := u.redisClient.AuthSessionCreate(ctx, loginCode, permissions)
	if err != nil {
		return nil, nil, err
	}
	response := u.adapter.UserLoginGrpcFromSql(user)
	if err != nil {
		return nil, nil, err
	}

	return response, permissionsMap, nil

}
func (u *AccountsUsecase) UserLogin(ctx context.Context, req *apiv1.UserLoginRequest) (*apiv1.UserLoginResponse, error) {
	userFindParams, supabaseRequest := u.adapter.UserLoginSqlFromGrpc(req)
	_, err := u.supaapi.AuthClient.Token(*supabaseRequest)
	if err != nil {
		return nil, err
	}
	response, _, err := u.AppLogin(ctx, userFindParams.SearchKey)

	loginInfo, err := u.userGenerateTokens(ctx, req.LoginCode, response.User.UserId)
	if err != nil {
		return nil, err
	}
	response.LoginInfo = loginInfo

	return response, nil
}

func (u *AccountsUsecase) UserInvite(ctx context.Context, req *apiv1.UserInviteRequest) (*apiv1.UserInviteResponse, error) {
	_, err := u.supaapi.AuthClient.Invite(types.InviteRequest{Email: req.UserEmail})
	if err != nil {
		return nil, err
	}
	return &apiv1.UserInviteResponse{
		Message: "invitation sent",
	}, nil
}
func (u *AccountsUsecase) UserLoginProvider(ctx context.Context, req *apiv1.UserLoginProviderRequest) (*apiv1.UserLoginProviderResponse, error) {
	resp, err := u.supaapi.ProviderLogin(types.Provider(req.Provider), req.RedirectUrl)
	if err != nil {
		return nil, err
	}
	return &apiv1.UserLoginProviderResponse{
		Url: resp.AuthorizationURL,
	}, nil
}
func (u *AccountsUsecase) UserResetPasswordEmail(ctx context.Context, req *apiv1.UserResetPasswordEmailRequest) (*apiv1.UserResetPasswordEmailResponse, error) {
	err := u.supaapi.AuthClient.Recover(types.RecoverRequest{Email: req.Email})
	if err != nil {
		return nil, err
	}
	return &apiv1.UserResetPasswordEmailResponse{}, nil
}
func (u *AccountsUsecase) UserResetPassword(ctx context.Context, req *apiv1.UserResetPasswordRequest) (*apiv1.UserLoginResponse, error) {
	if len(req.ResetToken) == 6 {
		resp, err := u.supaapi.AuthClient.VerifyForUser(types.VerifyForUserRequest{Type: types.VerificationTypeRecovery, Token: req.ResetToken, Email: req.Email, RedirectTo: "http://localhost:3000/"})
		if err != nil {
			log.Debug().Msg("verify error")
			return nil, err
		}
		req.ResetToken = resp.AccessToken
	}
	user, err := u.supaapi.AuthClient.WithToken(req.ResetToken).GetUser()
	if err != nil {
		log.Debug().Msg("get error")
		return nil, err
	}
	_, err = u.supaapi.AuthClient.AdminUpdateUser(types.AdminUpdateUserRequest{UserID: user.ID, Email: req.Email, Password: req.NewPassword})
	if err != nil {
		log.Debug().Msg("update error")
		return nil, err
	}
	resp, err := u.UserLogin(ctx, &apiv1.UserLoginRequest{LoginCode: req.Email, UserPassword: req.NewPassword})
	if err != nil {
		return nil, err
	}
	return resp, nil
}
func (u *AccountsUsecase) UserLoginProviderCallback(ctx context.Context, req *apiv1.UserLoginProviderCallbackRequest) (*apiv1.UserLoginResponse, error) {
	user, err := u.supaapi.AuthClient.WithToken(req.AccessToken).GetUser()
	if err != nil {
		return nil, err
	}
	resp, _, err := u.AppLogin(ctx, user.Email)
	if err != nil {
		return nil, err
	}
	return resp, nil
}
