package api

import (
	accountsUsecase "github.com/darwishdev/devkit-api/app/accounts/usecase"
	"github.com/darwishdev/devkit-api/config"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/proto_gen/proto/devkit/v1/devkitv1connect"
)

type Api struct {
	devkitv1connect.UnimplementedDevkitServiceHandler
	accountsUscase accountsUsecase.AccountsUsecaseInterface
	config         config.Config
	store          db.Store
}

func NewApi(config config.Config, store db.Store) devkitv1connect.DevkitServiceHandler {
	accountsUsecase := accountsUsecase.NewAccountsUsecase(store)
	return &Api{
		accountsUscase: accountsUsecase,
		store:          store,
		config:         config,
	}
}
