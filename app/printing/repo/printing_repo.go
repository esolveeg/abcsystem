package repo

import (
	"context"
	"encoding/json"

	"github.com/esolveeg/abcsystem/erpapiclient"
)

// Ensure implementation satisfies the interface.
// Request shape your Python method accepts.
type FindActiveReq struct {
	RoomNo    string `json:"room_no,omitempty"`
	TableName string `json:"table_name,omitempty"`
	OrderID   string `json:"order_id,omitempty"`
}

// Response shapes (match your Python output).
type invoiceItem struct {
	Name     string  `json:"name"`
	ItemName string  `json:"item_name"`
	Qty      float64 `json:"qty"`
	Rate     float64 `json:"rate"`
	UOM      string  `json:"UOM"` // change to `json:"uom"` if field is lowercase in ERP
}

type invoiceLite struct {
	Name     string        `json:"name"`
	Customer string        `json:"customer"`
	Note     string        `json:"note"`
	Items    []invoiceItem `json:"items"`
}

// PosInvoiceFind calls the whitelisted ERPNext method and returns its JSON.
func (r *PrintingRepo) PosInvoiceFind(ctx context.Context, req FindActiveReq) (string, error) {
	res, err := erpapiclient.MethodCall[[]invoiceLite](ctx, r.ERP, "abcpos.api.find_active_pos_invoice", req)
	if err != nil {
		return "", err
	}

	b, err := json.Marshal(res)
	if err != nil {
		return "", err
	}
	return string(b), nil
}
