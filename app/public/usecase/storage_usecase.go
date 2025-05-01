package usecase

import (
	"bytes"
	"context"

	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	storage_go "github.com/darwishdev/storage-go"
)

func (s *PublicUsecase) FileCreate(ctx context.Context, req *devkitv1.FileCreateRequest) (*devkitv1.FileCreateResponse, error) {
	reader := bytes.NewReader(req.Reader)
	isUpsert := true
	fileOpts := storage_go.FileOptions{
		ContentType: &req.FileType,
		Upsert:      &isUpsert,
	}
	response, err := s.supaapi.StorageClient.UploadFile(req.BucketName, req.Path, reader, fileOpts)
	if err != nil {
		return nil, err
	}
	// s.supaapi.RestartStorageClient()
	return &devkitv1.FileCreateResponse{
		Path: response.Key,
	}, nil

}

func (s *PublicUsecase) GalleryList(ctx context.Context, req *devkitv1.GalleryListRequest) (*devkitv1.GalleryListResponse, error) {
	limit := 10
	offset := 0
	if req.PaginationParams != nil {
		limit = int(req.PaginationParams.PageSize)
		offset = int((req.PaginationParams.PageNumber - 1) * req.PaginationParams.PageSize)
	}
	options := storage_go.FileSearchOptions{
		Limit:  limit,
		Offset: offset,
	}
	resp, err := s.supaapi.StorageClient.ListFiles(req.Filters.BucketId, req.Filters.QueryPath, options)
	if err != nil {
		return nil, err
	}

	response := s.adapter.FileListGrpcFromSupa(resp, req.Filters.BucketId)

	return &devkitv1.GalleryListResponse{
		Records: response.Files,
		Options: &devkitv1.AvailableOptions{
			Title:       "gallery",
			Description: "gallery_description",
			CreateHandler: &devkitv1.CreateHandler{
				Endpoint: "bucketCreateUpdate",
			},
			UpdateHandler: &devkitv1.UpdateHandler{
				Endpoint:     "fileUpdate",
				FindEndpoint: "fileFind",
			},
			DeleteHandler: &devkitv1.DeleteHandler{
				Endpoint:        "fileDelete",
				RequestProperty: "records",
			},
		},
	}, nil
}
func (s *PublicUsecase) FileList(ctx context.Context, req *devkitv1.FileListRequest) (*devkitv1.FileListResponse, error) {
	options := storage_go.FileSearchOptions{
		Limit:  int(req.Limit),
		Offset: int(req.Offest),
	}
	resp, err := s.supaapi.StorageClient.ListFiles(req.BucketId, req.QueryPath, options)
	if err != nil {
		return nil, err
	}

	response := s.adapter.FileListGrpcFromSupa(resp, req.BucketId)
	return response, nil
}
func (s *PublicUsecase) BucketCreateUpdate(ctx context.Context, req *devkitv1.BucketCreateUpdateRequest) (*devkitv1.BucketCreateUpdateResponse, error) {
	request := storage_go.BucketOptions{
		Public:           req.IsPulic,
		FileSizeLimit:    req.FileSizeLimit,
		AllowedMimeTypes: req.AllowedFileTypes,
	}
	if req.IsUpdate {
		_, err := s.supaapi.StorageClient.UpdateBucket(req.BucketName, request)
		if err != nil {
			return nil, err
		}
		return &devkitv1.BucketCreateUpdateResponse{}, nil

	}
	resp, err := s.supaapi.StorageClient.CreateBucket(req.BucketName, request)
	if err != nil {
		return nil, err
	}
	bucket := s.adapter.StorageBucketGrpcFromSupa(&resp)
	return &devkitv1.BucketCreateUpdateResponse{
		Bucket: bucket,
	}, nil
}

func (s *PublicUsecase) BucketList(ctx context.Context, req *devkitv1.BucketListRequest) (*devkitv1.BucketListResponse, error) {
	resp, err := s.supaapi.StorageClient.ListBuckets()
	if err != nil {
		return nil, err
	}
	response := s.adapter.BucketListGrpcFromSupa(resp)
	return response, nil
}

func (s *PublicUsecase) FileDelete(ctx context.Context, req *devkitv1.FileDeleteRequest) (*devkitv1.FileDeleteResponse, error) {
	_, err := s.repo.FileDelete(ctx, req.Records)
	if err != nil {
		return nil, err
	}
	return &devkitv1.FileDeleteResponse{}, nil
}

func (s *PublicUsecase) FileDeleteByBucket(ctx context.Context, req *devkitv1.FileDeleteByBucketRequest) (*devkitv1.FileDeleteByBucketResponse, error) {
	_, err := s.repo.FileDeleteByBucket(ctx, req.Records, req.BucketName)
	if err != nil {
		return nil, err
	}
	return &devkitv1.FileDeleteByBucketResponse{}, nil
}
func (s *PublicUsecase) FileCreateBulk(ctx context.Context, req *devkitv1.FileCreateBulkRequest) (*devkitv1.FileCreateBulkResponse, error) {
	images := make([]string, len(req.Files))
	for index, file := range req.Files {
		response, err := s.FileCreate(ctx, file)
		if err != nil {
			return nil, err
		}
		images[index] = response.Path
	}
	return &devkitv1.FileCreateBulkResponse{Path: images}, nil
}
