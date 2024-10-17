package api

import (
	"github.com/bufbuild/protovalidate-go"
	accountsUsecase "github.com/darwishdev/devkit-api/app/accounts/usecase"
	"github.com/darwishdev/devkit-api/auth"
	"github.com/darwishdev/devkit-api/config"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1/devkitv1connect"
	supaapigo "github.com/darwishdev/supaapi-go"
)

type Api struct {
	devkitv1connect.UnimplementedDevkitServiceHandler
	accountsUscase accountsUsecase.AccountsUsecaseInterface
	config         config.Config
	validator      *protovalidate.Validator
	tokenMaker     auth.Maker
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

	accountsUsecase := accountsUsecase.NewAccountsUsecase(store, supaapi, tokenMaker, config.AccessTokenDuration)
	return &Api{
		accountsUscase: accountsUsecase,
		store:          store,
		tokenMaker:     tokenMaker,
		config:         config,
		validator:      validator,
	}, nil
}
