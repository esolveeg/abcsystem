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
	u := *c.base
	u.Path = path.Join(c.base.Path, p)
	u.RawQuery = q.Encode()

	var rdr io.Reader
	if body != nil {
		b, err := json.Marshal(body)
		if err != nil {
			return err
		}
		rdr = bytes.NewReader(b)
	}

	req, err := http.NewRequestWithContext(ctx, method, u.String(), rdr)
	if err != nil {
		return err
	}
	if body != nil {
		req.Header.Set("Content-Type", "application/json")
	}
	if c.token != "" {
		req.Header.Set("Authorization", c.token) // already "token key:secret"
	}
	if c.cookie != "" {
		req.Header.Set("Cookie", c.cookie)
	}

	resp, err := c.http.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	// ERPNext success still returns 200/201 and {data:...}
	// Errors are 400/401/403/404/417/500 with body containing details.
	b, err := io.ReadAll(resp.Body)
	if err != nil {
		return err
	}
	if resp.StatusCode >= 300 {
		return parseERPError(resp.StatusCode, b)
	}
	if out == nil {
		return nil
	}
	// Some endpoints return {"data":null}; allow that
	if len(b) == 0 {
		return nil
	}
	return json.Unmarshal(b, out)
}
