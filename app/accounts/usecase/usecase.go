package usecase

import (
	"context"
	"time"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/app/accounts/adapter"
	"github.com/darwishdev/devkit-api/app/accounts/repo"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/auth"
	"github.com/darwishdev/devkit-api/pkg/redisclient"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	supaapigo "github.com/darwishdev/supaapi-go"
)

type AccountsUsecaseInterface interface {
	// CheckForAccess(ctx context.Context, header http.Header, functionName string, isCreateUpdate bool) (*devkitv1.AvailableOptions, error)
	AuthLogin(ctx context.Context, req *connect.Request[devkitv1.AuthLoginRequest]) (*devkitv1.AuthLoginResponse, error)
	AuthSessionSetBlocked(
		ctx context.Context,
		req *connect.Request[devkitv1.AuthSessionSetBlockedRequest],
	) (*devkitv1.AuthSessionSetBlockedResponse, error)
	AuthSessionDelete(
		ctx context.Context,
		req *connect.Request[devkitv1.AuthSessionDeleteRequest],
	) (*devkitv1.AuthSessionDeleteResponse, error)
	AuthSessionList(ctx context.Context, req *connect.Request[devkitv1.AuthSessionListRequest]) (*devkitv1.AuthSessionListResponse, error)
	AuthRegister(ctx context.Context, req *connect.Request[devkitv1.AuthRegisterRequest]) (*devkitv1.AuthRegisterResponse, error)
	UserDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.UserDeleteRestoreRequest]) (*devkitv1.UserDeleteRestoreResponse, error)
	UserList(ctx context.Context) (*devkitv1.UserListResponse, error)
	UserTypeListInput(ctx context.Context) (*devkitv1.UserTypeListInputResponse, error)
	UserListInput(ctx context.Context) (*devkitv1.UserListInputResponse, error)
	UserFindForUpdate(ctx context.Context, req *connect.Request[devkitv1.UserFindForUpdateRequest]) (*devkitv1.UserFindForUpdateResponse, error)
	UserCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.UserCreateUpdateRequest]) (*devkitv1.UserCreateUpdateResponse, error)
	AuthLoginProviderCallback(ctx context.Context, req *connect.Request[devkitv1.AuthLoginProviderCallbackRequest]) (*devkitv1.AuthLoginProviderCallbackResponse, error)
	AuthLoginProvider(ctx context.Context, req *connect.Request[devkitv1.AuthLoginProviderRequest]) (*devkitv1.AuthLoginProviderResponse, error)
	UserDelete(ctx context.Context, req *connect.Request[devkitv1.UserDeleteRequest]) (*devkitv1.UserDeleteResponse, error)
	AuthInvite(ctx context.Context, req *connect.Request[devkitv1.AuthInviteRequest]) (*devkitv1.AuthInviteResponse, error)
	RoleDelete(ctx context.Context, req *connect.Request[devkitv1.RoleDeleteRequest]) (*devkitv1.RoleDeleteResponse, error)
	RoleDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.RoleDeleteRestoreRequest]) (*devkitv1.RoleDeleteRestoreResponse, error)
	RoleFindForUpdate(ctx context.Context, req *connect.Request[devkitv1.RoleFindForUpdateRequest]) (*devkitv1.RoleFindForUpdateResponse, error)
	RoleListInput(ctx context.Context) (*devkitv1.RoleListInputResponse, error)
	RoleList(ctx context.Context, req *connect.Request[devkitv1.RoleListRequest]) (*devkitv1.RoleListResponse, error)
	UserGenerateTokens(username string, userId int32, tenantId int32, userSecurityLevel int32) (*devkitv1.LoginInfo, string, error)
	AuthLogout(
		ctx context.Context,
		req *connect.Request[devkitv1.AuthLogoutRequest],
	) (*devkitv1.AuthLogoutResponse, error)
	AppLogin(ctx context.Context, loginCode string, userId int32) (*devkitv1.AuthLoginResponse, error)
	AuthResetPassword(ctx context.Context, req *connect.Request[devkitv1.AuthResetPasswordRequest]) (*devkitv1.AuthResetPasswordResponse, error)
	AuthResetPasswordEmail(ctx context.Context, req *connect.Request[devkitv1.AuthResetPasswordEmailRequest]) (*devkitv1.AuthResetPasswordEmailResponse, error)
	AuthRefreshToken(ctx context.Context, req *connect.Request[devkitv1.AuthRefreshTokenRequest]) (*devkitv1.AuthRefreshTokenResponse, error)
	RoleCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.RoleCreateUpdateRequest]) (*devkitv1.RoleCreateUpdateResponse, error)
}

type AccountsUsecase struct {
	store                db.Store
	adapter              adapter.AccountsAdapterInterface
	tokenMaker           auth.Maker
	tokenDuration        time.Duration
	refreshTokenDuration time.Duration
	supaapi              supaapigo.Supaapi
	redisClient          redisclient.RedisClientInterface
	repo                 repo.AccountsRepoInterface
}

func NewAccountsUsecase(store db.Store, supaapi supaapigo.Supaapi, redisClient redisclient.RedisClientInterface, tokenMaker auth.Maker, tokenDuration time.Duration, refreshTokenDuration time.Duration) AccountsUsecaseInterface {
	return &AccountsUsecase{
		supaapi:              supaapi,
		tokenMaker:           tokenMaker,
		redisClient:          redisClient,
		tokenDuration:        tokenDuration,
		refreshTokenDuration: refreshTokenDuration,
		store:                store,
		adapter:              adapter.NewAccountsAdapter(),
		repo:                 repo.NewAccountsRepo(store),
	}
}
