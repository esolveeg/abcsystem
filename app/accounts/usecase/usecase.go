package usecase

import (
	"context"

	"github.com/darwishdev/devkit-api/gen/db"
	apiv1 "github.com/darwishdev/devkit-api/gen/pb/proto/devkit/v1"
)

type AccountsUsecaseInterface interface {
	RoleCreate(ctx context.Context, req *apiv1.RoleCreateRequest) (*apiv1.RoleCreateResponse, error)
}

type AccountsUsecase struct {
	store db.Store
}

func NewAccountsUsecase(store db.Store) AccountsUsecaseInterface {
	return &AccountsUsecase{
		store: store,
	}
}
