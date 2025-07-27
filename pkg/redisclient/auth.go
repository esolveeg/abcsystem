package redisclient

import (
	"context"
	"crypto/sha256"
	"encoding/json"
	"fmt"
	"time"

	"github.com/rs/zerolog/log"
)

type PermissionsMap map[string]map[string]bool
type AuthSession struct {
	SessionKey                    string    `json:"key"`
	UserID                        int32     `json:"user_id"`
	AccessTokenID                 string    `json:"access_token_id"`
	TokenID                       string    `json:"token_id"`
	IPAddress                     string    `json:"ip_address"`
	IsBlocked                     bool      `json:"is_blocked"`
	UserAgent                     string    `json:"user_agent"`
	AccessToken                   string    `json:"access_token"`
	RefreshToken                  string    `json:"refresh_token"`
	SupabaseAccessToken           string    `json:"supabase_access_token"`
	SupabaseRefreshToken          string    `json:"supabase_refresh_token"`
	CreatedAt                     time.Time `json:"created_at"`
	AccessTokenExpiresAt          time.Time `json:"access_token_expires_at"`
	RefreshTokenExpiresAt         time.Time `json:"refresh_token_expires_at"`
	SupabaseAccessTokenExpiresAt  time.Time `json:"supabase_access_token_expires_at"`
	SupabaseRefreshTokenExpiresAt time.Time `json:"supabase_refresh_token_expires_at"`
}

func userPermissionsKey(userID int32) string {
	return fmt.Sprintf("user_permissions:%d", userID)
}
func (r *RedisClient) UserPermissionCreate(ctx context.Context, userID int32, perms *PermissionsMap) error {
	key := userPermissionsKey(userID)
	data, err := json.Marshal(perms)
	if err != nil {
		return err
	}
	return r.client.Set(ctx, key, data, 0).Err() // no expiration
}
func (r *RedisClient) UserPermissionDelete(ctx context.Context, userID int32) error {
	key := userPermissionsKey(userID)
	return r.client.Del(ctx, key).Err()
}
func (r *RedisClient) UserPermissionFind(ctx context.Context, userID int32) (PermissionsMap, error) {
	key := userPermissionsKey(userID)
	data, err := r.client.Get(ctx, key).Bytes()
	if err != nil {
		return nil, err
	}

	var perms PermissionsMap
	if err := json.Unmarshal(data, &perms); err != nil {
		return nil, err
	}
	return perms, nil
}
func (r *RedisClient) GenerateAuthSessionKey(userID int32, tokenID string) string {
	return fmt.Sprintf("auth_session:%d:%s", userID, tokenID)
}

func (r *RedisClient) AuthSessionDeleteByUserAgent(ctx context.Context, userID int32, userAgent string) error {
	hash := sha256.Sum256([]byte(userAgent))
	indexKey := fmt.Sprintf("user_sessions_by_agent:%d:%x", userID, hash[:])

	keys, err := r.client.SMembers(ctx, indexKey).Result()
	if err != nil {
		return err
	}

	if len(keys) > 0 {
		if err := r.client.Del(ctx, keys...).Err(); err != nil {
			return err
		}
		// Remove from main index too
		r.client.SRem(ctx, fmt.Sprintf("user_sessions:%d", userID), keys)
	}

	return r.client.Del(ctx, indexKey).Err()
}
func (r *RedisClient) AuthSessionCreateByKey(ctx context.Context, session *AuthSession, key string, ttl time.Duration) error {
	session.SessionKey = key
	session.CreatedAt = time.Now()
	data, err := json.Marshal(session)
	if err != nil {
		return err
	}
	err = r.client.Set(ctx, key, data, ttl).Err()
	if err != nil {
		return err
	}
	userAgentKey := fmt.Sprintf("user_sessions_by_agent:%d:%x", session.UserID, sha256.Sum256([]byte(session.UserAgent)))
	r.client.SAdd(ctx, userAgentKey, key) // key = auth_session:{userID}:{tokenID}
	accessIndexKey := fmt.Sprintf("user_sessions_by_access_token_id:%s", session.AccessTokenID)
	r.client.Set(ctx, accessIndexKey, key, ttl)
	return nil
}
func (r *RedisClient) AuthSessionCreate(ctx context.Context, session *AuthSession, tokenID string, ttl time.Duration) error {
	key := r.GenerateAuthSessionKey(session.UserID, tokenID)
	return r.AuthSessionCreateByKey(ctx, session, key, ttl)
}
func (r *RedisClient) AuthSessionFindByAccessTokenID(ctx context.Context, accessTokenID string) (*AuthSession, error) {
	indexKey := fmt.Sprintf("user_sessions_by_access_token_id:%s", accessTokenID)
	sessionKey, err := r.client.Get(ctx, indexKey).Result()
	if err != nil {
		return nil, err
	}

	return r.AuthSessionFindByKey(ctx, sessionKey)
}
func (r *RedisClient) AuthSessionFindByKey(ctx context.Context, key string) (*AuthSession, error) {
	data, err := r.client.Get(ctx, key).Bytes()
	if err != nil {
		return nil, err
	}

	var session AuthSession
	if err := json.Unmarshal(data, &session); err != nil {
		return nil, err
	}
	return &session, nil
}

func (r *RedisClient) AuthSessionFind(ctx context.Context, userID int32, tokenID string) (*AuthSession, error) {
	key := r.GenerateAuthSessionKey(userID, tokenID)
	return r.AuthSessionFindByKey(ctx, key)
}
func (r *RedisClient) AuthSessionDeleteByKey(ctx context.Context, key string) error {
	return r.client.Del(ctx, key).Err()
}
func (r *RedisClient) AuthSessionDelete(ctx context.Context, userID int32, tokenID string) error {
	key := r.GenerateAuthSessionKey(userID, tokenID)
	log.Debug().Interface("keyyyy", key).Msg("Asdasd redi")
	return r.AuthSessionDeleteByKey(ctx, key)

}

func (r *RedisClient) AuthSessionSetBlockedByKey(ctx context.Context, sessionKey string, blocked bool) error {
	session, err := r.AuthSessionFindByKey(ctx, sessionKey)
	if err != nil {
		return err
	}
	session.IsBlocked = blocked
	ttl, err := r.client.TTL(ctx, sessionKey).Result()
	if err != nil {
		return err
	}
	return r.AuthSessionCreateByKey(ctx, session, sessionKey, ttl)
}
func (r *RedisClient) AuthSessionSetBlocked(ctx context.Context, userID int32, tokenID string, blocked bool) error {
	session, err := r.AuthSessionFind(ctx, userID, tokenID)
	if err != nil {
		return err
	}
	session.IsBlocked = blocked

	// Keep the original TTL (optional)
	key := r.GenerateAuthSessionKey(userID, tokenID)
	ttl, err := r.client.TTL(ctx, key).Result()
	if err != nil {
		return err
	}

	return r.AuthSessionCreate(ctx, session, tokenID, ttl)
}
func (r *RedisClient) AuthSessionListAll(ctx context.Context) ([]*AuthSession, error) {
	var cursor uint64
	var sessions []*AuthSession

	for {
		// Get keys matching the session prefix
		keys, nextCursor, err := r.client.Scan(ctx, cursor, "auth_session:*", 100).Result()
		if err != nil {
			return nil, err
		}

		for _, key := range keys {
			data, err := r.client.Get(ctx, key).Bytes()
			if err != nil {
				// Optionally: skip corrupted/missing sessions
				continue
			}

			var session AuthSession
			if err := json.Unmarshal(data, &session); err != nil {
				continue // Optionally log invalid JSON
			}
			sessions = append(sessions, &session)
		}

		if nextCursor == 0 {
			break
		}
		cursor = nextCursor
	}

	return sessions, nil
}
func (r *RedisClient) AuthSessionUpdateTokens(
	ctx context.Context,
	userID int32,
	tokenID string,
	accessToken string,
	accessTokenExpiresAt time.Time,
	refreshToken string,
	refreshTokenExpiresAt time.Time,
	supabaseAccessToken string,
	supabaseAccessTokenExpiresAt time.Time,
	supabaseRefreshToken string,
	supabaseRefreshTokenExpiresAt time.Time,
) error {
	key := r.GenerateAuthSessionKey(userID, tokenID)

	// Load existing session
	session, err := r.AuthSessionFind(ctx, userID, tokenID)
	if err != nil {
		return err
	}

	// Update only token-related fields
	session.AccessToken = accessToken
	session.AccessTokenExpiresAt = accessTokenExpiresAt
	session.RefreshToken = refreshToken
	session.RefreshTokenExpiresAt = refreshTokenExpiresAt
	session.SupabaseAccessToken = supabaseAccessToken
	session.SupabaseAccessTokenExpiresAt = supabaseAccessTokenExpiresAt
	session.SupabaseRefreshToken = supabaseRefreshToken
	session.SupabaseRefreshTokenExpiresAt = supabaseRefreshTokenExpiresAt

	// Preserve original TTL
	ttl, err := r.client.TTL(ctx, key).Result()
	if err != nil {
		return err
	}

	return r.AuthSessionCreate(ctx, session, tokenID, ttl)
}
func (r *RedisClient) AuthSessionClearAll(ctx context.Context, userID int32) error {
	indexKey := fmt.Sprintf("user_sessions:%d", userID)

	keys, err := r.client.SMembers(ctx, indexKey).Result()
	if err != nil {
		return err
	}

	if len(keys) > 0 {
		if err = r.client.Del(ctx, keys...).Err(); err != nil {
			return err
		}
	}
	err = r.UserPermissionDelete(ctx, userID)
	if err != nil {
		return err
	}
	return r.client.Del(ctx, indexKey).Err()
}
func (r *RedisClient) AuthSessionListByUser(ctx context.Context, userID int32) ([]*AuthSession, error) {
	prefix := fmt.Sprintf("auth_session:%d:", userID)
	var (
		cursor   uint64
		sessions []*AuthSession
	)

	for {
		// Match pattern
		keys, nextCursor, err := r.client.Scan(ctx, cursor, prefix+"*", 100).Result()
		if err != nil {
			return nil, err
		}

		for _, key := range keys {
			data, err := r.client.Get(ctx, key).Bytes()
			if err != nil {
				continue // optionally log
			}
			var session AuthSession
			if err := json.Unmarshal(data, &session); err != nil {
				continue
			}
			sessions = append(sessions, &session)
		}

		if nextCursor == 0 {
			break
		}
		cursor = nextCursor
	}
	log.Debug().Interface("asd", sessions).Msg("res")
	return sessions, nil
}
