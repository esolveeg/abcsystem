package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *PublicAdapter) SettingUpdateSqlFromGrpc(req *devkitv1.SettingUpdateRequest) *db.SettingUpdateParams {
	keys := make([]string, len(req.Settings))
	values := make([]string, len(req.Settings))
	for index, v := range req.Settings {
		keys[index] = v.SettingKey
		values[index] = v.SettingValue
	}
	return &db.SettingUpdateParams{
		Keys:   keys,
		Values: values,
	}
}
func (a *PublicAdapter) SettingEntityGrpcFromSql(resp []db.Setting) []*devkitv1.Setting {
	grpcResp := make([]*devkitv1.Setting, len(resp))
	for _, v := range resp {
		record := &devkitv1.Setting{
			SettingKey:   v.SettingKey,
			SettingValue: v.SettingValue,
		}
		grpcResp = append(grpcResp, record)
	}
	return grpcResp

}

func (a *PublicAdapter) SettingFindForUpdateGrpcFromSql(resp *[]db.SettingFindForUpdateRow) *devkitv1.SettingFindForUpdateResponse {
	grpcRows := make([]*devkitv1.SettingFindForUpdateRow, len(*resp))
	for index, v := range *resp {
		grpcRow := &devkitv1.SettingFindForUpdateRow{
			SettingKey:   v.SettingKey,
			SettingValue: v.SettingValue,
			InputType:    v.InputTypeName,
		}

		grpcRows[index] = grpcRow

	}

	return &devkitv1.SettingFindForUpdateResponse{
		Settings: grpcRows,
	}

}
