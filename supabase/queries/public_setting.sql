-- name: SettingsUpdate :one
SELECT
FROM
    settings_bulk_create(sqlc.arg('keys')::text[], sqlc.arg('values')::text[]);

-- name: SettingsFindForUpdate :many
SELECT
    setting_value,
    setting_key,
    input_type_name
FROM
    settings s
    JOIN input_types t ON t.input_type_id = s.input_type_id;

 


