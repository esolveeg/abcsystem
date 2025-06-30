package db

import (
	"errors"
	"fmt"

	"connectrpc.com/connect"
	"github.com/jackc/pgx/v5/pgconn"

	errdetails "google.golang.org/genproto/googleapis/rpc/errdetails"
)

const (
	ForeignKeyViolation = "23503"
	NoData              = "02000"
	UniqueViolation     = "23505"
	InvalidInputSyntax  = "22P02"
)

// type ErrorHandlerDB struct {

// ConstraintName string
// FieldName      string
// }
func addBadRequestDetail(cErr *connect.Error, br *errdetails.BadRequest) {
	if br == nil {
		return
	}
	if detail, derr := connect.NewErrorDetail(br); derr == nil {
		cErr.AddDetail(detail)
	}
}

func brSingle(field, msg string) *errdetails.BadRequest {
	return &errdetails.BadRequest{
		FieldViolations: []*errdetails.BadRequest_FieldViolation{{
			Field:       field,
			Description: msg,
		}},
	}
}
func (store *SQLStore) DbErrorParser(err error, errorHandler map[string]string) *connect.Error {
	if err == nil {
		return nil
	}
	var pgErr *pgconn.PgError
	if err.Error() == "no rows in result set" {
		cErr := connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("no_data_found"))
		addBadRequestDetail(cErr, brSingle("", "No data found"))
		return cErr
	}

	if errors.As(err, &pgErr) {
		// Check for custom exception raised by RAISE EXCEPTION in PostgreSQL
		if pgErr.Code == "P0001" { // Custom SQLSTATE from RAISE EXCEPTION
			cErr := connect.NewError(connect.CodeInvalidArgument, errors.New(pgErr.Message))
			addBadRequestDetail(cErr, brSingle("", pgErr.Message))
			return cErr
		}
		field := errorHandler[pgErr.ConstraintName]
		if field == "" {
			field = pgErr.ConstraintName // fallback
		}

		switch pgErr.Code {
		case UniqueViolation: // 23505
			cErr := connect.NewError(connect.CodeAlreadyExists,
				fmt.Errorf("duplicate value for %s", field))
			addBadRequestDetail(cErr, brSingle(field, "value already exists"))
			return cErr
		case ForeignKeyViolation: // 23503
			cErr := connect.NewError(connect.CodeInvalidArgument, fmt.Errorf(field))
			addBadRequestDetail(cErr, brSingle(field, "invalid reference"))
			return cErr

		case InvalidInputSyntax: // 22P02
			cErr := connect.NewError(connect.CodeInvalidArgument, errors.New(pgErr.Message))
			addBadRequestDetail(cErr, brSingle(field, pgErr.Message))
			return cErr

		case NoData: // 02000
			cErr := connect.NewError(connect.CodeInvalidArgument, fmt.Errorf(field))
			addBadRequestDetail(cErr, brSingle(field, "no data"))
			return cErr
		}
	}

	return connect.NewError(connect.CodeInternal, fmt.Errorf(err.Error()))

}
