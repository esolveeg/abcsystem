package adapter

import (
	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (a *PublicAdapter) TranslationCreateUpdateBulkSqlFromGrpc(req *devkitv1.TranslationCreateUpdateBulkRequest) *db.TranslationCreateUpdateBulkParams {
	keys := make([]string, len(req.Records))
	enValues := make([]string, len(req.Records))
	arValues := make([]string, len(req.Records))
	for index, v := range req.Records {
		keys[index] = v.TranslationKey
		enValues[index] = v.EnglishValue
		arValues[index] = v.ArabicValue
	}
	return &db.TranslationCreateUpdateBulkParams{
		Keys:          keys,
		ArabicValues:  arValues,
		EnglishValues: enValues,
	}
}

func (a *PublicAdapter) TranslationCreateUpdateBulkRowGrpcFromSql(resp *db.TranslationCreateUpdateBulkRow) *devkitv1.Translation {
	return &devkitv1.Translation{
		TranslationKey: resp.TranslationKey,
		EnglishValue:   resp.EnglishValue,
		ArabicValue:    resp.ArabicValue,
	}
}

func (a *PublicAdapter) TranslationGrpcFromSql(resp *db.Translation) *devkitv1.Translation {
	return &devkitv1.Translation{
		TranslationKey: resp.TranslationKey,
		EnglishValue:   resp.EnglishValue,
		ArabicValue:    resp.ArabicValue,
	}
}

func (a *PublicAdapter) TranslationCreateUpdateBulkGrpcFromSql(resp []db.TranslationCreateUpdateBulkRow) devkitv1.TranslationListResponse {
	translations := make([]*devkitv1.Translation, len(resp))
	for index, t := range resp {
		translations[index] = a.TranslationCreateUpdateBulkRowGrpcFromSql(&t)
	}
	return devkitv1.TranslationListResponse{
		Translations: translations,
	}
}
func (a *PublicAdapter) TranslationListGrpcFromSql(resp []db.Translation) devkitv1.TranslationListResponse {
	translations := make([]*devkitv1.Translation, len(resp))
	for index, t := range resp {
		translations[index] = a.TranslationGrpcFromSql(&t)
	}
	return devkitv1.TranslationListResponse{
		Translations: translations,
	}
}
