package erpapiclient

import (
	"context"
	"net/url"

	abcsystemv1 "github.com/esolveeg/abcsystem/proto_gen/abcsystem/v1"
)

func (c *Client) PosSessionDashboardFind(ctx context.Context, session string) (*abcsystemv1.PosSessionDashboardFindResponse, error) {
	q := url.Values{}
	q.Set("pos_session", session)
	var rows *abcsystemv1.PosSessionDashboardFindResponse
	if err := c.do(ctx, "GET", "api/method/abcpos.api.pos_session_dashboard.get_pos_session_dashboard", q, nil, &rows); err != nil {
		return nil, err
	}
	return rows, nil
}
func (c *Client) PosSessionItemsList(ctx context.Context, session string) ([]*abcsystemv1.PosSessionItem, error) {
	q := url.Values{}
	q.Set("pos_session", session)
	var rows []*abcsystemv1.PosSessionItem
	if err := c.do(ctx, "GET", "/api/method/abcpos.api.pos_session_dashboard.get_pos_session_items", q, nil, &rows); err != nil {
		return nil, err
	}
	return rows, nil
}
