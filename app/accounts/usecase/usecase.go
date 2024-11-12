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
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	supaapigo "github.com/darwishdev/supaapi-go"
)

type AccountsUsecaseInterface interface {
	// CheckForAccess(ctx context.Context, header http.Header, functionName string, isCreateUpdate bool) (*devkitv1.AvailableOptions, error)
	AuthLogin(ctx context.Context, req *connect.Request[devkitv1.AuthLoginRequest]) (*devkitv1.AuthLoginResponse, error)
	AuthRegister(ctx context.Context, req *connect.Request[devkitv1.AuthRegisterRequest]) (*devkitv1.AuthRegisterResponse, error)
	UserDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.UserDeleteRestoreRequest]) (*devkitv1.UserDeleteRestoreResponse, error)
	UserList(ctx context.Context) (*devkitv1.UserListResponse, error)
	UserCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.UserCreateUpdateRequest]) (*devkitv1.UserCreateUpdateResponse, error)
	AuthLoginProvider(ctx context.Context, req *connect.Request[devkitv1.AuthLoginProviderRequest]) (*devkitv1.AuthLoginProviderResponse, error)
	UserDelete(ctx context.Context, userID int32) (*devkitv1.AccountsSchemaUser, error)
	AuthInvite(ctx context.Context, req *connect.Request[devkitv1.AuthInviteRequest]) (*devkitv1.AuthInviteResponse, error)
	RoleDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.RoleDeleteRestoreRequest]) (*devkitv1.RoleDeleteRestoreResponse, error)
	RoleList(ctx context.Context) (*devkitv1.RoleListResponse, error)
	AppLogin(ctx context.Context, loginCode string) (*devkitv1.AuthLoginResponse, redisclient.PermissionsMap, error)
	AuthResetPassword(ctx context.Context, req *connect.Request[devkitv1.AuthResetPasswordRequest]) (*devkitv1.AuthResetPasswordResponse, error)
	AuthResetPasswordEmail(ctx context.Context, req *connect.Request[devkitv1.AuthResetPasswordEmailRequest]) (*devkitv1.AuthResetPasswordEmailResponse, error)
	RoleCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.RoleCreateUpdateRequest]) (*devkitv1.RoleCreateUpdateResponse, error)
}

type AccountsUsecase struct {
	store         db.Store
	adapter       adapter.AccountsAdapterInterface
	tokenMaker    auth.Maker
	tokenDuration time.Duration
	supaapi       supaapigo.Supaapi
	redisClient   redisclient.RedisClientInterface
	repo          repo.AccountsRepoInterface
}

func NewAccountsUsecase(store db.Store, supaapi supaapigo.Supaapi, redisClient redisclient.RedisClientInterface, tokenMaker auth.Maker, tokenDuration time.Duration) AccountsUsecaseInterface {
	return &AccountsUsecase{
		supaapi:       supaapi,
		tokenMaker:    tokenMaker,
		redisClient:   redisClient,
		tokenDuration: tokenDuration,
		store:         store,
		adapter:       adapter.NewAccountsAdapter(),
		repo:          repo.NewAccountsRepo(store),
	}
}
