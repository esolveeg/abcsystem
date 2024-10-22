package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *PublicAdapter) IconsInputListGrpcFromSql(resp *[]db.Icon) *devkitv1.IconsInputListResponse {
	// IconsInputListGrpcFromSql
	records := make([]*devkitv1.IconsInputListRow, 0)
	for _, v := range *resp {
		record := &devkitv1.IconsInputListRow{
			IconId:      v.IconID,
			IconName:    v.IconName,
			IconContent: v.IconContent,
		}
		records = append(records, record)
	}
	return &devkitv1.IconsInputListResponse{
		Icons: records,
	}
}
