package weaviateclient

import (
	"context"
	"fmt"

	"github.com/rs/zerolog/log"
	"github.com/weaviate/weaviate-go-client/v5/weaviate"
	"github.com/weaviate/weaviate-go-client/v5/weaviate/graphql"
	"github.com/weaviate/weaviate/entities/models"
)
type WeaviateClientInterface interface {
	InitSchema(ctx context.Context) error
	CommandPalleteCreateUpdate(ctx context.Context, doc *CommandPallete) error
	CommandPalleteDelete(ctx context.Context, documnetId string) error
	CommandPaletteSearch(ctx context.Context, tenantID int32, query string, limit int) ([]*CommandPallete, error)
}
type CommandPallete struct {
	ID       string   `json:"id"`
	Label    string   `json:"label"`
	LabelAr  string   `json:"label_ar,omitempty"`
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

func (w *WeaviateClient) InitSchema(ctx context.Context) error {
	className := "CommandPalette"
	exists, err := w.client.Schema().ClassGetter().WithClassName(className).Do(ctx)
	if err == nil && exists != nil {
		return nil // already exists
	}

	class := &models.Class{
		Class: className,
		Properties: []*models.Property{
			{Name: "ID", DataType: []string{"text"}},
			{Name: "label", DataType: []string{"text"}},
			{Name: "label_ar", DataType: []string{"text"}},
			{Name: "icon", DataType: []string{"text"}},
			{Name: "type", DataType: []string{"text"}},
			{Name: "url", DataType: []string{"text"}},
			{Name: "tenant_id", DataType: []string{"int"}},
			{Name: "keywords", DataType: []string{"text[]"}},
		},
		Vectorizer: "text2vec-ollama", // Or text2vec-contextionary or other
	}
	return w.client.Schema().ClassCreator().WithClass(class).Do(ctx)
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
	_ ,err := w.client.Data().Creator().
		WithClassName("CommandPalette").
		WithID(doc.ID).
		WithProperties(map[string]any{
			"id" : doc.ID,
			"label":     doc.Label,
			"label_ar":  doc.LabelAr,
			"icon":      doc.Icon,
			"type":      doc.Type,
			"url":       doc.URL,
			"tenant_id": doc.TenantID,
			"keywords":  doc.Keywords,
		}).
		Do(ctx)
	return err
}


func (w *WeaviateClient) CommandPaletteSearch(ctx context.Context, tenantID int32, query string, limit int) ([]*CommandPallete, error) {
	// Build and execute the GraphQL query
	results, err := w.client.GraphQL().Get().
		WithClassName("CommandPalette").
		WithFields(
		graphql.Field{Name: "id"},
		graphql.Field{Name: "label"},
		graphql.Field{Name: "label_ar"},
		graphql.Field{Name: "icon"},
		graphql.Field{Name: "url"},
		graphql.Field{Name: "keywords"},
		).
		WithNearText(w.client.GraphQL().NearTextArgBuilder().
			WithConcepts([]string{query}).
			WithCertainty(0.8),
		).
		WithLimit(limit).
		Do(ctx)
	if err != nil {
		return nil, fmt.Errorf("Weaviate query failed: %w", err)
	}

	// Check for GraphQL-level errors
	if len(results.Errors) > 0 {
		return nil, fmt.Errorf("Weaviate returned errors: %+v", results.Errors)
	}

	// Defensive parsing of response structure
	rawResult, ok := results.Data["Get"].(map[string][]map[string]any)
	if !ok {
		return nil, fmt.Errorf("unexpected structure in Weaviate response: %+v", results.Data)
	}

	rawDocs, ok := rawResult["CommandPalette"]
	if !ok {
		return nil, fmt.Errorf("unexpected CommandPalette format: %+v", rawResult)
	}

	var response []*CommandPallete
	for _, res := range rawDocs {

		response = append(response, &CommandPallete{
			ID:       getString(res, "id"),
			Label:    getString(res, "label"),
			LabelAr:  getString(res, "label_ar"),
			Icon:     getString(res, "icon"),
			Type:     getString(res, "type"),
			URL:      getString(res, "url"),
			TenantID: getInt(res, "tenant_id"),
			Keywords: toStringSlice(res["keywords"]),
		})
	}

	return response, nil
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
