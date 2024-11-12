package api

import (
// "context"
// "fmt"
// "os"
// "testing"
//
// "connectrpc.com/connect"
// "github.com/darwishdev/devkit-api/pkg/random"
// devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

// var testBucket string = random.RandomName()

//
// func TestBucketCreateUpdate(t *testing.T) {
// 	request := connect.NewRequest(&devkitv1.BucketCreateUpdateRequest{
// 		BucketName: testBucket,
// 	})
// 	resp, err := testClient.BucketCreateUpdate(context.Background(), request)
// 	if err != nil {
// 		panic(err)
// 	}
// 	fmt.Println(resp)
// }
// func TestUploadFile(t *testing.T) {
// 	imagePath := "/home/darwishdev/code/darwishdev/devkit-api/logo.png"
// 	img, err := os.ReadFile(imagePath)
// 	if err != nil {
// 		panic(err)
// 	}
// 	request := connect.NewRequest(&devkitv1.FileCreateRequest{
// 		Path:       "initial/img.png",
// 		BucketName: testBucket,
// 		FileType:   "image/png",
// 		Reader:     img,
// 	})
//
// 	resp, err := testClient.FileCreate(context.Background(), request)
// 	if err != nil {
// 		panic(err)
// 	}
// 	fmt.Println(resp)
// }
// func TestUploadFiles(t *testing.T) {
// 	imagePath := "/home/darwishdev/code/darwishdev/devkit-api/logo.png"
// 	img, err := os.ReadFile(imagePath)
// 	if err != nil {
// 		panic(err)
// 	}
// 	image2Path := "/home/darwishdev/code/darwishdev/devkit-api/logo2.png"
// 	img2, err := os.ReadFile(image2Path)
// 	if err != nil {
// 		panic(err)
// 	}
// 	request := connect.NewRequest(&devkitv1.FileCreateBulkRequest{
// 		Files: []*devkitv1.FileCreateRequest{{
// 			Path:       "initial/img2.png",
// 			BucketName: testBucket,
// 			FileType:   "image/png",
// 			Reader:     img,
// 		},
// 			{
// 				Path:       "initial/img3.png",
// 				BucketName: "images",
// 				FileType:   "image/png",
// 				Reader:     img2,
// 			}}})
// 	resp, err := testClient.FileCreateBulk(context.Background(), request)
// 	if err != nil {
// 		panic(err)
// 	}
// 	fmt.Println(resp)
// }
