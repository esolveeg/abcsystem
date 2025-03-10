-- name: LocationList :many
SELECT
	*
FROM
	properties_schema.location;

-- name: LocationListInput :many
SELECT
	location_id value,
	location_name label
FROM
	properties_schema.location
WHERE
	city_id = is_null_replace(sqlc.arg('city_id'), city_id)
AND	city_id = any(is_null_replace(sqlc.arg('city_ids')::int[], Array[city_id]))
	AND deleted_at IS NULL;

