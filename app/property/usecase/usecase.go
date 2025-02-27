package usecase

import (
	"context"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/app/property/adapter"
	"github.com/darwishdev/devkit-api/app/property/repo"
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

type PropertyUsecaseInterface interface {
	// INJECT INTERFACE

	CityListInput(ctx context.Context, req *connect.Request[devkitv1.CityListInputRequest]) (*devkitv1.CityListInputResponse, error)

	LocationList(ctx context.Context, req *connect.Request[devkitv1.LocationListRequest]) (*devkitv1.LocationListResponse, error)
	LocationListInput(ctx context.Context, req *connect.Request[devkitv1.LocationListInputRequest]) (*devkitv1.LocationListInputResponse, error)
	CityList(ctx context.Context, req *connect.Request[devkitv1.CityListRequest]) (*devkitv1.CityListResponse, error)
}

type PropertyUsecase struct {
	store   db.Store
	adapter adapter.PropertyAdapterInterface
	repo    repo.PropertyRepoInterface
}

func NewPropertyUsecase(store db.Store) PropertyUsecaseInterface {
	return &PropertyUsecase{
		store:   store,
		adapter: adapter.NewPropertyAdapter(),
		repo:    repo.NewPropertyRepo(store),
	}
}
