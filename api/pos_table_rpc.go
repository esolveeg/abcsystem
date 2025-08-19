package api

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	abcsystemv1 "github.com/esolveeg/abcsystem/proto_gen/abcsystem/v1"
)

func (api *Api) TableList(
	ctx context.Context,
	req *connect.Request[abcsystemv1.TableListRequest],
) (*connect.Response[abcsystemv1.TableListResponse], error) {
	rows, err := api.ERP.TableList(ctx, req.Msg.RestaurantId)
	if err != nil {
		return nil, fmt.Errorf("Error From ERP: %w", err)
	}
	return connect.NewResponse(&abcsystemv1.TableListResponse{Rows: rows}), nil
}
func (api *Api) TableOrders(
	ctx context.Context,
	req *connect.Request[abcsystemv1.TableOrdersRequest],
) (*connect.Response[abcsystemv1.TableOrdersResponse], error) {
	rows, err := api.ERP.TableOrders(ctx, req.Msg.RestaurantId)
	if err != nil {
		return nil, fmt.Errorf("Error From ERP: %w", err)
	}
	return connect.NewResponse(&abcsystemv1.TableOrdersResponse{Tables: rows}), nil
}
