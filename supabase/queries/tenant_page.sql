-- name: PageList :many
SELECT
	*
FROM
	tenants_schema.page
WHERE
	tenant_id = is_null_replace(sqlc.arg('tenant_id')::int, tenant_id);

-- name: PageCreateUpdate :one
SELECT
	page_id,
	page_name,
	page_name_ar,
	page_description,
	page_description_ar,
	page_breadcrumb,
	tenant_id,
	page_route,
	page_cover_image,
	page_cover_video,
	page_key_words,
	page_meta_description,
	page_icon,
	created_at,
	updated_at,
	deleted_at
FROM
	tenants_schema.page_create_update(in_page_id := sqlc.arg('page_id'), in_page_name := sqlc.arg('page_name'), in_page_name_ar := sqlc.arg('page_name_ar'), in_page_description := sqlc.arg('page_description'), in_page_description_ar := sqlc.arg('page_description_ar'), in_page_breadcrumb := sqlc.arg('page_breadcrumb'), in_tenant_id := sqlc.arg('tenant_id'), in_page_route := sqlc.arg('page_route'), in_page_cover_image := sqlc.arg('page_cover_image'), in_page_cover_video := sqlc.arg('page_cover_video'), in_page_key_words := sqlc.arg('page_key_words'), in_page_meta_description := sqlc.arg('page_meta_description'), in_page_icon := sqlc.arg('page_icon'));

-- name: PageDeleteRestore :many
UPDATE
	tenants_schema.page
SET
	deleted_at = IIF(deleted_at IS NULL, now(), NULL)
WHERE
	page_id = ANY (sqlc.arg('records')::int[])
RETURNING
	*;

