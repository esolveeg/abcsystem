package usecase

import (
	"context"

	"github.com/darwishdev/devkit-api/app/accounts/adapter"
	"github.com/darwishdev/devkit-api/app/accounts/repo"
	"github.com/darwishdev/devkit-api/db"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/proto/devkit/v1"
)

type AccountsUsecaseInterface interface {
	RoleCreate(ctx context.Context, req *apiv1.RoleCreateRequest) (*apiv1.RoleCreateResponse, error)
}

type AccountsUsecase struct {
	store   db.Store
	adapter adapter.AccountsAdapterInterface
	repo    repo.AccountsRepoInterface
}

func NewAccountsUsecase(store db.Store) AccountsUsecaseInterface {
	return &AccountsUsecase{
		store:   store,
		adapter: adapter.NewAccountsAdapter(),
		repo:    repo.NewAccountsRepo(store),
	}
}
