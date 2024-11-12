-- name: TranslationCreateUpdateBulk :many
SELECT translation_key , english_value , arabic_value FROM
    translation_create_update_bulk(sqlc.arg('keys')::text[], sqlc.arg('english_values')::text[] , sqlc.arg('arabic_values')::text[]);



-- name: TranslationList :many
SELECT 
    translation_key,
    arabic_value ,
    english_value 
FROM
translation;


-- name: TranslationDelete :many
DELETE FROM translation where translation_key = any(sqlc.arg('keys')::text[]) RETURNING *;


