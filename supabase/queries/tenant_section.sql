-- name: SectionList :many
SELECT
	*
FROM
	tenants_schema.section
WHERE
	tenant_id = is_null_replace(sqlc.arg('tenant_id')::int, tenant_id);

-- name: SectionCreateUpdate :one
SELECT
	*
FROM
	tenants_schema.section_create_update(in_section_id := sqlc.arg('section_id'), in_section_name := sqlc.arg('section_name'), in_section_name_ar := sqlc.arg('section_name_ar'), in_section_header := sqlc.arg('section_header'), in_section_header_ar := sqlc.arg('section_header_ar'), in_section_button_label := sqlc.arg('section_button_label'), in_section_button_label_ar := sqlc.arg('section_button_label_ar'), in_section_button_page_id := sqlc.arg('section_button_page_id'), in_section_description := sqlc.arg('section_description'), in_section_description_ar := sqlc.arg('section_description_ar'), in_tenant_id := sqlc.arg('tenant_id'), in_section_background := sqlc.arg('section_background'), in_section_images := sqlc.arg('section_images'), in_section_icon := sqlc.arg('section_icon'));

-- name: SectionDeleteRestore :many
UPDATE
	tenants_schema.section
SET
	deleted_at = iif(deleted_at IS NULL, now(), NULL)
WHERE
	section_id = ANY (sqlc.arg('records')::int[])
RETURNING
	*;

