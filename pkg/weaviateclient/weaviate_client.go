package weaviateclient

import (
	"context"
	"fmt"

	"github.com/rs/zerolog/log"
	"github.com/weaviate/weaviate-go-client/v5/weaviate"
	"github.com/weaviate/weaviate-go-client/v5/weaviate/filters"
	"github.com/weaviate/weaviate-go-client/v5/weaviate/graphql"
)
type WeaviateClientInterface interface {
	CommandPalleteCreateUpdate(ctx context.Context, doc *CommandPallete) error
	CommandPalleteDelete(ctx context.Context, documnetId string) error
	CommandPaletteSearch(ctx context.Context, tenantID int32, query string, limit int) ([]*CommandPallete, error)
}
type CommandPallete struct {
	ID       string   `json:"id"`
	Label    string   `json:"label"`
	LabelAr  string   `json:"label_ar,omitempty"`
	MenuKey  string   `json:"menu_key,omitempty"`
	Icon     string   `json:"icon,omitempty"`
	Type     string   `json:"type"`
	URL      string   `json:"url"`
	TenantID int32    `json:"tenant_id"`
	Keywords []string `json:"keywords,omitempty"`
}

type WeaviateClient struct {
	client *weaviate.Client
}

func NewWeaviateClient(host, scheme string) (WeaviateClientInterface, error) {
	cfg := weaviate.Config{
		Host:   host,
	
		Scheme: scheme,
	}
	client, err := weaviate.NewClient(cfg)
	if err != nil {
		return nil, err
	}
	return &WeaviateClient{client: client}, nil
}



func (w *WeaviateClient) CommandPalleteDelete(ctx context.Context, id string) error {
	err := w.client.Data().Deleter().
		WithClassName("CommandPalette").
		WithID(id).
		Do(ctx)    
	if err != nil {
		return fmt.Errorf("failed to delete CommandPalette %q: %w", id, err)
	}

	return nil
}

func (w *WeaviateClient) CommandPalleteCreateUpdate(ctx context.Context, doc *CommandPallete) error {
	resp , err:= w.client.GraphQL().
	Get().
	      WithClassName("CommandPalette").
        WithFields(
            graphql.Field{
                Name: "_additional",
                Fields: []graphql.Field{
                    {Name: "id"},
                },
            },
        ).
WithWhere(filters.Where().WithPath([]string{"menu_key"}).WithOperator(filters.Equal).WithValueString(doc.MenuKey)).
        Do(ctx)
    // 2) Query for any existing object
    if err != nil {
        return fmt.Errorf("query existing CommandPalette: %w", err)
    }

    // 3) Prepare the shared property map
    props := map[string]any{
        "menu_key":  doc.MenuKey,
        "label":     doc.Label,
        "label_ar":  doc.LabelAr,
        "icon":      doc.Icon,
        "type":      doc.Type,
        "url":       doc.URL,
		"tenant_id": doc.TenantID,
		"keywords":  doc.Keywords,
	}
	log.Debug().Interface("datal", resp.Data).Msg("new")
	if resp.Data["Get"] != nil  {
		itemsV := resp.Data["Get"].(map[string]any)["CommandPalette"]
		if itemsV != nil {
			items := itemsV.([]any)
			if len(items) > 0 && false {
				// grab the first match
				first := items[0].(map[string]any)
				additional := first["_additional"].(map[string]any)
				existingID := additional["id"].(string)

				err = w.client.Data().Updater().
					WithClassName("CommandPalette").
					WithID(existingID).
					WithProperties(props).
					Do(ctx)
				if err != nil {
					return fmt.Errorf("update existing CommandPalette (%s): %w", existingID, err)
				}
				return nil
			}
		}
	}

	_ ,err = w.client.Data().Creator().
		WithClassName("CommandPalette").
		WithID(doc.ID).
		WithProperties(map[string]any{
			"label":     doc.Label,
			"label_ar":  doc.LabelAr,
			"icon":      doc.Icon,
			"type":      doc.Type,
			"url":       doc.URL,
			"tenant_id": doc.TenantID,
			"menu_key": doc.MenuKey,
			"keywords":  doc.Keywords,
		}).
		Do(ctx)
	return err
}



func (w *WeaviateClient) CommandPaletteSearch(ctx context.Context, tenantID int32, query string, limit int) ([]*CommandPallete, error) {
    // 1) Build the GraphQL hybrid query
    q := w.client.GraphQL().Get().
        WithClassName("CommandPalette").
        WithFields(
            graphql.Field{Name: "label"},
            graphql.Field{Name: "label_ar"},
            graphql.Field{Name: "icon"},
            graphql.Field{Name: "type"},
            graphql.Field{Name: "url"},
            graphql.Field{Name: "tenant_id"},
        ).
        WithHybrid(
            w.client.GraphQL().
                HybridArgumentBuilder().
                WithQuery(query).
								WithAlpha(.8).
                WithVector(
                    w.client.GraphQL().
                        NearTextArgBuilder().
                        WithConcepts([]string{query}).
                        WithCertainty(.8),
                ),
        ).
        WithLimit(limit).
	WithAutocut(1)

    // 2) Execute it
    resp, err := q.Do(ctx)
    if err != nil {
        return nil, fmt.Errorf("weaviate hybrid search failed: %w", err)
    }
    if len(resp.Errors) > 0 {
			log.Debug().Interface("new", resp.Errors).Msg("new")
        return nil, fmt.Errorf("weaviate returned errors: %+v", resp.Errors)
    }

    // 3) Parse the response
    rawGet := resp.Data["Get"].(map[string]any)
    rawArr := rawGet["CommandPalette"].([]any)

    var out []*CommandPallete
    for _, item := range rawArr {
        m := item.(map[string]any)
        out = append(out, &CommandPallete{
            Label:    getString(m, "label"),
            LabelAr:  getString(m, "label_ar"),
            Icon:     getString(m, "icon"),
            Type:     getString(m, "type"),
            URL:      getString(m, "url"),
            TenantID: getInt(m, "tenant_id"),
        })
    }

    return out, nil
}


// Helper to safely extract string fields
func getString(m map[string]any, key string) string {
	if val, ok := m[key].(string); ok {
		return val
	}
	return ""
}

// Helper to safely extract float64 fields (for integer IDs)
func getInt(m map[string]any, key string) int32 {
	if val, ok := m[key].(int32); ok {
		return val
	}
	return 0
}

func toStringSlice(raw any) []string {
	if raw == nil {
		return nil
	}
	arr := raw.([]any)
	out := make([]string, len(arr))
	for i, v := range arr {
		out[i] = fmt.Sprintf("%v", v)
	}
	return out
}
