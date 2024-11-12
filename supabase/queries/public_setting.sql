-- name: SettingUpdate :one
SELECT
FROM
    setting_update(sqlc.arg('keys')::text[], sqlc.arg('values')::text[]);

-- name: SettingFindForUpdate :many
SELECT
    setting_value,
    setting_key,
    input_type_name
FROM
    setting s
    JOIN input_type t ON t.input_type_id = s.input_type_id;

 


