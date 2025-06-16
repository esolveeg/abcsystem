package typesenseclient

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"time"

	"github.com/darwishdev/devkit-api/pkg/contextkeys"
	"github.com/typesense/typesense-go/v3/typesense"
	"github.com/typesense/typesense-go/v3/typesense/api"
)

type TypesenseClientInterface interface {
	UpsertCommandDocument(ctx context.Context , document CommandDocument) error
	SearchCommandPalette(ctx context.Context,  query string, perPage int) ([]CommandDocument, error)
	CreateCommandPaletteCollectionIfNotExists(ctx context.Context) error
}

type CommandDocument struct {
	ID       string   `json:"id"`
	Label    string   `json:"label"`
	LabelAr  string   `json:"label_ar,omitempty"`
	Icon     string   `json:"icon,omitempty"`
	Type     string   `json:"type"`
	URL      string   `json:"url"`
	TenantID int32    `json:"tenant_id"`
	Keywords []string `json:"keywords,omitempty"`
}

type TypesenseClient struct {
	client     *typesense.Client
	isDisabled bool
}

func NewTypesenseClient(host string, port string, protocol string, apiKey string, isDisabled bool) TypesenseClientInterface {

	client := typesense.NewClient(
		typesense.WithServer(fmt.Sprintf("%s://%s:%s", protocol, host, port)),
		typesense.WithAPIKey(apiKey),
		typesense.WithConnectionTimeout(5*time.Second),
		typesense.WithCircuitBreakerMaxRequests(50),
		typesense.WithCircuitBreakerInterval(2*time.Minute),
		typesense.WithCircuitBreakerTimeout(1*time.Minute),
		)

	return &TypesenseClient{
		client:     client,
		isDisabled: isDisabled,
	}
}

func (t *TypesenseClient) CreateCommandPaletteCollectionIfNotExists(ctx context.Context) error {
	if t.isDisabled {
		return nil
	}

	collections, err := t.client.Collections().Retrieve(ctx)
	if err != nil {
		return fmt.Errorf("failed to retrieve collections: %w", err)
	}

	for _, c := range collections {
		if c.Name == "command_palette" {
			return nil // already exists
		}
	}

	trueValue := true
	_, err = t.client.Collections().Create(ctx , &api.CollectionSchema{
		Name: "command_palette",
		Fields: []api.Field{
			{Name: "id", Type: "string"},
			{Name: "label", Type: "string"},
			{Name: "label_ar", Type: "string", Optional: &trueValue},
			{Name: "keywords", Type: "string[]", Optional: &trueValue},
			{Name: "icon", Type: "string", Optional: &trueValue},
			{Name: "type", Type: "string"},
			{Name: "url", Type: "string"},
			{Name: "tenant_id", Type: "int32"},
		},
	})
	if err != nil {
		return fmt.Errorf("failed to create collection: %w", err)
	}

	return nil
}

func (t *TypesenseClient) UpsertCommandDocument(ctx context.Context , document CommandDocument) error {
	if t.isDisabled {
		return nil
	}

	_, err := t.client.
		Collection("command_palette").
		Documents().
		Upsert(ctx , document , nil)
	if err != nil {
		log.Printf("Failed to upsert document %s: %v", document.ID, err)
	}
	return err
}

func mapToStruct(m map[string]interface{}, out interface{}) error {
	b, err := json.Marshal(m)
	if err != nil {
		return err
	}
	return json.Unmarshal(b, out)
}
func (t *TypesenseClient) SearchCommandPalette(ctx context.Context, query string, perPage int) ([]CommandDocument, error) {
	if t.isDisabled {
		return nil, nil
	}

	queryBy := "label,label_ar,keywords"
	filterBy := ""
	tenantID , ok := contextkeys.TenantID(ctx)
	if ok {
		if tenantID > 0 {
			filterBy = fmt.Sprintf("tenant_id=%d", tenantID)
		}
	}
	searchParams := &api.SearchCollectionParams{
		Q:        &query,
		QueryBy:  &queryBy,
		FilterBy: &filterBy,
		PerPage:  &perPage,
	}

	searchResult, err := t.client.
		Collection("command_palette").
		Documents().
		Search(ctx, searchParams)
	if err != nil {
		return nil, fmt.Errorf("typesense search failed: %w", err)
	}

	var results []CommandDocument
	for _, hit := range *searchResult.Hits {
		var doc CommandDocument
		if err := mapToStruct(*hit.Document, &doc); err == nil {
			results = append(results, doc)
		} else {
			log.Printf("Failed to parse search result: %v", err)
		}
	}

	return results, nil
}
