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
	PartialDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.PartialDeleteRestoreRequest]) (*devkitv1.PartialDeleteRestoreResponse, error)
	PartialCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.PartialCreateUpdateRequest]) (*devkitv1.PartialCreateUpdateResponse, error)
	PartialList(ctx context.Context, req *connect.Request[devkitv1.PartialListRequest]) (*devkitv1.PartialListResponse, error)
	// INJECT INTERFACE
	SectionDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.SectionDeleteRestoreRequest]) (*devkitv1.SectionDeleteRestoreResponse, error)
	SectionCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.SectionCreateUpdateRequest]) (*devkitv1.SectionCreateUpdateResponse, error)
	SectionList(ctx context.Context, req *connect.Request[devkitv1.SectionListRequest]) (*devkitv1.SectionListResponse, error)

	PageDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.PageDeleteRestoreRequest]) (*devkitv1.PageDeleteRestoreResponse, error)

	PageCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.PageCreateUpdateRequest]) (*devkitv1.PageCreateUpdateResponse, error)

	PageList(ctx context.Context, req *connect.Request[devkitv1.PageListRequest]) (*devkitv1.PageListResponse, error)

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
