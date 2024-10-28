package usecase

import (
	"bytes"
	"context"
	"io"

	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	storage_go "github.com/supabase-community/storage-go"
	"google.golang.org/protobuf/types/known/emptypb"
)

func (s *PublicUsecase) UploadFile(ctx context.Context, req *devkitv1.UploadFileRequest) (*devkitv1.UploadFileResponse, error) {
	reader := io.NopCloser(bytes.NewReader(req.Reader))
	isUpsert := true
	fileOpts := storage_go.FileOptions{
		ContentType: &req.FileType,
		Upsert:      &isUpsert,
	}
	response, err := s.supaapi.StorageClient.UploadFile(req.BucketName, req.Path, reader, fileOpts)
	if err != nil {
		return nil, err
	}
	return &devkitv1.UploadFileResponse{
		Path: response.Key,
	}, nil

}
func (s *PublicUsecase) FilesList(ctx context.Context, req *devkitv1.FilesListRequest) (*devkitv1.FilesListResponse, error) {
	options := storage_go.FileSearchOptions{
		Limit:  int(req.Limit),
		Offset: int(req.Offest),
	}
	resp, err := s.supaapi.StorageClient.ListFiles(req.BucketId, req.QueryPath, options)
	if err != nil {
		return nil, err
	}

	response := s.adapter.FilesListGrpcFromSupa(resp)
	return response, nil
}

func (s *PublicUsecase) BucketsList(ctx context.Context, req *emptypb.Empty) (*devkitv1.BucketsListResponse, error) {
	resp, err := s.supaapi.StorageClient.ListBuckets()
	if err != nil {
		return nil, err
	}
	response := s.adapter.BucketsListGrpcFromSupa(resp)
	return response, nil
}

func (s *PublicUsecase) FilesDelete(ctx context.Context, req *devkitv1.FilesDeleteRequest) (*devkitv1.FilesDeleteResponse, error) {
	resp, err := s.supaapi.StorageClient.RemoveFile(req.BucketId, req.FilesPaths)
	if err != nil {
		return nil, err
	}
	response := s.adapter.FilesDeleteGrpcFromSupa(resp)
	return response, nil
}

func (s *PublicUsecase) UploadFiles(ctx context.Context, req *devkitv1.UploadFilesRequest) (*devkitv1.UploadFileResponse, error) {
	imagesPath := ""
	for _, file := range req.Files {
		response, err := s.UploadFile(ctx, file)
		if err != nil {
			return nil, err
		}
		imagesPath += response.Path + ","
	}
	return &devkitv1.UploadFileResponse{Path: imagesPath}, nil
}
