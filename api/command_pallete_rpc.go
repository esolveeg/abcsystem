package api

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) CommandPalleteSearch(ctx context.Context, req *connect.Request[devkitv1.CommandPalleteSearchRequest]) (*connect.Response[devkitv1.CommandPalleteSearchResponse], error) {
	resp ,  err := api.publicUsecase.CommandPalleteSearch(ctx, req)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve users list: %w", err)
	}
	return connect.NewResponse(resp), nil
}


func (api *Api) CommandPalleteSync(ctx context.Context, req *connect.Request[devkitv1.CommandPalleteSyncRequest]) (*connect.Response[devkitv1.CommandPalleteSyncResponse], error) {
	resp ,  err := api.publicUsecase.CommandPalleteSync(ctx, req)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve users list: %w", err)
	}
	return connect.NewResponse(resp), nil
}
