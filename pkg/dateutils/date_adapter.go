package dateutils

import "time"

// DateToString returns "YYYYMMDD" (e.g. "20250620").
func DateToStringdigit(t time.Time) string {
	if t.IsZero() {
		return ""
	}
	return t.UTC().Format("20060102")
}

// DateTimeToString returns "YYYYMMDDHHmm" (e.g. "202506201215").
func DateTimeToStringDigit(t time.Time) string {
	if t.IsZero() {
		return ""
	}
	return t.UTC().Format("200601021504")
}
