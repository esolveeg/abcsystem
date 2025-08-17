package usecase

import (
	"context"

	"connectrpc.com/connect"
	"github.com/esolveeg/abcsystem/app/printing/adapter"
	"github.com/esolveeg/abcsystem/app/printing/repo"
	"github.com/esolveeg/abcsystem/config"
	"github.com/esolveeg/abcsystem/erpapiclient"
	"github.com/esolveeg/abcsystem/pkg/printservice"
	abcsystemv1 "github.com/esolveeg/abcsystem/proto_gen/abcsystem/v1"
)

type PrintingUsecaseInterface interface {
	PrintKitchenOrder(ctx context.Context, req *connect.Request[abcsystemv1.PrintKitchenOrderRequest]) (*abcsystemv1.PrintKitchenOrderResponse, error)
}

type PrintingUsecase struct {
	config         config.Config
	ERP            *erpapiclient.Client
	printerService printservice.NetworkPrinterInterface
	adapter        adapter.PrinterAdapterInterface
	repo           repo.PrintingRepoInterface
}

func NewPrintingUsecase(config config.Config, ERP *erpapiclient.Client, printerService printservice.NetworkPrinterInterface) PrintingUsecaseInterface {
	return &PrintingUsecase{
		ERP:     ERP,
		adapter: adapter.NewPrintingAdapter(),
		repo:    repo.NewPrintingRepo(ERP),
		config:  config,
	}
}
