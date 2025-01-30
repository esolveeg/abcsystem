-- name: RoleList :many
SELECT
	role_id::int,
	role_name::varchar(200),
	role_description::varchar(200),
	created_at::timestamptz,
	total_count::bigint
FROM
	execute_dynamic_pagination (primary_key => 'role_id', query_base => CONCAT(FORMAT('SELECT role_id, role_name,role_description, created_at
             FROM accounts_schema.role
             WHERE role_name LIKE CONCAT(''%%'', %L, ''%%'')
               AND role_description LIKE CONCAT(''%%'', %L, ''%%'')
AND deleted_at IS ', @in_role_name::varchar(200), @in_role_description::text),  iif(@in_is_deleted::boolean , 'not null'::varchar , 'null'::varchar)), sort_func => @sort_function, page_number => @page_number, -- Page number
		sort_column => is_null_replace(@sort_column::varchar, 'role_id'), page_size => @page_size) AS result (role_id int,
		role_name varchar(200),
		role_description varchar(200),
		created_at timestamptz,
		total_count bigint);

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
	concat("level: ", role_security_level::varchar)::varchar note
FROM
	accounts_schema.role
WHERE
	role_security_level <= accounts_schema.user_security_level_find (sqlc.arg('caller_id'));

