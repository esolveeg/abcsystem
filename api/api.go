package api

import (
	"github.com/bufbuild/protovalidate-go"
	accountsUsecase "github.com/darwishdev/devkit-api/app/accounts/usecase"
	"github.com/darwishdev/devkit-api/config"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1/devkitv1connect"
)

type Api struct {
	devkitv1connect.UnimplementedDevkitServiceHandler
	accountsUscase accountsUsecase.AccountsUsecaseInterface
	config         config.Config
	validator      *protovalidate.Validator
	store          db.Store
}

func NewApi(config config.Config, store db.Store) (devkitv1connect.DevkitServiceHandler, error) {
	validator, err := protovalidate.New()

	if err != nil {
		return nil, err
	}

	accountsUsecase := accountsUsecase.NewAccountsUsecase(store)
	return &Api{
		accountsUscase: accountsUsecase,
		store:          store,
		config:         config,
		validator:      validator,
	}, nil
}
