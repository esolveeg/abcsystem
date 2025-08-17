package repo

import (
	"context"

	"github.com/esolveeg/abcsystem/erpapiclient"
)

type PrintingRepoInterface interface {
	PosInvoiceFind(ctx context.Context, req FindActiveReq) (string, error)
	// Printings
	// UpsertPrinting(p Printing) error
	// GetPrinting(printerID string) (*Printing, error)
	// ListPrintingsForDevice(deviceID string) ([]Printing, error)
	// GetDefaultPrintingForDevice(deviceID string) (*Printing, error)
	// SetDevicePrinting(deviceID, printerID string, defaultFlag bool) error
}

type PrintingRepo struct {
	errorHandler map[string]string
	ERP          *erpapiclient.Client
}

func NewPrintingRepo(ERP *erpapiclient.Client) PrintingRepoInterface {
	errorHandler := map[string]string{
		"role_role_name_key": "roleName",
	}
	return &PrintingRepo{
		errorHandler: errorHandler,
		ERP:          ERP,
	}
}
