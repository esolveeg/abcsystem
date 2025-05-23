package api

import (
	"bytes"
	"context"
	"net/http"
	"strings"

	"connectrpc.com/connect"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func (api *Api) HandleHttpFileUpload(w http.ResponseWriter, r *http.Request) {
	err := r.ParseMultipartForm(100 << 20) // 100MB max memory+disk buffer
	if err != nil {
		http.Error(w, "Failed to parse multipart form: "+err.Error(), http.StatusBadRequest)
		return
	}
	bucketName := r.FormValue("bucket_name")
	if bucketName == "" {
		bucketName = api.config.DefaultBucket
	}

	// Support multiple files with unknown field name
	for _, files := range r.MultipartForm.File {
		for _, fileHeader := range files {
			file, err := fileHeader.Open()
			if err != nil {
				http.Error(w, "Failed to open uploaded file: "+err.Error(), http.StatusInternalServerError)
				return
			}
			defer file.Close()

			var buf bytes.Buffer
			if _, err := buf.ReadFrom(file); err != nil {
				http.Error(w, "Failed to read file: "+err.Error(), http.StatusInternalServerError)
				return
			}
			req := connect.NewRequest(&devkitv1.FileCreateRequest{
				Path:       fileHeader.Filename,
				BucketName: bucketName,
				Reader:     buf.Bytes(),
				FileType:   fileHeader.Header.Get("Content-Type"),
			})

			if auth := r.Header.Get("Authorization"); auth != "" {
				req.Header().Set("Authorization", auth)
			}

			_, err = api.FileCreate(r.Context(), req)
			if err != nil {
				http.Error(w, "FileCreate failed: "+err.Error(), http.StatusInternalServerError)
				return
			}
		}
	}

	// Return generic success response
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte(`{"status": "ok"}`))
}

func (api *Api) FileDelete(ctx context.Context, req *connect.Request[devkitv1.FileDeleteRequest]) (*connect.Response[devkitv1.FileDeleteResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	response, err := api.publicUsecase.FileDelete(ctx, req.Msg)
	return connect.NewResponse(response), err
}

func (api *Api) FileDeleteByBucket(ctx context.Context, req *connect.Request[devkitv1.FileDeleteByBucketRequest]) (*connect.Response[devkitv1.FileDeleteByBucketResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	response, err := api.publicUsecase.FileDeleteByBucket(ctx, req.Msg)
	return connect.NewResponse(response), err
}
func (api *Api) GalleryList(ctx context.Context, req *connect.Request[devkitv1.GalleryListRequest]) (*connect.Response[devkitv1.GalleryListResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	response, err := api.publicUsecase.GalleryList(ctx, req.Msg)
	return connect.NewResponse(response), err
}
func (api *Api) FileList(ctx context.Context, req *connect.Request[devkitv1.FileListRequest]) (*connect.Response[devkitv1.FileListResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	response, err := api.publicUsecase.FileList(ctx, req.Msg)
	return connect.NewResponse(response), err
}
func (api *Api) BucketCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.BucketCreateUpdateRequest]) (*connect.Response[devkitv1.BucketCreateUpdateResponse], error) {
	_, err := api.checkForAccess(req.Header(), "bucket", "create")
	if err != nil {
		return nil, err
	}
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	response, err := api.publicUsecase.BucketCreateUpdate(ctx, req.Msg)
	return connect.NewResponse(response), err
}

func (api *Api) BucketList(ctx context.Context, req *connect.Request[devkitv1.BucketListRequest]) (*connect.Response[devkitv1.BucketListResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	response, err := api.publicUsecase.BucketList(ctx, req.Msg)
	return connect.NewResponse(response), err
}

func (api *Api) FileCreate(ctx context.Context, req *connect.Request[devkitv1.FileCreateRequest]) (*connect.Response[devkitv1.FileCreateResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	resp, err := api.publicUsecase.FileCreate(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}

func (api *Api) FileCreateBulk(ctx context.Context, req *connect.Request[devkitv1.FileCreateBulkRequest]) (*connect.Response[devkitv1.FileCreateBulkResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	resp, err := api.publicUsecase.FileCreateBulk(ctx, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(resp), nil
}

func (api *Api) ImportTable(ctx context.Context, req *connect.Request[devkitv1.ImportTableRequest]) (*connect.Response[devkitv1.ImportTableResponse], error) {
	if err := ctx.Err(); err != nil {
		return nil, connect.NewError(connect.CodeInternal, err)
	}
	permissionName := strings.Replace(req.Msg.SchemaName, "_schema", "", 1)
	_, err := api.checkForAccess(req.Header(), permissionName, "create")
	if err != nil {
		_, err := api.checkForAccess(req.Header(), permissionName, "create_update")
		if err != nil {
			return nil, err
		}
	}
	buffer := bytes.NewBuffer(req.Msg.Reader)
	_, err = api.sqlSeeder.SeedFromExcel(*buffer, req.Msg.SchemaName, req.Msg.TableName, req.Msg.SchemaName)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&devkitv1.ImportTableResponse{
		Message: "imported",
	}), nil
}
