package usecase

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	"github.com/esolveeg/abcsystem/app/printing/repo"
	abcsystemv1 "github.com/esolveeg/abcsystem/proto_gen/abcsystem/v1"
	"github.com/rs/zerolog/log"
)

func (u *PrintingUsecase) PrintKitchenOrder(ctx context.Context, req *connect.Request[abcsystemv1.PrintKitchenOrderRequest]) (*abcsystemv1.PrintKitchenOrderResponse, error) {
	params := repo.FindActiveReq{OrderID: req.Msg.OrderId}
	activeOrder, err := u.repo.PosInvoiceFind(ctx, params)
	if err != nil {
		return nil, fmt.Errorf("error from erpnext : %w", err)
	}
	log.Debug().Interface("active order is", activeOrder).Msg("show active order")
	response := &abcsystemv1.PrintKitchenOrderResponse{Message: "Printed"}
	return response, nil
}
