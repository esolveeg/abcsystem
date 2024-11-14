package api

import (
	"context"
	"fmt"
	"os"
	"testing"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/pkg/random"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

var (
	testBucket  string = random.RandomName()
	firstImage  string = "seeds/assets/images/logo.webp"
	secondImage string = "seeds/assets/images/logo2.webp"
)

func TestBucketCreateUpdate(t *testing.T) {
	request := connect.NewRequest(&devkitv1.BucketCreateUpdateRequest{
		BucketName: testBucket,
	})
	resp, err := testClient.BucketCreateUpdate(context.Background(), request)
	if err != nil {
		panic(err)
	}
	fmt.Println(resp)
}
func TestUploadFile(t *testing.T) {
	img, err := os.ReadFile(firstImage)
	if err != nil {
		panic(err)
	}
	request := connect.NewRequest(&devkitv1.FileCreateRequest{
		Path:       "initial/img.webp",
		BucketName: testBucket,
		FileType:   "image/webp",
		Reader:     img,
	})

	resp, err := testClient.FileCreate(context.Background(), request)
	if err != nil {
		panic(err)
	}
	fmt.Println(resp)
}
func TestUploadFiles(t *testing.T) {
	img, err := os.ReadFile(firstImage)
	if err != nil {
		panic(err)
	}
	img2, err := os.ReadFile(secondImage)
	if err != nil {
		panic(err)
	}
	request := connect.NewRequest(&devkitv1.FileCreateBulkRequest{
		Files: []*devkitv1.FileCreateRequest{{
			Path:       "initial/img2.webp",
			BucketName: testBucket,
			FileType:   "image/webp",
			Reader:     img,
		},
			{
				Path:       "initial/img3.webp",
				BucketName: "images",
				FileType:   "image/webp",
				Reader:     img2,
			}}})
	resp, err := testClient.FileCreateBulk(context.Background(), request)
	if err != nil {
		panic(err)
	}
	fmt.Println(resp)
}
