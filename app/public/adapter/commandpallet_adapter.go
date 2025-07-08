package adapter

import (
	"strings"

	"github.com/darwishdev/devkit-api/pkg/weaviateclient"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/google/uuid"
	"github.com/rs/zerolog/log"
)
var separatore string = "|"
func (a *PublicAdapter) CommandPalleteWeaviateFromGrpc(req *devkitv1.CommandPallete) *weaviateclient.CommandPallete {
	keywords := strings.Split(req.Keywords, separatore)

	id := uuid.NewSHA1(uuid.NameSpaceURL, []byte(req.MenuKey))
	log.Debug().Interface("id id", id).Msg("casd")
	return &weaviateclient.CommandPallete{
		Label   : req.Label,
		MenuKey: req.MenuKey,
		LabelAr : req.LabelAr ,
		Icon    : req.Icon,
		URL     : req.Route,
		TenantID: req.TenantId,
		Keywords: keywords,
	}

}
func (a *PublicAdapter) CommandPalleteGrpcFromWeaviate(doc *weaviateclient.CommandPallete) *devkitv1.CommandPallete {
    return &devkitv1.CommandPallete{
        MenuKey:   doc.MenuKey,
        Label:     doc.Label,
        LabelAr:   doc.LabelAr,
        Icon:      doc.Icon,
        Route:     doc.URL,
        TenantId:  doc.TenantID,
    }
}
