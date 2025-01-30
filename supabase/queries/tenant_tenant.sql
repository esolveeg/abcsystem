-- name: TenantCreateUpdate :one
SELECT
	tenant_id,
	tenant_name,
	tenant_name_ar,
	tenant_phone,
	tenant_address,
	tenant_address_ar,
	tenant_description,
	tenant_description_ar,
	tenant_email,
	tenant_logo,
	tenant_logo_vertical,
	tenant_logo_dark,
	tenant_logo_dark_vertical,
	tenant_values,
	tenant_mission,
	tenant_vision,
	created_at,
	updated_at,
	deleted_at
FROM
	tenants_schema.tenant_create_update(in_tenant_id => sqlc.arg('tenant_id'), in_tenant_name => sqlc.arg('tenant_name'), in_tenant_name_ar => sqlc.arg('tenant_name_ar'), in_tenant_phone => sqlc.arg('tenant_phone'), in_tenant_address => sqlc.arg('tenant_address'), in_tenant_address_ar => sqlc.arg('tenant_address_ar'), in_tenant_email => sqlc.arg('tenant_email'), in_tenant_values => sqlc.arg('tenant_values'), in_tenant_mission => sqlc.arg('tenant_mission'), in_tenant_vision => sqlc.arg('tenant_vision'), in_tenant_description => sqlc.arg('tenant_description'), in_tenant_description_ar => sqlc.arg('tenant_description_ar'), in_tenant_logo => sqlc.arg('tenant_logo'), in_tenant_logo_vertical => sqlc.arg('tenant_logo_vertical'), in_tenant_logo_dark => sqlc.arg('tenant_logo_dark'), in_tenant_logo_dark_vertical => sqlc.arg('tenant_logo_dark_vertical'));

-- name: TenantList :many
SELECT
	tenant_id,
	tenant_name,
	tenant_name_ar,
	tenant_phone,
	tenant_address,
	tenant_address_ar,
	tenant_description,
	tenant_description_ar,
	tenant_email,
	tenant_logo,
	tenant_logo_vertical,
	tenant_logo_dark,
	tenant_logo_dark_vertical,
	tenant_values,
	tenant_mission,
	tenant_vision,
	created_at,
	updated_at,
	deleted_at
FROM
	tenants_schema.tenant
WHERE
	tenant_id = is_null_replace(sqlc.arg('tenant_id')::int, tenant_id);

-- name: TenantDeleteRestore :many
UPDATE
	tenants_schema.tenant
SET
	deleted_at = IIF(deleted_at IS NULL, now(), NULL)
WHERE
	tenant_id = ANY (sqlc.arg('records')::int[])
RETURNING
	*;

