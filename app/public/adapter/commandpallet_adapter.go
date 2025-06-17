package adapter

import (
	"github.com/darwishdev/devkit-api/pkg/weaviateclient"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *PublicAdapter) CommandPalleteWeaviateFromGrpc(req *devkitv1.CommandPallete) *weaviateclient.CommandPallete {
	return &weaviateclient.CommandPallete{
		ID      : req.MenuKey,
		Label   : req.Label,
		LabelAr : req.LabelAr ,
		Icon    : req.Icon,
		URL     : req.Route,
		TenantID: req.TenantId,
		Keywords: req.Keywords,
	}

}
func (a *PublicAdapter) CommandPalleteGrpcFromWeaviate(doc *weaviateclient.CommandPallete) *devkitv1.CommandPallete {
    return &devkitv1.CommandPallete{
        MenuKey:   doc.ID,
        Label:     doc.Label,
        LabelAr:   doc.LabelAr,
        Icon:      doc.Icon,
        Route:     doc.URL,
        TenantId:  doc.TenantID,
        Keywords:  doc.Keywords,
    }
}
