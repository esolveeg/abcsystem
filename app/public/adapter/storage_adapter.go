package adapter

import (
	"fmt"

	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	storage_go "github.com/darwishdev/storage-go"
	"github.com/rs/zerolog/log"
)

func (a *PublicAdapter) StorageBucketGrpcFromSupa(resp *storage_go.Bucket) *devkitv1.StorageBucket {
	return &devkitv1.StorageBucket{
		Name:      resp.Name,
		CreatedAt: resp.CreatedAt,
		Id:        resp.Id,
		Public:    resp.Public,
	}
}

func (a *PublicAdapter) FileCreateResponseGrpcFromSupa(resp *storage_go.FileUploadResponse) *devkitv1.FileCreateResponse {
	return &devkitv1.FileCreateResponse{
		Path: resp.Key,
	}
}

func convertMetadata(meta interface{}) *devkitv1.FileMetadata {
	if meta == nil {
		return nil
	}

	metaMap, ok := meta.(map[string]interface{})
	if !ok {
		return nil
	}

	return &devkitv1.FileMetadata{
		ETag:           db.StringFindFromMap(metaMap, "eTag"),
		Mimetype:       db.StringFindFromMap(metaMap, "mimetype"),
		CacheControl:   db.StringFindFromMap(metaMap, "cacheControl"),
		LastModified:   db.TimestampFindFromMap(metaMap, "lastModified"),
		HttpStatusCode: db.Int32FindFromMap(metaMap, "httpStatusCode"),
		Size:           db.Int32FindFromMap(metaMap, "size"),
		ContentLength:  db.Int32FindFromMap(metaMap, "contentLength"),
	}
}
func (a *PublicAdapter) FileObjectGrpcFromSupa(resp *storage_go.FileObject) *devkitv1.FileObject {
	log.Debug().Interface("buck is", resp.BucketId).Msg("bucucucuuc")
	return &devkitv1.FileObject{
		Name:      fmt.Sprintf("%s/%s", resp.BucketId, resp.Name),
		UpdatedAt: resp.UpdatedAt,
		BucketId:  resp.BucketId,
		// Metadata:  convertMetadata(resp.Metadata),
		CreatedAt: resp.CreatedAt,
		Id:        resp.Id,
	}
}

func (a *PublicAdapter) FileDeleteGrpcFromSupa(resp []storage_go.FileUploadResponse) *devkitv1.FileDeleteResponse {
	response := make([]*devkitv1.FileCreateResponse, len(resp))
	for index, rec := range resp {
		response[index] = a.FileCreateResponseGrpcFromSupa(&rec)
	}
	return &devkitv1.FileDeleteResponse{
		Responses: response,
	}
}
func (a *PublicAdapter) FileListGrpcFromSupa(resp []storage_go.FileObject, bucketId string) *devkitv1.FileListResponse {
	files := make([]*devkitv1.FileObject, len(resp))
	for index, rec := range resp {
		rec.BucketId = bucketId
		files[index] = a.FileObjectGrpcFromSupa(&rec)
	}
	return &devkitv1.FileListResponse{Files: files}
}
func (a *PublicAdapter) BucketListGrpcFromSupa(resp []storage_go.Bucket) *devkitv1.BucketListResponse {
	buckets := make([]*devkitv1.StorageBucket, len(resp))
	for index, rec := range resp {
		buckets[index] = a.StorageBucketGrpcFromSupa(&rec)
	}
	return &devkitv1.BucketListResponse{Buckets: buckets}
}
