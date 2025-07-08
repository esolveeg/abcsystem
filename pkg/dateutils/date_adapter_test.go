package dateutils

import (
	"testing"
	"time"
)
func TestDateToStringdigit_Zero(t *testing.T) {
	// Zero time should return empty string
	var t0 time.Time
	got := DateToStringdigit(t0)
	if got != "" {
		t.Errorf("DateToStringdigit(zero) = %q; want empty string", got)
	}
}

func TestDateToStringdigit_Valid(t *testing.T) {
	// Given a time in a non-UTC zone
	loc, err := time.LoadLocation("Asia/Cairo") // UTC+2
	if err != nil {
		t.Fatalf("failed to load location: %v", err)
	}
	t0 := time.Date(2025, time.June, 20, 23, 45, 12, 0, loc)
	// Expect date in UTC, formatted as YYYYMMDD
	got := DateToStringdigit(t0)
	want := "20250620"
	if got != want {
		t.Errorf("DateToStringdigit(%v) = %q; want %q", t0, got, want)
	}
}

func TestDateTimeToStringDigit_Zero(t *testing.T) {
	// Zero time should return empty string
	var t0 time.Time
	got := DateTimeToStringDigit(t0)
	if got != "" {
		t.Errorf("DateTimeToStringDigit(zero) = %q; want empty string", got)
	}
}

func TestDateTimeToStringDigit_Valid(t *testing.T) {
	// Given a time in a non-UTC zone (e.g., New York UTC-5)
	loc, err := time.LoadLocation("America/New_York")
	if err != nil {
		t.Fatalf("failed to load location: %v", err)
	}
	t0 := time.Date(2025, time.December, 31, 23, 59, 0, 0, loc)
	// Expect datetime in UTC, formatted as YYYYMMDDHHmm
	want := t0.UTC().Format("200601021504")
	got := DateTimeToStringDigit(t0)
	if got != want {
		t.Errorf("DateTimeToStringDigit(%v) = %q; want %q", t0, got, want)
	}
}
