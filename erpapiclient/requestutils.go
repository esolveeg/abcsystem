// erpapiclient/generic.go

package erpapiclient

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"path"
	"strings"

	"github.com/rs/zerolog/log"
)

// ResourceGet GET /api/resource/<DocType>/<name>?fields=...
func ResourceGet[T any](ctx context.Context, c *Client, doctype, name string, fields []string) (*T, error) {
	p := fmt.Sprintf("/api/resource/%s/%s", url.PathEscape(doctype), url.PathEscape(name))
	q := url.Values{}
	if len(fields) > 0 {
		b, _ := json.Marshal(fields)
		q.Set("fields", string(b))
	}
	var env Envelope[T]
	if err := c.do(ctx, http.MethodGet, p, q, nil, &env); err != nil {
		return nil, err
	}
	return &env.Data, nil
}

// ResourceList GET /api/resource/<DocType>?filters=...&fields=...
func ResourceList[T any](ctx context.Context, c *Client, doctype string, opt *ListOptions) ([]T, error) {
	p := fmt.Sprintf("/api/resource/%s", url.PathEscape(doctype))
	q := url.Values{}
	if opt != nil {
		if len(opt.Fields) > 0 {
			b, _ := json.Marshal(opt.Fields)
			q.Set("fields", string(b))
		}
		if len(opt.Filters) > 0 {
			b, _ := json.Marshal(opt.Filters.AsERPJSON())
			q.Set("filters", string(b))
		}
		if opt.Limit > 0 {
			q.Set("limit", fmt.Sprint(opt.Limit))
		}
		if opt.LimitStart > 0 {
			q.Set("limit_start", fmt.Sprint(opt.LimitStart))
		}
		if opt.OrderBy != "" {
			q.Set("order_by", opt.OrderBy)
		}
	}
	var env EnvelopeSlice[T]
	if err := c.do(ctx, http.MethodGet, p, q, nil, &env); err != nil {
		return nil, err
	}
	return env.Data, nil
}

// ResourceInsert POST /api/resource/<DocType>
func ResourceInsert[T any](ctx context.Context, c *Client, doctype string, doc any) (*T, error) {
	p := fmt.Sprintf("/api/resource/%s", url.PathEscape(doctype))
	var env Envelope[T]
	if err := c.do(ctx, http.MethodPost, p, nil, doc, &env); err != nil {
		return nil, err
	}
	return &env.Data, nil
}

// ResourceUpdate PUT /api/resource/<DocType>/<name>
func ResourceUpdate[T any](ctx context.Context, c *Client, doctype, name string, doc any) (*T, error) {
	p := fmt.Sprintf("/api/resource/%s/%s", url.PathEscape(doctype), url.PathEscape(name))
	var env Envelope[T]
	if err := c.do(ctx, http.MethodPut, p, nil, doc, &env); err != nil {
		return nil, err
	}
	return &env.Data, nil
}

// MethodCall POST /api/method/<method>
func MethodCall[T any](ctx context.Context, c *Client, method string, params any) (*T, error) {
	m := path.Join("/api/method", trimAPIMethod(method))
	var out T
	var raw map[string]json.RawMessage
	log.Debug().Interface("log row", params).Msg("requrest body")
	if err := c.do(ctx, http.MethodGet, m, nil, params, &raw); err != nil {
		log.Debug().Interface("log err", err).Msg("requrest body")
		return nil, err
	}
	if v, ok := raw["message"]; ok {
		log.Debug().Interface("log ok", ok).Msg("requrest ok")
		if err := json.Unmarshal(v, &out); err == nil {
			log.Debug().Interface("log out", out).Msg("requrest out")
			return &out, nil
		}
	}
	if v, ok := raw["data"]; ok {
		if err := json.Unmarshal(v, &out); err == nil {
			return &out, nil
		}
	}
	b, _ := json.Marshal(raw)
	if err := json.Unmarshal(b, &out); err != nil {
		log.Debug().Interface("log err unmarsha", err).Msg("requrest unmarsha")
		return nil, &ERPError{Status: 500, Detail: "unexpected ERPNext response"}
	}
	return &out, nil
}

func trimAPIMethod(method string) string {
	s := strings.TrimPrefix(method, "/")
	s = strings.TrimPrefix(s, "api/method/")
	return s
}
