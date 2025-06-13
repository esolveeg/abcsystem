package usecase

import (
	"context"
	"fmt"
	"strings"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/contextkeys"
	"github.com/darwishdev/devkit-api/pkg/redisclient"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
	"github.com/supabase-community/auth-go/types"
)

func (u *AccountsUsecase) AuthSessionDelete(
	ctx context.Context,
	req *connect.Request[devkitv1.AuthSessionDeleteRequest],
) (*devkitv1.AuthSessionDeleteResponse, error) {
	err := u.redisClient.AuthSessionDeleteByKey(ctx, req.Msg.SessionKey)
	if err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	return &devkitv1.AuthSessionDeleteResponse{
		Message: "Session deleted successfully",
	}, nil
}
func (u *AccountsUsecase) AuthSessionList(ctx context.Context, req *connect.Request[devkitv1.AuthSessionListRequest]) (*devkitv1.AuthSessionListResponse, error) {
	var sessions []*redisclient.AuthSession
	var err error
	if req.Msg.UserId > 0 {
		sessions, err = u.redisClient.AuthSessionListByUser(ctx, req.Msg.UserId)
	} else {
		sessions, err = u.redisClient.AuthSessionListAll(ctx)
	}
	if err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}

	response := u.adapter.AuthSessionListGrpcFromRedis(sessions)
	return response, nil
}
func (u *AccountsUsecase) AuthSessionSetBlocked(
	ctx context.Context,
	req *connect.Request[devkitv1.AuthSessionSetBlockedRequest],
) (*devkitv1.AuthSessionSetBlockedResponse, error) {
	err := u.redisClient.AuthSessionSetBlockedByKey(ctx, req.Msg.SessionKey, req.Msg.IsBlocked)
	if err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	return &devkitv1.AuthSessionSetBlockedResponse{
		Message: "Session block status updated successfully",
	}, nil
}
func (u *AccountsUsecase) AuthLogout(
	ctx context.Context,
	req *connect.Request[devkitv1.AuthLogoutRequest],
) (*devkitv1.AuthLogoutResponse, error) {
	// Extract app-level refresh token
	refreshToken, ok := contextkeys.RefreshToken(ctx)
	if !ok {
		return nil, connect.NewError(connect.CodeUnauthenticated, fmt.Errorf("refresh_token_not_passed"))
	}

	// Extract Supabase access token
	supabaseToken, ok := contextkeys.SupabaseToken(ctx)
	if !ok {
		return nil, connect.NewError(connect.CodeUnauthenticated, fmt.Errorf("supabase_token_not_passed"))
	}
	// Verify app refresh token and get payload
	payload, err := u.tokenMaker.VerifyRefreshToken(refreshToken)
	if err != nil {
		return nil, connect.NewError(connect.CodeUnauthenticated, fmt.Errorf("invalid refresh token"))
	}

	// Delete Redis session by userID + tokenID
	err = u.redisClient.AuthSessionDelete(ctx, payload.UserId, payload.ID.String())
	if err != nil {
		log.Error().Err(err).Msg("failed to delete redis auth session")
	}

	// Revoke Supabase session
	err = u.supaapi.AuthClient.WithToken(supabaseToken).Logout()
	if err != nil {
		log.Warn().Err(err).Msg("supabase sign out failed")
		// Optional: proceed anyway
	}

	return &devkitv1.AuthLogoutResponse{}, nil
}
func (u *AccountsUsecase) AuthRefreshToken(
	ctx context.Context,
	req *connect.Request[devkitv1.AuthRefreshTokenRequest],
) (*devkitv1.AuthRefreshTokenResponse, error) {
	refreshToken, ok := contextkeys.RefreshToken(ctx)
	log.Debug().Interface("Refresh", refreshToken).Msg("refresh")
	log.Debug().Interface("Refresh", ok).Msg("refresh")
	if !ok {
		return nil, connect.NewError(connect.CodeUnauthenticated, fmt.Errorf("refresh_token_not_passed"))
	}

	// // 1. Validate refresh token
	payload, err := u.tokenMaker.VerifyRefreshToken(refreshToken)
	if err != nil {
		return nil, connect.NewError(connect.CodeUnauthenticated, fmt.Errorf("invalid refresh token"))
	}
	user, err := u.repo.UserFindForToken(ctx, &db.UserFindForTokenParams{UserID: payload.UserId})
	loginInfo, _, err := u.UserGenerateTokens(
		user.UserEmail,
		user.UserID,
		user.TenantID.Int32,
		user.UserSecurityLevel,
	)
	// // 2. Generate new tokens
	if err != nil {
		return nil, err
	}

	// // 3. Return new tokens
	return &devkitv1.AuthRefreshTokenResponse{
		LoginInfo: loginInfo,
	}, nil
}
func (u *AccountsUsecase) UserGenerateTokens(username string, userId int32, tenantId int32, userSecurityLevel int32) (*devkitv1.LoginInfo, string, error) {
	tokens, err := u.tokenMaker.CreateTokenPair(
		username,
		userId,
		userSecurityLevel,
		tenantId,
		u.tokenDuration,        // Access token TTL
		u.refreshTokenDuration, // Refresh token TTL
	)
	if err != nil {
		return nil, "", err
	}
	return &devkitv1.LoginInfo{
		AccessToken:           tokens.AccessToken,
		RefreshToken:          tokens.RefreshToken,
		AccessTokenExpiresAt:  db.TimeToString(tokens.AccessPayload.ExpiredAt),
		RefreshTokenExpiresAt: db.TimeToString(tokens.RefreshPayload.ExpiredAt),
	}, tokens.AccessPayload.ID.String(), nil
}

func (u *AccountsUsecase) AppLogin(ctx context.Context, loginCode string, userId int32) (*devkitv1.AuthLoginResponse, error) {
	user, err := u.repo.UserFind(ctx, db.UserFindParams{SearchKey: loginCode, UserID: userId})
	if err != nil {
		return nil, err
	}
	if user == nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("user not found"))
	}
	permissions, err := u.repo.UserPermissionsMap(ctx, user.UserID)
	if err != nil {
		return nil, err
	}
	if len(*permissions) > 0 {
		permissionsMap, err := u.adapter.UserPermissionsMapRedisFromSql(permissions)
		if err != nil {
			return nil, err
		}
		err = u.redisClient.UserPermissionCreate(ctx, user.UserID, permissionsMap)
		if err != nil {
			return nil, err
		}
	}
	response := u.adapter.AuthLoginGrpcFromSql(user)
	if err != nil {
		return nil, err
	}
	return response, nil
}

func (u *AccountsUsecase) AuthRegister(ctx context.Context, req *connect.Request[devkitv1.AuthRegisterRequest]) (*devkitv1.AuthRegisterResponse, error) {
	userCreateRequest := u.adapter.UserCreateUpdateRequestFromAuthRegister(req.Msg)
	user, err := u.UserCreateUpdate(contextkeys.WithCallerID(ctx, 1), connect.NewRequest(userCreateRequest))
	if err != nil {
		return nil, err
	}
	loginInfo, _, err := u.UserGenerateTokens(user.User.UserEmail, user.User.UserId, user.User.UserSecurityLevel, user.User.TenantId)
	if err != nil {
		return nil, err
	}
	_, supabaseRequest := u.adapter.AuthLoginSqlFromGrpc(&devkitv1.AuthLoginRequest{LoginCode: req.Msg.UserEmail, UserPassword: req.Msg.UserPassword})
	supaResponse, err := u.supaapi.AuthClient.Token(*supabaseRequest)
	if err != nil {
		if strings.Contains(strings.ToLower(err.Error()), "invalid login credentials") {
			return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("invalid login"))
		}
		return nil, err
	}
	loginInfo.SupabaseRefreshToken = supaResponse.RefreshToken
	loginInfo.SupabaseToken = supaResponse.AccessToken

	return &devkitv1.AuthRegisterResponse{
		User:      user.User,
		LoginInfo: loginInfo,
	}, nil
}
func (u *AccountsUsecase) AuthLogin(ctx context.Context, req *connect.Request[devkitv1.AuthLoginRequest]) (*devkitv1.AuthLoginResponse, error) {
	userFindParams, supabaseRequest := u.adapter.AuthLoginSqlFromGrpc(req.Msg)
	supaResponse, err := u.supaapi.AuthClient.Token(*supabaseRequest)
	if err != nil {
		if strings.Contains(strings.ToLower(err.Error()), "invalid login credentials") {
			return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("invalid login"))
		}
		return nil, err
	}
	response, err := u.AppLogin(ctx, userFindParams.SearchKey, 0)
	if err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("invalid  app login"))
	}
	loginInfo, tokenID, err := u.UserGenerateTokens(req.Msg.LoginCode, response.User.UserId, response.User.TenantId, response.User.UserSecurityLevel)
	if err != nil {
		return nil, err
	}
	loginInfo.SupabaseRefreshToken = supaResponse.RefreshToken
	loginInfo.SupabaseToken = supaResponse.AccessToken
	response.LoginInfo = loginInfo
	navigtionBarRequest := db.UserNavigationBarFindParams{
		UserID:          response.User.UserId,
		NavigationBarID: response.User.UserTypeId,
	}
	navigationBar, err := u.repo.UserNavigationBarFind(ctx, navigtionBarRequest)
	if err != nil {
		return nil, err
	}
	if len(*navigationBar) > 0 {
		navigations, err := u.adapter.UserNavigationBarFindGrpcFromSql(*navigationBar)
		if err != nil {
			return nil, err
		}
		response.NavigationBar = navigations
	}
	authSession, err := u.adapter.AuttSessionRedisFromGrpc(response, req.Peer().Addr, req.Header().Get("User-Agent"))
	if err != nil {
		return nil, err
	}
	authSession.TokenID = tokenID
	err = u.redisClient.AuthSessionDeleteByUserAgent(ctx, authSession.UserID, authSession.UserAgent)
	if err != nil {
		return nil, err
	}
	err = u.redisClient.AuthSessionCreate(ctx, authSession, tokenID, u.refreshTokenDuration)
	if err != nil {
		return nil, err
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

func (u *AccountsUsecase) AuthLoginProviderCallback(ctx context.Context, req *connect.Request[devkitv1.AuthLoginProviderCallbackRequest]) (*devkitv1.AuthLoginProviderCallbackResponse, error) {
	user, err := u.supaapi.AuthClient.WithToken(req.Msg.AccessToken).GetUser()
	if err != nil {
		return nil, err
	}
	if err != nil {
		return nil, err
	}
	response, err := u.AppLogin(ctx, user.Email, 0)
	if err != nil {
		return nil, err
	}
	loginInfo, tokenID, err := u.UserGenerateTokens(user.Email, response.User.UserId, response.User.TenantId, response.User.UserSecurityLevel)
	if err != nil {
		return nil, err
	}

	loginInfo.SupabaseToken = req.Msg.AccessToken
	loginInfo.SupabaseRefreshToken = req.Msg.RefreshToken
	response.LoginInfo = loginInfo
	authSession, err := u.adapter.AuttSessionRedisFromGrpc(response, req.Peer().Addr, req.Header().Get("User-Agent"))
	authSession.TokenID = tokenID
	if err != nil {
		return nil, err
	}

	err = u.redisClient.AuthSessionDeleteByUserAgent(ctx, authSession.UserID, authSession.UserAgent)
	if err != nil {
		return nil, err
	}
	err = u.redisClient.AuthSessionCreate(ctx, authSession, tokenID, u.refreshTokenDuration)
	if err != nil {
		return nil, err
	}

	return &devkitv1.AuthLoginProviderCallbackResponse{
		User:          response.User,
		NavigationBar: response.NavigationBar,
		LoginInfo:     response.LoginInfo,
	}, nil
}
