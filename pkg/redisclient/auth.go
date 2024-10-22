package redisclient

import (
	"context"
	"encoding/json"
)

type PermissionsMap map[string]map[string]bool

func (r *RedisClient) AuthSessionCreate(ctx context.Context, userName string, permissions []byte) (PermissionsMap, error) {
	if permissions == nil {
		r.client.Del(ctx, userName)
		return nil, nil
	}

	err := r.client.Set(ctx, userName, permissions, 0).Err()
	if err != nil {
		return nil, err
	}
	_, err = r.AuthSessionFind(ctx, userName)
	if err != nil {
		return nil, err
	}
	var parsedStruct PermissionsMap
	if err = json.Unmarshal(permissions, &parsedStruct); err != nil {
		return nil, err
	}

	return parsedStruct, nil
}

func (r *RedisClient) AuthSessionFind(ctx context.Context, username string) (PermissionsMap, error) {
	var parsedStruct PermissionsMap
	jsonBytes, err := r.client.Get(ctx, username).Bytes()
	if err != nil {
		return nil, err
	}
	if err = json.Unmarshal(jsonBytes, &parsedStruct); err != nil {
		return nil, err
	}

	return parsedStruct, nil
}
