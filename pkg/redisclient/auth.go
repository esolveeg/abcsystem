package redisclient

import (
	"context"
	"encoding/json"
	"strconv"

	"github.com/darwishdev/devkit-api/db"
)

type PermissionsMap map[string]map[string]bool

func (r *RedisClient) UserPermissionsMapRedisFromSql(resp *[]db.UserPermissionsMapRow) (PermissionsMap, error) {
	respMap := make(PermissionsMap)
	for _, rec := range *resp {
		perms := make(map[string]bool)
		err := json.Unmarshal(rec.Permissions, &perms)
		if err != nil {
			return nil, err
		}
		respMap[rec.PermissionGroup] = perms
	}
	return respMap, nil
}

func (r *RedisClient) AuthSessionDelete(ctx context.Context, userId int32) error {
	key := strconv.Itoa(int(userId))
	err := r.client.Del(ctx, key).Err()
	if err != nil {
		return err
	}

	return nil
}

func (r *RedisClient) AuthSessionCreate(ctx context.Context, userId int32, permissions *[]db.UserPermissionsMapRow) (PermissionsMap, error) {
	key := strconv.Itoa(int(userId))
	if permissions == nil {
		r.client.Del(ctx, key)
		return nil, nil
	}
	permissionMap, err := r.UserPermissionsMapRedisFromSql(permissions)
	if err != nil {
		return nil, err
	}
	response, err := json.Marshal(permissionMap)
	if err != nil {
		return nil, err
	}
	err = r.client.Set(ctx, key, response, 0).Err()
	if err != nil {
		return nil, err
	}
	_, err = r.AuthSessionFind(ctx, userId)
	if err != nil {
		return nil, err
	}

	return r.UserPermissionsMapRedisFromSql(permissions)
}

func (r *RedisClient) AuthSessionFind(ctx context.Context, userId int32) (PermissionsMap, error) {
	var parsedStruct PermissionsMap
	key := strconv.Itoa(int(userId))
	jsonBytes, err := r.client.Get(ctx, key).Bytes()
	if err != nil {
		return nil, err
	}
	if err = json.Unmarshal(jsonBytes, &parsedStruct); err != nil {
		return nil, err
	}

	return parsedStruct, nil
}
