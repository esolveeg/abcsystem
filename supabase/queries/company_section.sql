-- name: SectionList :many
SELECT
	*
FROM
	companies_schema.section;

-- name: SectionCreateUpdate :one
SELECT
	*
FROM
	companies_schema.section_create_update(in_section_id := sqlc.arg('section_id'), in_section_name := sqlc.arg('section_name'), in_section_name_ar := sqlc.arg('section_name_ar'), in_section_description := sqlc.arg('section_description'), in_section_description_ar := sqlc.arg('section_description_ar'), in_company_id := sqlc.arg('company_id'), in_section_background := sqlc.arg('section_background'), in_section_images := sqlc.arg('section_images'), in_section_icon := sqlc.arg('section_icon'));

-- name: SectionDeleteRestore :many
UPDATE
	companies_schema.section
SET
	deleted_at = iif(deleted_at IS NULL, now(), NULL)
WHERE
	section_id = ANY (sqlc.arg('records')::int[])
RETURNING
	*;

