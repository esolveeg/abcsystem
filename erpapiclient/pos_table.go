package erpapiclient

import (
	"context"
	"net/url"

	abcsystemv1 "github.com/esolveeg/abcsystem/proto_gen/abcsystem/v1"
)

func (c *Client) TableList(ctx context.Context, restaurantID string) ([]*abcsystemv1.TableRow, error) {
	q := url.Values{}
	q.Set("restaurant_id", restaurantID)
	var rows []*abcsystemv1.TableRow
	if err := c.do(ctx, "GET", "/api/method/abcpos.api.table.table_list", q, nil, &rows); err != nil {
		return nil, err
	}
	return rows, nil
}

// TableOrders calls abcpos.api.restaurant.table_orders
func (c *Client) TableOrders(ctx context.Context, restaurantID string) (map[string]*abcsystemv1.TableOrdersRow, error) {
	q := url.Values{}
	q.Set("restaurant_id", restaurantID)
	var rows map[string]*abcsystemv1.TableOrdersRow
	if err := c.do(ctx, "GET", "/api/method/abcpos.api.table.table_orders", q, nil, &rows); err != nil {
		return nil, err
	}
	return rows, nil
}
