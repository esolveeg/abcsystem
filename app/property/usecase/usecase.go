package usecase

import (
	"context"
	"connectrpc.com/connect"
        "github.com/darwishdev/devkit-api/db"
        "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
        "github.com/darwishdev/devkit-api/app/property/repo"
        "github.com/darwishdev/devkit-api/app/property/adapter"
)

type PropertyUsecaseInterface interface {
     // INJECT INTERFACE
}

type PropertyUsecase struct {
	store       db.Store
	adapter     adapter.PropertyAdapterInterface
	repo        repo.PropertyRepoInterface
}

func NewPropertyUsecase(store db.Store) PropertyUsecaseInterface {
	return &PropertyUsecase{
		store:       store,
		adapter:     adapter.NewPropertyAdapter(),
		repo:        repo.NewPropertyRepo(store),
	}
}
