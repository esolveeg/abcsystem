package db

import (
	"time"

	"github.com/jackc/pgx/v5/pgtype"
	"google.golang.org/protobuf/types/known/timestamppb"
)

func StringToPgtext(str string) pgtype.Text {
	return pgtype.Text{String: str, Valid: str != ""}
}
func StringToPgTimestamp(dateString string) pgtype.Timestamp {
	if dateString == "" {
		return pgtype.Timestamp{Valid: false}
	}
	t, err := time.Parse("2006-01-02 15:04:05", dateString)
	if err != nil {
		return pgtype.Timestamp{Valid: false}
	}

	// Create a pgtype.Timestamp from the time.Time object
	pgTimestamp := pgtype.Timestamp{
		Time:  t,
		Valid: true,
	}
	return pgTimestamp
}
func PgtimeToString(pgTime pgtype.Time) string {
	duration := time.Duration(pgTime.Microseconds) * time.Microsecond
	// Convert duration to time.Time
	timeValue := time.Date(0, 1, 1, 0, 0, 0, 0, time.UTC).Add(duration)

	// Format time as "15:04" (24-hour clock format)
	return timeValue.Format("15:04")
}
func TimeToString(time time.Time) string {
	return time.Format("2006-01-02 15:04:05")
}
func TimeToProtoTimeStamp(time time.Time) *timestamppb.Timestamp {
	return timestamppb.New(time)
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

func ToPgBool(value bool) pgtype.Bool {
	return pgtype.Bool{Bool: value, Valid: true}
}
func ToPgInt(value int32) pgtype.Int4 {
	return pgtype.Int4{Int32: value, Valid: true}
}
func ToPgFloat(value float32) pgtype.Float4 {
	return pgtype.Float4{Float32: value, Valid: true}
}
