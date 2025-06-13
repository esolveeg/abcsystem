package auth

import (
	"fmt"
	"time"

	"github.com/aead/chacha20poly1305"
	"github.com/o1egl/paseto"
)

type Maker interface {
	CreateToken(payload *Payload) (string, error)
	CreateTokenPair(
		username string,
		userId int32,
		userSecurityLevel int32,
		tenantId int32,
		accessDuration time.Duration,
		refreshDuration time.Duration,
	) (*TokenPair, error)
	VerifyToken(token string) (*Payload, error)
	CreateRefreshToken(refreshPayload *RefreshPayload) (string, error)
	// VerifyRefreshToken validates a refresh token and returns its payload if valid.
	VerifyRefreshToken(token string) (*RefreshPayload, error)
}

func NewPasetoMaker(symmetricKey string) (Maker, error) {
	if len(symmetricKey) != chacha20poly1305.KeySize {
		return nil, fmt.Errorf("invalid key size: must be exactly %d characters", chacha20poly1305.KeySize)
	}

	maker := &PasetoMaker{
		paseto:       paseto.NewV2(),
		symmetricKey: []byte(symmetricKey),
	}

	return maker, nil
}
