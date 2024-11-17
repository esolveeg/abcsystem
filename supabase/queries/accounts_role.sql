
-- name: RoleList :many
select  
	*

from accounts_schema.role;
-- name: RoleFindForUpdate :one
with permissions as (
	select p.role_id , array_agg(p.permission_id)::int[] permissions from accounts_schema.role_permission p where p.role_id = $1 group by p.role_id
)
select  
r.role_id ,
r.role_name ,
r.company_id,
r.role_security_level ,
r.role_description ,
p.permissions permissions
	from accounts_schema.role r
 join permissions p 
on r.role_id = p.role_id;


-- name: RoleCreateUpdate :one
select  
	*
from accounts_schema.role_create_update(
in_role_id => sqlc.arg('role_id'),
in_role_name => sqlc.arg('role_name'),
in_company_id => sqlc.arg('company_id'),
in_role_security_level => sqlc.arg('role_security_level'),
in_caller_id => sqlc.arg('caller_id'),
in_role_description => sqlc.arg('role_description'),
in_permissions => sqlc.arg('permissions')::int[]
);

-- name: RoleDelete :one
SELECT 
	*
FROM accounts_schema.role_delete(in_role_id => sqlc.arg('role_id') , in_caller_id => sqlc.arg('caller_id'));


-- name: RoleDeleteRestore :one
SELECT 
	*  
FROM accounts_schema.role_delete_restore(in_role_id => sqlc.arg('role_id') , in_caller_id => sqlc.arg('caller_id'));

-- name: RoleListInput :many
select 
role_id value,
role_name label,
concat("level: " , role_security_level::varchar)::varchar note
from accounts_schema.role 
where 
role_security_level <= accounts_schema.user_security_level_find(sqlc.arg('caller_id'));
