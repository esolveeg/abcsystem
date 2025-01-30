package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *PublicAdapter) IconFindSqlFromGrpc(icon *devkitv1.IconFindRequest) *db.IconFindParams {
	return &db.IconFindParams{
		IconID:   icon.IconId,
		IconName: icon.IconName,
	}

}
func (a *PublicAdapter) IconGrpcFromSql(icon *db.Icon) *devkitv1.Icon {
	return &devkitv1.Icon{
		IconId:      icon.IconID,
		IconName:    icon.IconName,
		IconContent: icon.IconContent,
	}

}

func (a *PublicAdapter) IconCreateUpdateBulkSqlFromGrpc(req *devkitv1.IconCreateUpdateBulkRequest) db.IconCreateUpdateBulkParams {
	names := make([]string, len(req.Icons))
	contents := make([]string, len(req.Icons))
	for index, v := range req.Icons {
		names[index] = v.IconName
		contents[index] = v.IconContent
	}
	return db.IconCreateUpdateBulkParams{
		IconsNames:    names,
		IconsContents: contents,
	}
}

func (a *PublicAdapter) IconListGrpcFromSql(resp []db.Icon) *devkitv1.IconListResponse {
	records := make([]*devkitv1.Icon, len(resp))
	for index, v := range resp {
		records[index] = a.IconGrpcFromSql(&v)
	}
	return &devkitv1.IconListResponse{
		Icons: records,
	}
}
