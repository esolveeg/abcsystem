-- name: PartialList :many
SELECT
	*
FROM
	tenants_schema.partial
WHERE
	tenant_id = is_null_replace(sqlc.arg('tenant_id')::int, tenant_id);

-- name: PartialCreateUpdate :one
SELECT
	*
FROM
	tenants_schema.partial_create_update(in_partial_id := sqlc.arg('partial_id'), in_partial_name := sqlc.arg('partial_name'), in_partial_name_ar := sqlc.arg('partial_name_ar'), in_partial_type_id := sqlc.arg('partial_type_id'), in_section_id := sqlc.arg('section_id'), in_partial_image := sqlc.arg('partial_image'), in_partial_images := sqlc.arg('partial_images'), in_partial_video := sqlc.arg('partial_video'), in_is_featured := sqlc.arg('is_featured'), in_partial_brief := sqlc.arg('partial_brief'), in_partial_brief_ar := sqlc.arg('partial_brief_ar'), in_partial_content := sqlc.arg('partial_content'), in_partial_content_ar := sqlc.arg('partial_content_ar'), in_partial_button_label := sqlc.arg('partial_button_label'), in_partial_button_label_ar := sqlc.arg('partial_button_label_ar'), in_partial_button_icon := sqlc.arg('partial_button_icon'), in_partial_button_link := sqlc.arg('partial_button_link'), in_partial_button_page_id := sqlc.arg('partial_button_page_id'), in_partial_icons := sqlc.arg('partial_icons'), in_address := sqlc.arg('address'), in_partial_links := sqlc.arg('partial_links'), in_partial_link := sqlc.arg('partial_link'));

-- name: PartialDeleteRestore :many
UPDATE
	tenants_schema.partial
SET
	deleted_at = iif(deleted_at IS NULL, now(), NULL)
WHERE
	partial_id = ANY (sqlc.arg('records')::int[])
RETURNING
	*;

