package adapter

import (
	"encoding/json"
	"fmt"
	"strings"

	"github.com/darwishdev/devkit-api/db"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/iancoleman/strcase"
	"github.com/supabase-community/auth-go/types"
	"golang.org/x/crypto/bcrypt"
)

type NavigationsMap map[int32]*devkitv1.NavigationBarItem

// The UserNavigationBarFindGrpcFromSql function builds a hierarchical structure of navigation bar items from a sorted database response (dbResponse).
// This hierarchy supports any number of levels, as long as the input list is sorted in ascending order by level.
// The function uses navigationBarItemId as a primary key and parentId as a foreign key to link items with their parents.
// The function logic breakdown is listed as comments inside the function body.
func (a *AccountsAdapter) UserNavigationBarFindGrpcFromSql(dbResponse []db.UserNavigationBarFindRow) ([]*devkitv1.NavigationBarItem, error) {
	// 1. Get the maximum level in the tree by accessing the last element in the array, since the response is sorted by level.
	maxLevel := dbResponse[len(dbResponse)-1].Level

	// 2. Declare rootItems, which will store the top-level items and serve as the function's return value.
	rootItems := make([]*devkitv1.NavigationBarItem, 0)

	// 3. Initialize levelItemsMap with empty maps. This will store each level's items separately in its own hashmap.
	//    We populate levelItemsMap in reverse order so that the highest level appears first.
	//    For example, if maxLevel is 3, levelItemsMap will look like:
	//    [
	//      {map with all items of level 3},
	//      {map with all items of level 2},
	//      {map with all items of level 1},
	//    ]
	levelItemsMap := make([]NavigationsMap, maxLevel)
	for i := range levelItemsMap {
		levelItemsMap[i] = NavigationsMap{}
	}

	// 4. Populate levelItemsMap from dbResponse.
	for _, dbItem := range dbResponse {
		primaryKeyValue := dbItem.NavigationBarItemID
		grpcItem := a.NavigationBarItemGrpcFromSql(&dbItem)

		// Calculate levelIndex to store items in reverse order in levelItemsMap.
		// If dbItem.Level equals maxLevel, it will go to the first index in levelItemsMap,
		// and if dbItem.Level equals 1, it will go to the last index.
		levelIndex := maxLevel - dbItem.Level
		levelItemsMap[levelIndex][primaryKeyValue] = grpcItem
	}

	// 5. Construct the response by linking items from levelItemsMap.
	for levelIndex, grpcItemsMap := range levelItemsMap {
		for _, grpcItem := range grpcItemsMap {
			// If we're at the last level in levelItemsMap (root level),
			// we add the item directly to rootItems, as it has no parent to attach to.
			if levelIndex == int(maxLevel)-1 {
				rootItems = append(rootItems, grpcItem)
				continue
			}

			// Retrieve the parent level, which is always the next item in levelItemsMap.
			// This works because levelItemsMap is ordered in reverse.
			// The previous check prevents out-of-bounds errors by ensuring we're not at the root level.
			parentLevel := levelItemsMap[levelIndex+1]

			// Find the parentNode of the current item by looking up its parentId in the parent level map.
			parentNode, ok := parentLevel[grpcItem.ParentId]
			if !ok {
				return nil, fmt.Errorf("item %s with parent id %d couldn't be found the parent level - check that data is sorted by level", grpcItem.Label, grpcItem.ParentId)
			}
			// Attach the current item as a child of its parentNode.
			parentNode.Items = append(parentNode.Items, grpcItem)

		}
	}
	return rootItems, nil
}

func (a *AccountsAdapter) UserCreateUpdateRequestFromAuthRegister(req *devkitv1.AuthRegisterRequest) *devkitv1.UserCreateUpdateRequest {
	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(req.UserPassword), bcrypt.DefaultCost)
	resp := &devkitv1.UserCreateUpdateRequest{
		UserName:     req.UserName,
		UserTypeId:   req.UserTypeId,
		UserPhone:    req.UserPhone,
		UserEmail:    req.UserEmail,
		UserPassword: string(hashedPassword),
	}
	return resp
}

func (a *AccountsAdapter) UserPermissionsMapRedisFromSql(resp []db.UserPermissionsMapRow) ([]byte, error) {
	respMap := make(map[string]map[string]bool)
	for _, rec := range resp {
		perms := make(map[string]bool)
		err := json.Unmarshal(rec.Permissions, &perms)
		if err != nil {
			return nil, err
		}
		respMap[rec.PermissionGroup] = perms
	}
	respoinse, err := json.Marshal(respMap)
	return respoinse, err
}

func (a *AccountsAdapter) AuthLoginSqlFromGrpc(req *devkitv1.AuthLoginRequest) (*db.UserFindParams, *types.TokenRequest) {
	isEmail := strings.Contains(req.LoginCode, "@") && strings.Contains(req.LoginCode, ".")
	supabseRequest := &types.TokenRequest{Password: req.UserPassword}
	if isEmail {
		supabseRequest.Email = req.LoginCode
	} else {
		supabseRequest.Phone = req.LoginCode
	}
	supabseRequest.GrantType = "password"
	return &db.UserFindParams{
		SearchKey: req.LoginCode,
	}, supabseRequest
}

func (a *AccountsAdapter) AuthLoginGrpcFromSql(resp *db.AccountsSchemaUser) *devkitv1.AuthLoginResponse {
	return &devkitv1.AuthLoginResponse{
		User: a.UserEntityGrpcFromSql(resp),
	}
}
func (a *AccountsAdapter) NavigationBarItemGrpcFromSql(resp *db.UserNavigationBarFindRow) *devkitv1.NavigationBarItem {
	if !resp.LabelAr.Valid {
		resp.LabelAr.String = resp.Label
	}
	return &devkitv1.NavigationBarItem{
		Key:                 resp.MenuKey,
		Level:               resp.Level,
		NavigationBarItemId: resp.NavigationBarItemID,
		ParentId:            resp.ParentID.Int32,
		Label:               resp.Label,
		LabelAr:             resp.LabelAr.String,
		Icon:                resp.Icon.String,
		Route:               resp.Route.String,
	}
}

func (a *AccountsAdapter) AuthResetPasswordSupaFromGrpc(req *devkitv1.AuthResetPasswordRequest) *types.VerifyForUserRequest {
	return &types.VerifyForUserRequest{
		Type:       types.VerificationTypeRecovery,
		Token:      req.ResetToken,
		Email:      req.Email,
		RedirectTo: req.RedirectUrl,
	}
}

func (a *AccountsAdapter) PermissionGroupFromFunctionName(funName string) string {
	functionNameSnake := strcase.ToSnake(funName)
	functionNameParts := strings.Split(functionNameSnake, "_")
	group := functionNameParts[0]

	return group
}
