package contextkeys

import (
	"context"

	"github.com/rs/zerolog/log"
)

type contextKeysType string

var (
	callerIDKey             = contextKeysType("CallerID")
	tenantIDKey             = contextKeysType("TenantID")
	permissionFunctionKey   = contextKeysType("PermissionFunction")
	permissionGroupKey      = contextKeysType("PermissionGroup")
	RefreshTokenKey         = contextKeysType("RefreshToken")
	SupabaseTokenKey        = contextKeysType("SupabaseToken")
	SupabaseRefreshTokenKey = contextKeysType("SupabaseRefreshToken")

	sqlQueryKey       = contextKeysType("SQLQuery")
	sqlArgumentsKey   = contextKeysType("SQLArguments")
	dbErrorMessageKey = contextKeysType("DBErrorMessage")
	sqlResponseKey    = contextKeysType("SQLResponse")
)

// Auth Tokens
func WithRefreshToken(ctx context.Context, token string) context.Context {
	return context.WithValue(ctx, RefreshTokenKey, token)
}
func RefreshToken(ctx context.Context) (string, bool) {
	token, ok := ctx.Value(RefreshTokenKey).(string)
	return token, ok
}

func WithSupabaseToken(ctx context.Context, token string) context.Context {
	return context.WithValue(ctx, SupabaseTokenKey, token)
}
func SupabaseToken(ctx context.Context) (string, bool) {
	token, ok := ctx.Value(SupabaseTokenKey).(string)
	return token, ok
}

func WithSupabaseRefreshToken(ctx context.Context, token string) context.Context {
	return context.WithValue(ctx, SupabaseRefreshTokenKey, token)
}
func SupabaseRefreshToken(ctx context.Context) (string, bool) {
	token, ok := ctx.Value(SupabaseRefreshTokenKey).(string)
	return token, ok
}

// Identity
func WithCallerID(ctx context.Context, callerID int32) context.Context {
	return context.WithValue(ctx, callerIDKey, callerID)
}
func CallerID(ctx context.Context) (int32, bool) {
	callerID, ok := ctx.Value(callerIDKey).(int32)
	return callerID, ok
}

func WithiTenantID(ctx context.Context, tenantID int32) context.Context {
	return context.WithValue(ctx, tenantIDKey, tenantID)
}
func TenantID(ctx context.Context) (int32, bool) {
	tenantID, ok := ctx.Value(tenantIDKey).(int32)
	return tenantID, ok
}

// Permission Info
func WithPermissionGroup(ctx context.Context, group string) context.Context {
	return context.WithValue(ctx, permissionGroupKey, group)
}
func PermissionGroup(ctx context.Context) (string, bool) {
	group, ok := ctx.Value(permissionGroupKey).(string)
	return group, ok
}

func WithPermissionFunction(ctx context.Context, fn string) context.Context {
	log.Debug().Str("perfunc", fn).Msg("context injection")
	return context.WithValue(ctx, permissionFunctionKey, fn)
}
func PermissionFunction(ctx context.Context) (string, bool) {
	fn, ok := ctx.Value(permissionFunctionKey).(string)
	return fn, ok
}

// SQL Info
func WithSQLQuery(ctx context.Context, sql string) context.Context {

	log.Debug().Interface("insert sql query ars", ctx).Msg("context setter")
	return context.WithValue(ctx, sqlQueryKey, sql)
}
func SQLQuery(ctx context.Context) (string, bool) {
	log.Debug().Interface("getting sql query here", ctx).Msg("context setter")
	sql, ok := ctx.Value(sqlQueryKey).(string)
	return sql, ok
}

func WithSQLArguments(ctx context.Context, args []any) context.Context {
	log.Debug().Interface("inseting sql query ars", ctx).Msg("context setter")
	return context.WithValue(ctx, sqlArgumentsKey, args)
}
func SQLArguments(ctx context.Context) ([]any, bool) {
	args, ok := ctx.Value(sqlArgumentsKey).([]any)

	log.Debug().Interface("getting sql query ars", ctx).Msg("context setter")
	return args, ok
}

func WithSQLResponse(ctx context.Context, resp any) context.Context {
	return context.WithValue(ctx, sqlResponseKey, resp)
}
func SQLResponse(ctx context.Context) (any, bool) {
	resp := ctx.Value(sqlResponseKey)
	return resp, resp != nil
}

// DB Error
func WithDBError(ctx context.Context, err string) context.Context {
	return context.WithValue(ctx, dbErrorMessageKey, err)
}
func DBError(ctx context.Context) (string, bool) {
	err, ok := ctx.Value(dbErrorMessageKey).(string)
	return err, ok
}
