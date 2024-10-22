package usecase

import (
	"context"

	"github.com/darwishdev/devkit-api/app/public/adapter"
	"github.com/darwishdev/devkit-api/app/public/repo"
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/darwishdev/devkit-api/redisclient"
	supaapigo "github.com/darwishdev/supaapi-go"
)

type PublicUsecaseInterface interface {
	SettingsUpdate(ctx context.Context, req *devkitv1.SettingsUpdateRequest) error
	SettingsFindForUpdate(ctx context.Context, req *devkitv1.SettingsFindForUpdateRequest) (*devkitv1.SettingsFindForUpdateResponse, error)
	UploadFile(ctx context.Context, req *devkitv1.UploadFileRequest) (*devkitv1.UploadFileResponse, error)
	IconsInputList(ctx context.Context) (*devkitv1.IconsInputListResponse, error)
	UploadFiles(ctx context.Context, req *devkitv1.UploadFilesRequest) (*devkitv1.UploadFileResponse, error)
}

type PublicUsecase struct {
	store       db.Store
	repo        repo.PublicRepoInterface
	adapter     adapter.PublicAdapterInterface
	supaapi     supaapigo.Supaapi
	redisClient redisclient.RedisClientInterface
}

func NewPublicUsecase(store db.Store, supaapi supaapigo.Supaapi, redisClient redisclient.RedisClientInterface) PublicUsecaseInterface {
	return &PublicUsecase{
		supaapi:     supaapi,
		redisClient: redisClient,
		adapter:     adapter.NewPublicAdapter(),
		repo:        repo.NewPublicRepo(store),
		store:       store,
	}
}
