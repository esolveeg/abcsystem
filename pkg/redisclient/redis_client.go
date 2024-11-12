package redisclient

import (
	"context"
	"fmt"

	"github.com/darwishdev/devkit-api/db"
	"github.com/redis/go-redis/v9"
)

type RedisClientInterface interface {
	AuthSessionCreate(ctx context.Context, userId int32, permissions []db.UserPermissionsMapRow) (PermissionsMap, error)
	AuthSessionDelete(ctx context.Context, userId int32) error
	AuthSessionFind(ctx context.Context, userId int32) (PermissionsMap, error)
}

type RedisClient struct {
	client *redis.Client
}

func NewRedisClient(host string, port string, password string, db int) RedisClientInterface {
	client := redis.NewClient(&redis.Options{
		Addr:     fmt.Sprintf("%s:%s", host, port),
		Password: password, // no password set
		DB:       db,       // use default DB
	})

	return &RedisClient{
		client: client,
	}
}
