-- name: IconCreateUpdateBulk :many
SELECT
	icon_id,
	icon_name,
	icon_content
FROM
	icon_create_update_bulk (sqlc.arg (icons_names)::text[], sqlc.arg (icons_contents)::text[]);

-- name: IconList :many
SELECT
	icon_id,
	icon_name,
	icon_content
FROM
	icon;

