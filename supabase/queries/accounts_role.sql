-- name: RoleList :many
SELECT
	r.role_id,
  r.role_name,
  r.role_security_level,
  is_null_replace(r.tenant_id , 0)::int tenant_id,
  is_null_replace(t.tenant_name , '')::varchar tenant_name,
  is_null_replace(count(rp.*)::int , 0 )::int permission_count,
  is_null_replace(count(ur.*)::int , 0 )::int user_count,
  r.created_at,
  r.updated_at,
  r.deleted_at  
FROM
	accounts_schema.role r 
left join accounts_schema.user_role ur on r.role_id = ur.role_id
left join tenants_schema.tenant t on r.tenant_id = t.tenant_id
left join accounts_schema.role_permission rp on r.role_id = rp.role_id
group by 	r.role_id,
  r.role_name,
  r.tenant_id,
  t.tenant_name,
 r.created_at,
  r.updated_at,
  r.deleted_at  ;

-- name: RoleFindForUpdate :one
WITH permissions AS (
	SELECT
		p.role_id,
		array_agg(p.permission_id)::int[] permissions
	FROM
		accounts_schema.role_permission p
	WHERE
		p.role_id = $1
	GROUP BY
		p.role_id
)
SELECT
	r.role_id,
	r.role_name,
	r.tenant_id,
	r.role_security_level,
	r.role_description,
	p.permissions permissions
FROM
	accounts_schema.role r
	JOIN permissions p ON r.role_id = p.role_id;

-- name: RoleCreateUpdate :one
SELECT
	*
FROM
	accounts_schema.role_create_update (in_role_id => sqlc.arg('role_id'), in_role_name => sqlc.arg('role_name'), in_tenant_id => sqlc.arg('tenant_id'), in_role_security_level => sqlc.arg('role_security_level'), in_caller_id => sqlc.arg('caller_id'), in_role_description => sqlc.arg('role_description'), in_permissions => sqlc.arg('permissions')::int[]);

-- name: RoleDelete :one
SELECT
	*
FROM
	accounts_schema.role_delete (in_role_id => sqlc.arg('role_id'), in_caller_id => sqlc.arg('caller_id'));

-- name: RoleDeleteRestore :one
SELECT
	*
FROM
	accounts_schema.role_delete_restore (in_role_id => sqlc.arg('role_id'), in_caller_id => sqlc.arg('caller_id'));

-- name: RoleListInput :many
SELECT
	role_id value,
	role_name label,
	concat('level: ', role_security_level::varchar)::varchar note
FROM
	accounts_schema.role
WHERE
	role_security_level <= accounts_schema.user_security_level_find (sqlc.arg('caller_id'));

