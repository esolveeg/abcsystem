-- name: TranslationsCreateUpdateBulk :many
SELECT translation_key , english_value , arabic_value FROM
    translations_create_update_bulk(sqlc.arg('keys')::text[], sqlc.arg('english_values')::text[] , sqlc.arg('arabic_values')::text[]);



-- name: TranslationsList :many
SELECT 
    translation_key,
    arabic_value ,
    english_value 
FROM
translations;


-- name: TranslationsDelete :many
DELETE FROM translations where translation_key = any(sqlc.arg('keys')::text[]) RETURNING *;


