package erpapiclient

import (
	"encoding/json"
	"fmt"

	"github.com/rs/zerolog/log"
)

type ERPError struct {
	Status  int
	Title   string
	Detail  string
	Type    string
	TraceID string
}

func (e *ERPError) Error() string {
	if e.Title != "" {
		return fmt.Sprintf("erp(%d): %s: %s", e.Status, e.Title, e.Detail)
	}
	return fmt.Sprintf("erp(%d): %s", e.Status, e.Detail)
}

func parseERPError(code int, body []byte) error {
	// ERPNext errors vary; try a few common patterns
	var x struct {
		ExcType        string `json:"exc_type"`
		ServerMessages string `json:"_server_messages"`
		Message        any    `json:"message"`
		Exception      string `json:"exception"`
	}
	if err := json.Unmarshal(body, &x); err == nil {
		msg := firstNonEmpty(
			stringify(x.Message),
			x.Exception,
			x.ServerMessages,
		)
		return &ERPError{
			Status: code,
			Title:  x.ExcType,
			Detail: msg,
			Type:   x.ExcType,
		}
	}
	log.Debug().
		Interface("exception", x.Exception).
		Interface("message", x.ServerMessages).
		Interface("message", x.Message).
		Msg("error handler")
	// Fallback: raw text
	return &ERPError{Status: code, Detail: string(body)}
}

func stringify(v any) string {
	switch t := v.(type) {
	case string:
		return t
	case []byte:
		return string(t)
	default:
		b, _ := json.Marshal(v)
		return string(b)
	}
}

func firstNonEmpty(ss ...string) string {
	for _, s := range ss {
		if s != "" {
			return s
		}
	}
	return ""
}
