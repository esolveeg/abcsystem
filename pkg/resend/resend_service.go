package resend

import (
	"github.com/resend/resend-go/v2"
)

func (r *ResendService) SendEmail(req *resend.SendEmailRequest) (*resend.SendEmailResponse, error) {
	resp, err := r.Client.Emails.Send(req)
	if err != nil {
		return nil, err
	}

	return resp, nil
}
