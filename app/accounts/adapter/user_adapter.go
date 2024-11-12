package adapter

import (
	"fmt"

	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/rs/zerolog/log"
	"golang.org/x/crypto/bcrypt"
)

func (a *AccountsAdapter) UserNavigationBarFindGrpcFromSql(resp *[]db.UserNavigationBarFindRow) ([]*devkitv1.NavigationBarItem, error) {
	response := make([]*devkitv1.NavigationBarItem, 0)
	responseMap := make(map[int32]*devkitv1.NavigationBarItem, 0)
	for _, row := range *resp {
		if row.Level == 1 {
			responseMap[row.NavigationBarItemID] = a.NavigationBarItemGrpcFromSql(&row)
		}

		if row.Level == 2 {
			parentNode, ok := responseMap[row.ParentID.Int32]
			if !ok {
				return nil, fmt.Errorf("parent id not found for %d", row.ParentID.Int32)
			}
			parentNode.Items = append(parentNode.Items, a.NavigationBarItemGrpcFromSql(&row))
		}
	}

	log.Debug().Interface("user", responseMap).Msg("navigation")
	return response, nil
}

func (a *AccountsAdapter) UserEntityGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.AccountsSchemaUser {
	return &devkitv1.AccountsSchemaUser{
		UserId:     int32(resp.UserID),
		UserName:   resp.UserName,
		UserTypeId: resp.UserTypeID,
		UserPhone:  resp.UserPhone.String,
		UserEmail:  resp.UserEmail, // User's email, unique in DB
		CreatedAt:  db.TimeToString(resp.CreatedAt.Time),
		DeletedAt:  db.TimeToString(resp.DeletedAt.Time),
	}
}

func (a *AccountsAdapter) UserCreateUpdateSqlFromGrpc(req *devkitv1.UserCreateUpdateRequest) *db.UserCreateUpdateParams {
	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(req.UserPassword), bcrypt.DefaultCost)
	resp := &db.UserCreateUpdateParams{
		UserID:       req.UserId,
		UserName:     req.UserName,
		UserTypeID:   req.UserTypeId,
		UserPhone:    req.UserPhone,
		UserEmail:    req.UserEmail,
		UserPassword: string(hashedPassword),
		Roles:        req.Roles,
	}
	return resp
}
func (a *AccountsAdapter) UserListGrpcFromSql(resp []db.AccountsSchemaUser) *devkitv1.UserListResponse {
	records := make([]*devkitv1.AccountsSchemaUser, 0)
	deletedRecords := make([]*devkitv1.AccountsSchemaUser, 0)
	for _, v := range resp {
		record := a.UserEntityGrpcFromSql(&v)
		if v.DeletedAt.Valid {
			deletedRecords = append(deletedRecords, record)
		} else {
			records = append(records, record)
		}
	}
	return &devkitv1.UserListResponse{
		DeletedRecords: deletedRecords,
		Records:        records,
	}
}
func (a *AccountsAdapter) UserCreateUpdateGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.UserCreateUpdateResponse {
	return &devkitv1.UserCreateUpdateResponse{
		User: a.UserEntityGrpcFromSql(resp),
	}
}
