package erpapiclient

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net"
	"net/http"
	"net/url"
	"path"
	"strings"
	"time"

	"github.com/esolveeg/abcsystem/pkg/contextkeys"
	"github.com/rs/zerolog/log"
)

type contextType string

var (
	deviceIDKey  = contextType("X-Device-Id")
	authTokenKey = contextType("Authorization") // store raw header value
)

type Client struct {
	base   *url.URL
	token  string       // e.g. "token key:secret"
	cookie string       // optional: session cookie "sid=..."
	http   *http.Client // safe for concurrent use
}

type Option func(*Client)

// WithToken uses "Authorization: token <key:secret>"
func WithToken(token string) Option { return func(c *Client) { c.token = strings.TrimSpace(token) } }
func WithCookie(cookie string) Option {
	return func(c *Client) { c.cookie = strings.TrimSpace(cookie) }
}
func WithHTTPClient(h *http.Client) Option {
	return func(c *Client) { c.http = h }
}
func WithTimeout(d time.Duration) Option {
	return func(c *Client) {
		if c.http == nil {
			c.http = &http.Client{Timeout: d}
		} else {
			c.http.Timeout = d
		}
	}
}

func New(baseURL string, opts ...Option) (*Client, error) {
	if !strings.HasPrefix(baseURL, "http") {
		baseURL = "https://" + baseURL
	}
	u, err := url.Parse(baseURL)
	if err != nil {
		return nil, err
	}
	c := &Client{
		base: u,
		http: &http.Client{
			Timeout: 10 * time.Second,
			Transport: &http.Transport{
				Proxy: http.ProxyFromEnvironment,
				// sane defaults
				DialContext: (&net.Dialer{
					Timeout:   5 * time.Second,
					KeepAlive: 30 * time.Second,
				}).DialContext,
				MaxIdleConns:        100,
				MaxIdleConnsPerHost: 10,
				IdleConnTimeout:     90 * time.Second,
			},
		},
	}
	for _, opt := range opts {
		opt(c)
	}
	return c, nil
}

// ResourceDelete DELETE /api/resource/<DocType>/<name>
func (c *Client) ResourceDelete(ctx context.Context, doctype, name string) error {
	p := fmt.Sprintf("/api/resource/%s/%s", url.PathEscape(doctype), url.PathEscape(name))
	return c.do(ctx, http.MethodDelete, p, nil, nil, nil)
}

// -----------------------------
// Method Endpoints (/api/method)
// -----------------------------

// MethodCall POST /api/method/<method> with JSON body params; unmarshals "message" if present or "data".

// -----------------------------
// Internals
// -----------------------------
func (c *Client) do(ctx context.Context, method, p string, q url.Values, body any, out any) error {
	method = strings.ToUpper(method)

	u := *c.base
	u.Path = path.Join(c.base.Path, p)
	if q != nil {
		u.RawQuery = q.Encode()
	}

	var rdr io.Reader
	var bodyBytes []byte
	if body != nil {
		b, err := json.Marshal(body)
		if err != nil {
			return err
		}
		bodyBytes = b
		rdr = bytes.NewReader(b)
	}

	req, err := http.NewRequestWithContext(ctx, method, u.String(), rdr)
	if err != nil {
		return err
	}

	// Device ID
	if id, ok := contextkeys.DeviceID(ctx); ok {
		req.Header.Set(string(deviceIDKey), id)
	}
	// Authorization
	if tok, ok := contextkeys.AuthToken(ctx); ok {
		req.Header.Set(string(authTokenKey), fmt.Sprintf("token %s", tok))
	}
	if body != nil {
		req.Header.Set("Content-Type", "application/json")
	}
	req.Header.Set("Accept", "application/json")
	if c.cookie != "" {
		req.Header.Set("Cookie", c.cookie)
	}

	// ---- Debug: request info ----
	log.Debug().
		Str("method", req.Method).
		Str("url", req.URL.String()).
		Interface("headers", req.Header).
		Interface("body", bodyBytes).
		Msg("ERP request")

	resp, err := c.http.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	b, err := io.ReadAll(resp.Body)
	if err != nil {
		return err
	}

	// ---- Debug: response info ----
	log.Debug().
		Str("url", req.URL.String()).
		Int("status", resp.StatusCode).
		Msg("ERP response")

	if resp.StatusCode >= 300 {
		return parseERPError(resp.StatusCode, b)
	}
	if out == nil || len(b) == 0 {
		return nil
	}

	// ---- unwrap "message" or "data" ----
	var env struct {
		Message json.RawMessage `json:"message"`
		Data    json.RawMessage `json:"data"`
	}
	if err = json.Unmarshal(b, &env); err == nil {
		if len(env.Message) > 0 && string(env.Message) != "null" {
			return json.Unmarshal(env.Message, out)
		}
		if len(env.Data) > 0 && string(env.Data) != "null" {
			return json.Unmarshal(env.Data, out)
		}
	}
	err = json.Unmarshal(b, out)
	if err != nil {
		return fmt.Errorf("Error Parsing JSON : %2", err)
	}
	// fallback: decode whole body into out
	return nil
}
