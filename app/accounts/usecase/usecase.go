package usecase

import (
	"context"
	"time"

	"github.com/darwishdev/devkit-api/app/accounts/adapter"
	"github.com/darwishdev/devkit-api/app/accounts/repo"
	"github.com/darwishdev/devkit-api/auth"
	"github.com/darwishdev/devkit-api/db"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	supaapigo "github.com/darwishdev/supaapi-go"
)

type AccountsUsecaseInterface interface {
	UserLogin(ctx context.Context, req *apiv1.UserLoginRequest) (*apiv1.UserLoginResponse, error)
	UsersDeleteRestore(ctx context.Context, req *apiv1.DeleteRestoreRequest) error
	UsersList(ctx context.Context) (*apiv1.UsersListResponse, error)
	UserCreateUpdate(ctx context.Context, req *apiv1.UserCreateUpdateRequest) (*apiv1.UserCreateUpdateResponse, error)
	UserLoginProvider(ctx context.Context, req *apiv1.UserLoginProviderRequest) (*apiv1.UserLoginProviderResponse, error)
	UserInvite(ctx context.Context, req *apiv1.UserInviteRequest) (*apiv1.UserInviteResponse, error)
	RolesDeleteRestore(ctx context.Context, req *apiv1.DeleteRestoreRequest) error
	RolesList(ctx context.Context) (*apiv1.RolesListResponse, error)
	AppLogin(ctx context.Context, loginCode string) (*apiv1.UserLoginResponse, error)
	UserResetPassword(ctx context.Context, req *apiv1.UserResetPasswordRequest) (*apiv1.UserLoginResponse, error)
	UserResetPasswordEmail(ctx context.Context, req *apiv1.UserResetPasswordEmailRequest) (*apiv1.UserResetPasswordEmailResponse, error)
	RoleCreateUpdate(ctx context.Context, req *apiv1.RoleCreateUpdateRequest) (*apiv1.RoleCreateUpdateResponse, error)
}

type AccountsUsecase struct {
	store         db.Store
	adapter       adapter.AccountsAdapterInterface
	tokenMaker    auth.Maker
	tokenDuration time.Duration
	supaapi       supaapigo.Supaapi
	repo          repo.AccountsRepoInterface
}

func NewAccountsUsecase(store db.Store, supaapi supaapigo.Supaapi, tokenMaker auth.Maker, tokenDuration time.Duration) AccountsUsecaseInterface {
	return &AccountsUsecase{
		supaapi:       supaapi,
		tokenMaker:    tokenMaker,
		tokenDuration: tokenDuration,
		store:         store,
		adapter:       adapter.NewAccountsAdapter(),
		repo:          repo.NewAccountsRepo(store),
	}
}
