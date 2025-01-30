package auth

import "time"

type Maker interface {
	CreateToken(username string, userId int32, userSecurityLevel int32, tenantId int32, duration time.Duration) (string, *Payload, error)
	VerifyToken(token string) (*Payload, error)
}
