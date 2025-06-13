package auth

import (
	"time"

	"github.com/o1egl/paseto"
)

type TokenPair struct {
	AccessToken    string
	RefreshToken   string
	AccessPayload  *Payload
	RefreshPayload *RefreshPayload
}

// PasetoMaker is a PASETO token maker
type PasetoMaker struct {
	paseto       *paseto.V2
	symmetricKey []byte
}

// CreateToken creates a new token for a specific username and duration
func (maker *PasetoMaker) CreateToken(payload *Payload) (string, error) {
	token, err := maker.paseto.Encrypt(maker.symmetricKey, payload, nil)
	return token, err
}
func (maker *PasetoMaker) CreateRefreshToken(RefreshPayload *RefreshPayload) (string, error) {
	token, err := maker.paseto.Encrypt(maker.symmetricKey, RefreshPayload, nil)
	return token, err
}
func (maker *PasetoMaker) CreateTokenPair(
	username string,
	userId int32,
	userSecurityLevel int32,
	tenantId int32,
	accessDuration time.Duration,
	refreshDuration time.Duration,
) (*TokenPair, error) {
	payload, err := NewPayload(username, userId, userSecurityLevel, tenantId, accessDuration)
	if err != nil {
		return nil, err
	}

	refreshPayload, err := NewRefreshPayload(userId, refreshDuration)
	if err != nil {
		return nil, err
	}
	accessToken, err := maker.CreateToken(payload)
	if err != nil {
		return nil, err
	}

	refreshToken, err := maker.CreateRefreshToken(refreshPayload)
	if err != nil {
		return nil, err
	}

	return &TokenPair{
		AccessToken:    accessToken,
		RefreshToken:   refreshToken,
		AccessPayload:  payload,
		RefreshPayload: refreshPayload,
	}, nil
}

// VerifyToken checks if the token is valid or not
func (maker *PasetoMaker) VerifyToken(token string) (*Payload, error) {
	payload := &Payload{}

	err := maker.paseto.Decrypt(token, maker.symmetricKey, payload, nil)
	if err != nil {
		return nil, ErrInvalidToken
	}

	err = payload.Valid()
	if err != nil {
		return nil, err
	}

	return payload, nil
}

func (maker *PasetoMaker) VerifyRefreshToken(token string) (*RefreshPayload, error) {
	payload := &RefreshPayload{}
	err := maker.paseto.Decrypt(token, maker.symmetricKey, payload, nil)

	if err != nil {
		return nil, ErrInvalidToken
	}

	err = payload.Valid()

	if err != nil {
		return nil, err
	}

	return payload, nil
}

// NewPasetoMaker creates a new PasetoMaker
