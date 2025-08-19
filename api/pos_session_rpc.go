package api

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	abcsystemv1 "github.com/esolveeg/abcsystem/proto_gen/abcsystem/v1"
)

func (api *Api) PosSessionItemsList(
	ctx context.Context,
	req *connect.Request[abcsystemv1.PosSessionItemsListRequest],
) (*connect.Response[abcsystemv1.PosSessionItemsListResponse], error) {
	rows, err := api.ERP.PosSessionItemsList(ctx, req.Msg.PosSession)
	if err != nil {
		return nil, fmt.Errorf("Error From ERP: %w", err)
	}
	res := &abcsystemv1.PosSessionItemsListResponse{Items: rows}
	return connect.NewResponse(res), nil
}
func (api *Api) PosSessionDashboardFind(
	ctx context.Context,
	req *connect.Request[abcsystemv1.PosSessionDashboardFindRequest],
) (*connect.Response[abcsystemv1.PosSessionDashboardFindResponse], error) {
	rows, err := api.ERP.PosSessionDashboardFind(ctx, req.Msg.PosSession)
	if err != nil {
		return nil, fmt.Errorf("Error From ERP: %w", err)
	}
	return connect.NewResponse(rows), nil
}
