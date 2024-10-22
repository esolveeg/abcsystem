package usecase

import (
	"bytes"
	"context"
	"io"

	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	storage_go "github.com/supabase-community/storage-go"
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
