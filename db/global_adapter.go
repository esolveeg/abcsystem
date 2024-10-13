package db

import (
	"time"

	"github.com/jackc/pgx/v5/pgtype"
	"github.com/rs/zerolog/log"
)

func StringToPgtext(str string) pgtype.Text {
	return pgtype.Text{String: str, Valid: str != ""}
}

func PgtimToString(pgTime pgtype.Time) string {
	duration := time.Duration(pgTime.Microseconds) * time.Microsecond
	// Convert duration to time.Time
	timeValue := time.Date(0, 1, 1, 0, 0, 0, 0, time.UTC).Add(duration)

	// Format time as "15:04" (24-hour clock format)
	return timeValue.Format("15:04")
}

func StringToPgdate(strDate string) pgtype.Date {
	parsedTime, _ := time.Parse("2006-01-02", strDate)
	year, month, day := parsedTime.Date()
	// Create pgtype.Date
	pgDate := pgtype.Date{
		Time:  time.Date(year, month, day, 0, 0, 0, 0, time.UTC),
		Valid: true,
	}
	return pgDate
}

func StringToPgTimestamp(dateString string) pgtype.Timestamp {
	// Step 1: Parse the string into a time.Time
	parsedTime, err := time.Parse("1/2/2006, 3:04:05 PM", dateString)
	if err != nil {
		log.Err(err).Msg("error parsing the date db/global_adapter")
		return pgtype.Timestamp{Valid: false}
	}

	// Step 2: Create a pgtype.Timestamp using the parsed time
	pgTimestamp := pgtype.Timestamp{Time: parsedTime, Valid: true}
	return pgTimestamp
}

func ToPgBool(value bool) pgtype.Bool {
	return pgtype.Bool{Bool: value, Valid: true}
}
func ToPgInt(value int32) pgtype.Int4 {
	return pgtype.Int4{Int32: value, Valid: true}
}
func ToPgFloat(value float32) pgtype.Float4 {
	return pgtype.Float4{Float32: value, Valid: true}
}
