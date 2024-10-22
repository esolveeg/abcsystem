package usecase

import (
	"context"
	"time"

	"github.com/darwishdev/devkit-api/app/public/adapter"
	"github.com/darwishdev/devkit-api/app/public/repo"
	"github.com/darwishdev/devkit-api/auth"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/darwishdev/devkit-api/redisclient"
	supaapigo "github.com/darwishdev/supaapi-go"
)

type PublicUsecaseInterface interface {
	SettingsUpdate(ctx context.Context, req *devkitv1.SettingsUpdateRequest) error
	SettingsFindForUpdate(ctx context.Context, req *devkitv1.SettingsFindForUpdateRequest) (*devkitv1.SettingsFindForUpdateResponse, error)
	IconsInputList(ctx context.Context) (*devkitv1.IconsInputListResponse, error)
	UploadFile(ctx context.Context, req *devkitv1.UploadFileRequest) (*devkitv1.UploadFileResponse, error)
}

type PublicUsecase struct {
	store       db.Store
	adapter     adapter.PublicAdapterInterface
	supaapi     supaapigo.Supaapi
	redisClient redisclient.RedisClientInterface
	repo        repo.PublicRepoInterface
}

func NewPublicUsecase(store db.Store, supaapi supaapigo.Supaapi, redisClient redisclient.RedisClientInterface, tokenMaker auth.Maker, tokenDuration time.Duration) PublicUsecaseInterface {
	return &PublicUsecase{
		supaapi:     supaapi,
		redisClient: redisClient,
		store:       store,
		adapter:     adapter.NewPublicAdapter(),
		repo:        repo.NewPublicRepo(store),
	}
}
