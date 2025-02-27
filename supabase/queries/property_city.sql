-- name: CityList :many
SELECT
	*
FROM
	properties_schema.city;

-- name: CityListInput :many
SELECT
	city_id value,
	city_name label
FROM
	properties_schema.city
WHERE
	deleted_at IS NULL;

