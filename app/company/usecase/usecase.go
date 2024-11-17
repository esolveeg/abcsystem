package usecase

import (
	"context"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/app/company/adapter"
	"github.com/darwishdev/devkit-api/app/company/repo"
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

type CompanyUsecaseInterface interface {
	// INJECT INTERFACE
	CompanyDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.CompanyDeleteRestoreRequest]) (*devkitv1.CompanyDeleteRestoreResponse, error)
	CompanyList(ctx context.Context, req *connect.Request[devkitv1.CompanyListRequest]) (*devkitv1.CompanyListResponse, error)
	CompanyCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.CompanyCreateUpdateRequest]) (*devkitv1.CompanyCreateUpdateResponse, error)
}
type CompanyUsecase struct {
	store   db.Store
	adapter adapter.CompanyAdapterInterface
	repo    repo.CompanyRepoInterface
}

func NewCompanyUsecase(store db.Store) CompanyUsecaseInterface {
	return &CompanyUsecase{
		store:   store,
		adapter: adapter.NewCompanyAdapter(),
		repo:    repo.NewCompanyRepo(store),
	}
}
