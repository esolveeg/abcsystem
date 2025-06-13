package db

import (
	"context"
)

func (store *SQLStore) AuthUserIDFindByEmail(ctx context.Context, email string) (string, error) {
	var response string
	err := store.ExecTX(ctx, func(q *Queries) error {
		err := q.db.QueryRow(ctx, "SELECT id FROM auth.users WHERE email = $1", email).Scan(&response)
		if err != nil {
			return err
		}

		return err
	})

	return response, err
}
