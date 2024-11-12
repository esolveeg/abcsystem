
-- name: RoleList :many
select  
	role_id ,
	role_name ,
	role_security_level ,
	role_description ,
	created_at ,
	updated_at ,
	deleted_at 

from accounts_schema.role;
-- name: RoleCreateUpdate :one
select  
	role_id ,
	role_name ,
	role_security_level ,
	role_description ,
	created_at ,
	updated_at ,
	deleted_at  from accounts_schema.role_create_update(
in_role_id => sqlc.arg('role_id'),
in_role_name => sqlc.arg('role_name'),
in_role_security_level => sqlc.arg('role_security_level'),
in_caller_id => sqlc.arg('called_by_user_id'),
in_role_description => sqlc.arg('role_description'),
in_permissions => sqlc.arg('permissions')::int[]
);
-- name: RoleDeleteRestore :exec
UPDATE
accounts_schema.role
SET
deleted_at = IIF(deleted_at IS NULL, now(), NULL)
WHERE
role_id = ANY (sqlc.arg('records')::int[]);

-- name: RoleListInput :many
select 
role_id record_id,
role_name label
from accounts_schema.role 
where 
role_security_level <= accounts_schema.user_security_level_find(sqlc.arg('caller_id'));
