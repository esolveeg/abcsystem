package usecase

import (
	"context"

	"github.com/darwishdev/devkit-api/app/public/adapter"
	"github.com/darwishdev/devkit-api/app/public/repo"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/redisclient"
	"github.com/darwishdev/devkit-api/pkg/resend"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	supaapigo "github.com/darwishdev/supaapi-go"
)

type PublicUsecaseInterface interface {
	TranslationList(ctx context.Context) (*devkitv1.TranslationListResponse, error)
	TranslationCreateUpdateBulk(ctx context.Context, req *devkitv1.TranslationCreateUpdateBulkRequest) (*devkitv1.TranslationCreateUpdateBulkResponse, error)
	TranslationFindLocale(ctx context.Context, req *devkitv1.TranslationFindLocaleRequest) (*devkitv1.TranslationFindLocaleResponse, error)
	TranslationDelete(ctx context.Context, req *devkitv1.TranslationDeleteRequest) (*devkitv1.TranslationDeleteResponse, error)
	GalleryList(ctx context.Context, req *devkitv1.GalleryListRequest) (*devkitv1.GalleryListResponse, error)
	FileDelete(ctx context.Context, req *devkitv1.FileDeleteRequest) (*devkitv1.FileDeleteResponse, error)
	FileList(ctx context.Context, req *devkitv1.FileListRequest) (*devkitv1.FileListResponse, error)
	EmailSend(ctx context.Context, req *devkitv1.EmailSendRequest) (*devkitv1.EmailSendResponse, error)
	BucketList(ctx context.Context, req *devkitv1.BucketListRequest) (*devkitv1.BucketListResponse, error)
	SettingUpdate(ctx context.Context, req *devkitv1.SettingUpdateRequest) error
	SettingFindForUpdate(ctx context.Context, req *devkitv1.SettingFindForUpdateRequest) (*devkitv1.SettingFindForUpdateResponse, error)
	FileCreate(ctx context.Context, req *devkitv1.FileCreateRequest) (*devkitv1.FileCreateResponse, error)
	BucketCreateUpdate(ctx context.Context, req *devkitv1.BucketCreateUpdateRequest) (*devkitv1.BucketCreateUpdateResponse, error)

	IconFind(ctx context.Context, req *devkitv1.IconFindRequest) (*devkitv1.IconFindResponse, error)
	IconCreateUpdateBulk(ctx context.Context, req *devkitv1.IconCreateUpdateBulkRequest) (*devkitv1.IconListResponse, error)
	IconList(ctx context.Context) (*devkitv1.IconListResponse, error)
	FileCreateBuilk(ctx context.Context, req *devkitv1.FileCreateBulkRequest) (*devkitv1.FileCreateBulkResponse, error)
}

type PublicUsecase struct {
	store        db.Store
	repo         repo.PublicRepoInterface
	adapter      adapter.PublicAdapterInterface
	supaapi      supaapigo.Supaapi
	resendClient resend.ResendServiceInterface
	redisClient  redisclient.RedisClientInterface
}

func NewPublicUsecase(store db.Store, supaapi supaapigo.Supaapi, redisClient redisclient.RedisClientInterface, resendClient resend.ResendServiceInterface) PublicUsecaseInterface {
	return &PublicUsecase{
		resendClient: resendClient,
		supaapi:      supaapi,
		redisClient:  redisClient,
		adapter:      adapter.NewPublicAdapter(),
		repo:         repo.NewPublicRepo(store),
		store:        store,
	}
}
