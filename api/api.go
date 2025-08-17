package api

import (
	// USECASE_IMPORTS
	"github.com/bufbuild/protovalidate-go"
	printingUsecase "github.com/esolveeg/abcsystem/app/printing/usecase"
	"github.com/esolveeg/abcsystem/config"
	"github.com/esolveeg/abcsystem/erpapiclient"
	"github.com/esolveeg/abcsystem/pkg/printservice"
	"github.com/esolveeg/abcsystem/proto_gen/abcsystem/v1/abcsystemv1connect"
)

type Api struct {
	abcsystemv1connect.UnimplementedAbcsystemServiceHandler
	printingUsecase printingUsecase.PrintingUsecaseInterface
	ERP             *erpapiclient.Client
	printerService  printservice.NetworkPrinterInterface
	validator       *protovalidate.Validator
	config          config.Config
}

func NewApi(config config.Config, ERP *erpapiclient.Client, validator *protovalidate.Validator) (abcsystemv1connect.AbcsystemServiceHandler, error) {
	printService := printservice.NewNetworkPrinterService(config.BaseNetwork)
	printingUsecaseInstance := printingUsecase.NewPrintingUsecase(config, ERP, printService)
	return &Api{
		config:          config,
		ERP:             ERP,
		printingUsecase: printingUsecaseInstance,
		printerService:  printService,
		validator:       validator,
	}, nil
}
