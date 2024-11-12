package adapter

import (
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	storage_go "github.com/supabase-community/storage-go"
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

func (a *PublicAdapter) FileObjectGrpcFromSupa(resp *storage_go.FileObject) *devkitv1.FileObject {
	return &devkitv1.FileObject{
		Name:      resp.Name,
		UpdatedAt: resp.UpdatedAt,
		BucketId:  resp.BucketId,
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
func (a *PublicAdapter) FileListGrpcFromSupa(resp []storage_go.FileObject) *devkitv1.FileListResponse {
	files := make([]*devkitv1.FileObject, len(resp))
	for index, rec := range resp {
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
