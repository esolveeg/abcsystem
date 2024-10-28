package resend

import (
	"github.com/resend/resend-go/v2"
)

type ResendServiceInterface interface {
	SendEmail(req *resend.SendEmailRequest) (*resend.SendEmailResponse, error)
}
type ResendService struct {
	Client  *resend.Client
	BaseUrl string
}

func NewResendService(apiKey string, baseUrl string) (ResendServiceInterface, error) {
	client := resend.NewClient(apiKey)
	return &ResendService{
		Client:  client,
		BaseUrl: baseUrl,
	}, nil
}
