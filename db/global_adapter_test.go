package db

import (
	"testing"
	"time"

	"github.com/jackc/pgx/v5/pgtype"
)

func TestStringToPgtext(t *testing.T) {
	tests := []struct {
		input    string
		expected pgtype.Text
	}{
		{"hello", pgtype.Text{String: "hello", Valid: true}},
		{"", pgtype.Text{String: "", Valid: false}},
	}

	for _, tt := range tests {
		result := StringToPgtext(tt.input)
		if result != tt.expected {
			t.Errorf("StringToPgtext(%v) got %v, want %v", tt.input, result, tt.expected)
		}
	}
}

func TestPgtimToString(t *testing.T) {
	tests := []struct {
		input    pgtype.Time
		expected string
	}{
		{pgtype.Time{Microseconds: 3600000000, Valid: true}, "01:00"},
		{pgtype.Time{Microseconds: 0, Valid: true}, "00:00"},
	}

	for _, tt := range tests {
		result := PgtimToString(tt.input)
		if result != tt.expected {
			t.Errorf("PgtimToString(%v) got %v, want %v", tt.input, result, tt.expected)
		}
	}
}

func TestStringToPgdate(t *testing.T) {
	tests := []struct {
		input    string
		expected pgtype.Date
	}{
		{"2023-10-01", pgtype.Date{Time: time.Date(2023, 10, 1, 0, 0, 0, 0, time.UTC), Valid: true}},
		{"2000-01-01", pgtype.Date{Time: time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC), Valid: true}},
	}

	for _, tt := range tests {
		result := StringToPgdate(tt.input)
		if result.Time != tt.expected.Time || result.Valid != tt.expected.Valid {
			t.Errorf("StringToPgdate(%v) got %v, want %v", tt.input, result, tt.expected)
		}
	}
}

func TestToPgBool(t *testing.T) {
	tests := []struct {
		input    bool
		expected pgtype.Bool
	}{
		{true, pgtype.Bool{Bool: true, Valid: true}},
		{false, pgtype.Bool{Bool: false, Valid: true}},
	}

	for _, tt := range tests {
		result := ToPgBool(tt.input)
		if result != tt.expected {
			t.Errorf("ToPgBool(%v) got %v, want %v", tt.input, result, tt.expected)
		}
	}
}

func TestToPgInt(t *testing.T) {
	tests := []struct {
		input    int32
		expected pgtype.Int4
	}{
		{123, pgtype.Int4{Int32: 123, Valid: true}},
		{-123, pgtype.Int4{Int32: -123, Valid: true}},
	}

	for _, tt := range tests {
		result := ToPgInt(tt.input)
		if result != tt.expected {
			t.Errorf("ToPgInt(%v) got %v, want %v", tt.input, result, tt.expected)
		}
	}
}

func TestToPgFloat(t *testing.T) {
	tests := []struct {
		input    float32
		expected pgtype.Float4
	}{
		{1.23, pgtype.Float4{Float32: 1.23, Valid: true}},
		{-1.23, pgtype.Float4{Float32: -1.23, Valid: true}},
	}

	for _, tt := range tests {
		result := ToPgFloat(tt.input)
		if result != tt.expected {
			t.Errorf("ToPgFloat(%v) got %v, want %v", tt.input, result, tt.expected)
		}
	}
}
