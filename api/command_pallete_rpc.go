package api

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) CommandPalleteSearch(ctx context.Context, req *connect.Request[devkitv1.CommandPalleteSearchRequest]) (*connect.Response[devkitv1.CommandPalleteSearchResponse], error) {
	response, err := api.typesenseClient.SearchCommandPalette(ctx, req.Msg.Query , 10)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve users list: %w", err)
	}
var results []*devkitv1.CommandPallet
	for _, doc := range response {
		results = append(results, &devkitv1.CommandPallet{
			Id:       doc.ID,
			Label:    doc.Label,
			LabelAr:  doc.LabelAr,
			Icon:     doc.Icon,
			Type:     doc.Type,
			Url:      doc.URL,
			TenantId: doc.TenantID,
			Keywords: doc.Keywords,
		})
	}

	res := &devkitv1.CommandPalleteSearchResponse{
		Hits: results,
	}
	return connect.NewResponse(res), nil
}
