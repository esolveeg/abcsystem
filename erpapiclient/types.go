package erpapiclient

// Envelope matches /api/resource responses: {"data": {...}}
type Envelope[T any] struct {
	Data T `json:"data"`
}

// EnvelopeSlice matches list responses: {"data": [ ... ]}
type EnvelopeSlice[T any] struct {
	Data []T `json:"data"`
}
