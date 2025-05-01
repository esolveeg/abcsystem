package db

import (
	"context"

	"github.com/rs/zerolog/log"
)

func (store *SQLStore) StorageFileDelete(ctx context.Context, records []string) (string, error) {
	var response string
	err := store.ExecTX(ctx, func(q *Queries) error {
		_, err := q.db.Exec(ctx, "delete from storage.objects where id = any($1::uuid[])", records)
		if err != nil {
			log.Debug().Interface("err", err).Msg("from StorageFileDelete")
			return err
		}
		return err
	})

	return response, err
}

func (store *SQLStore) StorageFileDeleteByBucket(ctx context.Context, records []string, bucketName string) (string, error) {
	var response string
	err := store.ExecTX(ctx, func(q *Queries) error {
		_, err := q.db.Exec(ctx, "delete from storage.objects where name = any($1) and bucket_id = $2", records, bucketName)
		if err != nil {
			log.Debug().Interface("err", err).Msg("from StorageFileDelete")
			return err
		}
		return err
	})

	return response, err
}
