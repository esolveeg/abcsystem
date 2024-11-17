
-- name: CompanyCreateUpdate :one
select  
	company_id ,
	company_name ,
	company_name_ar ,
	company_phone ,
	company_address ,
	company_address_ar ,
	company_description ,
	company_description_ar ,
	company_email ,
	company_logo ,
	company_logo_vertical ,
	company_logo_dark ,
	company_logo_dark_vertical ,
	company_values ,
	company_mission ,
	company_vision ,
	created_at ,
	updated_at ,
	deleted_at 
from companies_schema.company_create_update(
in_company_id => sqlc.arg('company_id'),
in_company_name => sqlc.arg('company_name'),
in_company_name_ar => sqlc.arg('company_name_ar'),
in_company_phone => sqlc.arg('company_phone'),
in_company_address => sqlc.arg('company_address'),
in_company_address_ar => sqlc.arg('company_address_ar'),
in_company_email => sqlc.arg('company_email'),
in_company_values  => sqlc.arg('company_values'), 
in_company_mission => sqlc.arg('company_mission'),
in_company_vision => sqlc.arg('company_vision'), 
in_company_description => sqlc.arg('company_description'),
in_company_description_ar => sqlc.arg('company_description_ar'),
in_company_logo => sqlc.arg('company_logo'),
in_company_logo_vertical => sqlc.arg('company_logo_vertical'),
in_company_logo_dark => sqlc.arg('company_logo_dark'),
in_company_logo_dark_vertical => sqlc.arg('company_logo_dark_vertical')
);

-- name: CompanyList :many
select 
	company_id ,
	company_name ,
	company_name_ar ,
	company_phone ,
	company_address ,
	company_address_ar ,
	company_description ,
	company_description_ar ,
	company_email ,
	company_logo ,
	company_logo_vertical ,
	company_logo_dark ,
	company_logo_dark_vertical ,
	company_values ,
	company_mission ,
	company_vision ,
	created_at ,
	updated_at ,
	deleted_at 
from companies_schema.company;

-- name: CompanyDeleteRestore :many
UPDATE
    companies_schema.company
SET
    deleted_at = IIF(deleted_at IS NULL, now(), NULL)
WHERE
    company_id = ANY (sqlc.arg('records')::int[]) RETURNING *;

