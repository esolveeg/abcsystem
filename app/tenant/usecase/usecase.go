package usecase

import (
	"context"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/app/tenant/adapter"
	"github.com/darwishdev/devkit-api/app/tenant/repo"
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

type TenantUsecaseInterface interface {
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

	TenantDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.TenantDeleteRestoreRequest]) (*devkitv1.TenantDeleteRestoreResponse, error)
	TenantList(ctx context.Context, req *connect.Request[devkitv1.TenantListRequest]) (*devkitv1.TenantListResponse, error)
	TenantCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.TenantCreateUpdateRequest]) (*devkitv1.TenantCreateUpdateResponse, error)
}
type TenantUsecase struct {
	store   db.Store
	adapter adapter.TenantAdapterInterface
	repo    repo.TenantRepoInterface
}

func NewTenantUsecase(store db.Store) TenantUsecaseInterface {
	return &TenantUsecase{
		store:   store,
		adapter: adapter.NewTenantAdapter(),
		repo:    repo.NewTenantRepo(store),
	}
}
