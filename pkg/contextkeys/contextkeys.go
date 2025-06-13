package contextkeys

import (
	"context"

	"github.com/rs/zerolog/log"
)

// callerIDKey is an unexported type to avoid key collisions.
type contectType string

// callerIDKey is an unexported variable of the unique key type.
var callerIDKey = contectType("CallerID")
var tenantIDKey = contectType("TenantID")
var permissionFunctionKey = contectType("PermissionFunction")
var permissionGroupKey = contectType("PermissionGroup")

var RefreshTokenKey = contectType("RefreshToken")
var SupabaseTokenKey = contectType("SupabaseToken")
var SupabaseRefreshTokenKey = contectType("SupabaseRefreshToken")

func WithRefreshToken(ctx context.Context, token string) context.Context {
	return context.WithValue(ctx, RefreshTokenKey, token)
}

func WithSupabaseToken(ctx context.Context, token string) context.Context {
	return context.WithValue(ctx, SupabaseTokenKey, token)
}
func WithSupabaseRefreshToken(ctx context.Context, token string) context.Context {
	return context.WithValue(ctx, SupabaseRefreshTokenKey, token)
}

// WithCallerID injects the caller ID into the context.
func WithCallerID(ctx context.Context, callerID int32) context.Context {
	return context.WithValue(ctx, callerIDKey, callerID)
}

// this method injects the tenant id on the context
// this should be use later from the repo layer to access the tenant id of the logged in user
func WithiTenantID(ctx context.Context, tenantID int32) context.Context {
	return context.WithValue(ctx, tenantIDKey, tenantID)
}

func WithPermissionGroup(ctx context.Context, permissionGroup string) context.Context {
	return context.WithValue(ctx, permissionGroupKey, permissionGroup)
}

// this method injects the permission name for this function this should check for skip authorization is false
// and then it returns the permission function by handling the create update endpoints while checking for the record id
// and pass the correct permission name [create , update] based on that , if it's normal endpoint it will just add the endpoint name like list or delete
func WithPermissionFunction(ctx context.Context, permissionFunction string) context.Context {
	log.Debug().Interface("perfunc", permissionFunction).Msg("ctxxx")
	return context.WithValue(ctx, permissionFunctionKey, permissionFunction)
}

// CallerID retrieves the caller ID from the context safely.
// Returns an empty string if the caller ID is not present or the type is incorrect.
func CallerID(ctx context.Context) (int32, bool) {
	callerID, ok := ctx.Value(callerIDKey).(int32)
	return callerID, ok
}
func PermissionFunction(ctx context.Context) (string, bool) {
	permissionFunction, ok := ctx.Value(permissionFunctionKey).(string)
	return permissionFunction, ok
}

func PermissionGroup(ctx context.Context) (string, bool) {
	permissionGroup, ok := ctx.Value(permissionGroupKey).(string)
	return permissionGroup, ok
}
func RefreshToken(ctx context.Context) (string, bool) {
	token, ok := ctx.Value(RefreshTokenKey).(string)
	return token, ok
}
func SupabaseToken(ctx context.Context) (string, bool) {
	token, ok := ctx.Value(SupabaseTokenKey).(string)
	return token, ok
}

func SupabaseRefreshToken(ctx context.Context) (string, bool) {
	token, ok := ctx.Value(SupabaseRefreshTokenKey).(string)
	return token, ok
}
func TenantID(ctx context.Context) (int32, bool) {
	tenantID, ok := ctx.Value(tenantIDKey).(int32)
	return tenantID, ok
}
