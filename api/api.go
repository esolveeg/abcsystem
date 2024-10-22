package api

import (
	"github.com/bufbuild/protovalidate-go"
	accountsUsecase "github.com/darwishdev/devkit-api/app/accounts/usecase"
	publicUsecase "github.com/darwishdev/devkit-api/app/public/usecase"
	"github.com/darwishdev/devkit-api/auth"
	"github.com/darwishdev/devkit-api/config"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1/devkitv1connect"
	"github.com/darwishdev/devkit-api/redisclient"
	supaapigo "github.com/darwishdev/supaapi-go"
)

type Api struct {
	devkitv1connect.UnimplementedDevkitServiceHandler
	accountsUscase accountsUsecase.AccountsUsecaseInterface
	config         config.Config
	validator      *protovalidate.Validator
	tokenMaker     auth.Maker
	publicUsecase  publicUsecase.PublicUsecaseInterface
	redisClient    redisclient.RedisClientInterface
	store          db.Store
}

func NewApi(config config.Config, store db.Store) (devkitv1connect.DevkitServiceHandler, error) {
	validator, err := protovalidate.New()
	if err != nil {
		return nil, err
	}

	supaapi := supaapigo.NewSupaapi(supaapigo.SupaapiConfig{
		ProjectRef:     config.DBProjectREF,
		Env:            supaapigo.DEV,
		Port:           54321,
		ServiceRoleKey: config.SupabaseServiceRoleKey,
		ApiKey:         config.SupabaseApiKey,
	})
	tokenMaker, err := auth.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		panic("cann't create paset maker in gapi/api.go")
	}
	redisClient := redisclient.NewRedisClient(config.RedisHost, config.RedisPort, config.RedisPassword, config.RedisDatabase)
	accountsUsecase := accountsUsecase.NewAccountsUsecase(store, supaapi, redisClient, tokenMaker, config.AccessTokenDuration)
	publicUsecase := publicUsecase.NewPublicUsecase(store, supaapi, redisClient)
	return &Api{
		accountsUscase: accountsUsecase,
		store:          store,
		redisClient:    redisClient,
		tokenMaker:     tokenMaker,
		config:         config,
		publicUsecase:  publicUsecase,
		validator:      validator,
	}, nil
}
