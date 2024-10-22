package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

type PublicAdapterInterface interface {
	SettingsUpdateSqlFromGrpc(req *devkitv1.SettingsUpdateRequest) *db.SettingsUpdateParams
	SettingsEntityGrpcFromSql(resp []db.Setting) []*devkitv1.Setting
	SettingsFindForUpdateGrpcFromSql(resp *[]db.SettingsFindForUpdateRow) *devkitv1.SettingsFindForUpdateResponse
	IconsInputListGrpcFromSql(resp *[]db.Icon) *devkitv1.IconsInputListResponse
}

type PublicAdapter struct {
}

func NewPublicAdapter() PublicAdapterInterface {
	return &PublicAdapter{}
}
