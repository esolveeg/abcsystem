package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/resend/resend-go/v2"
	storage_go "github.com/supabase-community/storage-go"
)

type PublicAdapterInterface interface {
	IconFindSqlFromGrpc(icon *devkitv1.IconFindRequest) *db.IconFindParams
	IconGrpcFromSql(icon *db.Icon) *devkitv1.Icon
	IconCreateUpdateBulkSqlFromGrpc(req *devkitv1.IconCreateUpdateBulkRequest) db.IconCreateUpdateBulkParams
	EmailSendResendFromGrpc(req *devkitv1.EmailSendRequest) resend.SendEmailRequest
	TranslationCreateUpdateBulkGrpcFromSql(resp []db.TranslationCreateUpdateBulkRow) devkitv1.TranslationListResponse
	TranslationListGrpcFromSql(resp []db.Translation) devkitv1.TranslationListResponse
	TranslationFindLocaleGrpcFromSql(resp []db.Translation, locale string) devkitv1.TranslationFindLocaleResponse
	TranslationGrpcFromSql(resp *db.Translation) *devkitv1.Translation
	TranslationCreateUpdateBulkSqlFromGrpc(req *devkitv1.TranslationCreateUpdateBulkRequest) *db.TranslationCreateUpdateBulkParams
	FileDeleteGrpcFromSupa(resp []storage_go.FileUploadResponse) *devkitv1.FileDeleteResponse
	FileListGrpcFromSupa(resp []storage_go.FileObject) *devkitv1.FileListResponse
	FileObjectGrpcFromSupa(resp *storage_go.FileObject) *devkitv1.FileObject
	FileCreateResponseGrpcFromSupa(resp *storage_go.FileUploadResponse) *devkitv1.FileCreateResponse
	BucketListGrpcFromSupa(resp []storage_go.Bucket) *devkitv1.BucketListResponse
	StorageBucketGrpcFromSupa(resp *storage_go.Bucket) *devkitv1.StorageBucket
	SettingUpdateSqlFromGrpc(req *devkitv1.SettingUpdateRequest) *db.SettingUpdateParams
	SettingEntityGrpcFromSql(resp []db.Setting) []*devkitv1.Setting
	SettingFindForUpdateGrpcFromSql(resp *[]db.SettingFindForUpdateRow) *devkitv1.SettingFindForUpdateResponse
	IconListGrpcFromSql(resp []db.Icon) *devkitv1.IconListResponse
}

type PublicAdapter struct {
}

func NewPublicAdapter() PublicAdapterInterface {
	return &PublicAdapter{}
}
