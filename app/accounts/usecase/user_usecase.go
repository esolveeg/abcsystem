package usecase

import (
	"context"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/db"
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/google/uuid"
	"github.com/supabase-community/auth-go/types"
)

func (u *AccountsUsecase) UserDelete(ctx context.Context, userID int32) (*devkitv1.AccountsSchemaUser, error) {
	params := db.UserDeleteParams{
		UserID: userID,
	}
	user, err := u.repo.UserDelete(ctx, params)
	if err != nil {
		return nil, err
	}
	err = u.redisClient.AuthSessionDelete(ctx, userID)
	if err != nil {
		return nil, err
	}

	resp := u.adapter.UserEntityGrpcFromSql(user)
	return resp, nil
}

func (u *AccountsUsecase) UserDeleteRestore(ctx context.Context, req *connect.Request[devkitv1.UserDeleteRestoreRequest]) (*devkitv1.UserDeleteRestoreResponse, error) {
	response := make([]*devkitv1.AccountsSchemaUser, 0)
	for _, rec := range req.Msg.Records {
		params := db.UserDeleteRestoreParams{
			UserID: rec,
		}
		resp, err := u.repo.UserDeleteRestore(ctx, params)
		if err != nil {
			return nil, err
		}
		response = append(response, u.adapter.UserEntityGrpcFromSql(resp))
	}
	return &devkitv1.UserDeleteRestoreResponse{
		Record: response,
	}, nil
}
func (u *AccountsUsecase) UserList(ctx context.Context) (*devkitv1.UserListResponse, error) {
	users, err := u.repo.UserList(ctx)
	if err != nil {
		return nil, err
	}
	response := u.adapter.UserListGrpcFromSql(users)
	return response, nil
}
func (u *AccountsUsecase) UserCreateUpdate(ctx context.Context, req *connect.Request[devkitv1.UserCreateUpdateRequest]) (*devkitv1.UserCreateUpdateResponse, error) {
	supabasRequest := types.AdminUpdateUserRequest{
		Email:    req.Msg.UserEmail,
		Password: req.Msg.UserPassword,
	}
	if req.Msg.UserId != 0 {
		userID, err := u.repo.AuthUserIDFindByEmail(ctx, req.Msg.UserEmail)
		if err != nil {
			return nil, err
		}
		uuid, err := uuid.Parse(*userID)
		if err != nil {
			return nil, err
		}
		supabasRequest.UserID = uuid
	}
	_, err := u.supaapi.UserCreateUpdate(supabasRequest)
	if err != nil {
		return nil, err
	}
	userCreateParams := u.adapter.UserCreateUpdateSqlFromGrpc(req.Msg)
	user, err := u.repo.UserCreateUpdate(ctx, *userCreateParams)
	if err != nil {
		return nil, err
	}

	resp := u.adapter.UserCreateUpdateGrpcFromSql(user)
	return resp, nil
}
