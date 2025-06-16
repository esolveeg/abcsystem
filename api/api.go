package api

import (
	// USECASE_IMPORTS

	"context"

	propertyUsecase "github.com/darwishdev/devkit-api/app/property/usecase"

	"github.com/bufbuild/protovalidate-go"
	accountsUsecase "github.com/darwishdev/devkit-api/app/accounts/usecase"
	publicUsecase "github.com/darwishdev/devkit-api/app/public/usecase"
	tenantUsecase "github.com/darwishdev/devkit-api/app/tenant/usecase"
	"github.com/darwishdev/devkit-api/config"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/pkg/auth"
	"github.com/darwishdev/devkit-api/pkg/redisclient"
	"github.com/darwishdev/devkit-api/pkg/resend"
	typesenseclient "github.com/darwishdev/devkit-api/pkg/typesense"
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1/devkitv1connect"
	"github.com/darwishdev/sqlseeder"
	supaapigo "github.com/darwishdev/supaapi-go"
	"golang.org/x/crypto/bcrypt"
)

type Api struct {
	devkitv1connect.UnimplementedDevkitServiceHandler
	accountsUsecase accountsUsecase.AccountsUsecaseInterface
	config          config.Config
	validator       *protovalidate.Validator
	tokenMaker      auth.Maker
	sqlSeeder       sqlseeder.SeederInterface
	publicUsecase   publicUsecase.PublicUsecaseInterface
	typesenseClient typesenseclient.TypesenseClientInterface
	tenantUsecase   tenantUsecase.TenantUsecaseInterface
	// USECASE_FIELDS
	propertyUsecase propertyUsecase.PropertyUsecaseInterface

	supaapi     supaapigo.Supaapi
	redisClient redisclient.RedisClientInterface
	store       db.Store
}

func HashFunc(req string) string {
	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(req), bcrypt.DefaultCost)
	return string(hashedPassword)
}
func NewApi(config config.Config, store db.Store, tokenMaker auth.Maker, redisClient redisclient.RedisClientInterface, validator *protovalidate.Validator) (devkitv1connect.DevkitServiceHandler, error) {
	resendClient, err := resend.NewResendService(config.ResendApiKey, config.ClientBaseUrl)
	if err != nil {
		return nil, err
	}

	typesenseClient := typesenseclient.NewTypesenseClient(config.TypesenseHost, config.TypesensePort, config.TypesenseProtocol , config.TypesenseApiKey , false)

	err = typesenseClient.CreateCommandPaletteCollectionIfNotExists(context.Background())
	if err != nil {
		return nil , err
	}
	supEnv := supaapigo.DEV

	if config.State == "prod" {
		supEnv = supaapigo.PROD
	}
	supaapi := supaapigo.NewSupaapi(supaapigo.SupaapiConfig{
		ProjectRef:     config.DBProjectREF,
		Env:            supEnv,
		Port:           config.SupabaseAPIPort,
		ServiceRoleKey: config.SupabaseServiceRoleKey,
		ApiKey:         config.SupabaseApiKey,
	})
	sqlSeeder := sqlseeder.NewSeeder(sqlseeder.SeederConfig{HashFunc: HashFunc})
	// USECASE_INSTANTIATIONS
	propertyUsecase := propertyUsecase.NewPropertyUsecase(store)

	tenantUsecase := tenantUsecase.NewTenantUsecase(store, redisClient)
	accountsUsecase := accountsUsecase.NewAccountsUsecase(store, supaapi, redisClient, tokenMaker, config.AccessTokenDuration, config.RefreshTokenDuration)
	publicUsecase := publicUsecase.NewPublicUsecase(store, config.SupabaseApiKey, supaapi, redisClient, resendClient)
	return &Api{
		// USECASE_INJECTIONS
		propertyUsecase: propertyUsecase,

		typesenseClient: typesenseClient,
		accountsUsecase: accountsUsecase,
		tenantUsecase:   tenantUsecase,
		store:           store,
		redisClient:     redisClient,
		tokenMaker:      tokenMaker,
		supaapi:         supaapi,
		config:          config,
		sqlSeeder:       sqlSeeder,
		publicUsecase:   publicUsecase,
		validator:       validator,
	}, nil
}
