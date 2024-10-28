package api

import (
	// USECASE_IMPORTS
	"github.com/bufbuild/protovalidate-go"
	accountsUsecase "github.com/darwishdev/devkit-api/app/accounts/usecase"
	publicUsecase "github.com/darwishdev/devkit-api/app/public/usecase"
	"github.com/darwishdev/devkit-api/config"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/auth"
	"github.com/darwishdev/devkit-api/pkg/redisclient"
	"github.com/darwishdev/devkit-api/pkg/resend"
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1/devkitv1connect"
	"github.com/darwishdev/sqlseeder"
	supaapigo "github.com/darwishdev/supaapi-go"
	"golang.org/x/crypto/bcrypt"
)

type Api struct {
	devkitv1connect.UnimplementedDevkitServiceHandler
	accountsUscase accountsUsecase.AccountsUsecaseInterface
	config         config.Config
	validator      *protovalidate.Validator
	tokenMaker     auth.Maker
	sqlSeeder      sqlseeder.SeederInterface
	publicUsecase  publicUsecase.PublicUsecaseInterface
	// USECASE_FIELDS
	supaapi     supaapigo.Supaapi
	redisClient redisclient.RedisClientInterface
	store       db.Store
}

func HashFunc(req string) string {
	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(req), bcrypt.DefaultCost)
	return string(hashedPassword)
}
func NewApi(config config.Config, store db.Store) (devkitv1connect.DevkitServiceHandler, error) {
	validator, err := protovalidate.New()
	if err != nil {
		return nil, err
	}
	resendClient, err := resend.NewResendService(config.ResendApiKey, config.ClientBaseUrl)

	supaapi := supaapigo.NewSupaapi(supaapigo.SupaapiConfig{
		ProjectRef:     config.DBProjectREF,
		Env:            supaapigo.DEV,
		Port:           config.DBPort,
		ServiceRoleKey: config.SupabaseServiceRoleKey,
		ApiKey:         config.SupabaseApiKey,
	})
	tokenMaker, err := auth.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		panic("cann't create paset maker in gapi/api.go")
	}
	sqlSeeder := sqlseeder.NewSeeder(sqlseeder.SeederConfig{HashFunc: HashFunc})
	redisClient := redisclient.NewRedisClient(config.RedisHost, config.RedisPort, config.RedisPassword, config.RedisDatabase)
	// USECASE_INSTANTIATIONS
	accountsUsecase := accountsUsecase.NewAccountsUsecase(store, supaapi, redisClient, tokenMaker, config.AccessTokenDuration)
	publicUsecase := publicUsecase.NewPublicUsecase(store, supaapi, redisClient, resendClient)
	return &Api{
		// USECASE_INJECTIONS
		accountsUscase: accountsUsecase,
		store:          store,
		redisClient:    redisClient,
		tokenMaker:     tokenMaker,
		supaapi:        supaapi,
		config:         config,
		sqlSeeder:      sqlSeeder,
		publicUsecase:  publicUsecase,
		validator:      validator,
	}, nil
}
