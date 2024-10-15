
-- name: RoleCreate :one
select  
	role_id ,
	role_name ,
	role_description ,
	created_at ,
	updated_at ,
	deleted_at from accounts_schema.role_create(

in_role_name => sqlc.arg('role_name'),
in_role_description => sqlc.arg('role_description'),
in_permissions => sqlc.arg('permissions')::int[]
);
