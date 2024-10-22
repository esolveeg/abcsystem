package api

import (
	"context"
	"fmt"
	"os"
	"testing"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func TestUploadFile(t *testing.T) {
	imagePath := "/home/darwishdev/code/darwishdev/devkit-api/logo.png"
	img, err := os.ReadFile(imagePath)
	if err != nil {
		panic(err)
	}
	request := connect.NewRequest(&devkitv1.UploadFileRequest{
		Path:       "initial/img.png",
		BucketName: "images",
		FileType:   "image/png",
		Reader:     img,
	})

	resp, err := realDbApi.UploadFile(context.Background(), request)
	if err != nil {
		panic(err)
	}
	fmt.Println(resp)
}
func TestUploadFiles(t *testing.T) {
	imagePath := "/home/darwishdev/code/darwishdev/devkit-api/logo.png"
	img, err := os.ReadFile(imagePath)
	if err != nil {
		panic(err)
	}
	image2Path := "/home/darwishdev/code/darwishdev/devkit-api/logo2.png"
	img2, err := os.ReadFile(image2Path)
	if err != nil {
		panic(err)
	}
	request := connect.NewRequest(&devkitv1.UploadFilesRequest{
		Files: []*devkitv1.UploadFileRequest{{
			Path:       "initial/img2.png",
			BucketName: "images",
			FileType:   "image/png",
			Reader:     img,
		},
			{
				Path:       "initial/img3.png",
				BucketName: "images",
				FileType:   "image/png",
				Reader:     img2,
			}}})
	resp, err := realDbApi.UploadFiles(context.Background(), request)
	if err != nil {
		panic(err)
	}
	fmt.Println(resp)
}
