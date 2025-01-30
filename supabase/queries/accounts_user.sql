-- name: UserNavigationBarFind :many
WITH RECURSIVE items AS (
	SELECT
		n.navigation_bar_item_id,
		n.menu_key,
		n.label,
		n.label_ar,
		n.icon,
		n."route",
		n.navigation_bar_id,
		n.parent_id,
		n.permission_id,
		1 level
	FROM
		accounts_schema.navigation_bar_item n
	WHERE
		n.parent_id IS NULL
		AND n.navigation_bar_id = sqlc.arg('navigation_bar_id')::int
	UNION
	SELECT
		l2.navigation_bar_item_id,
		l2.menu_key,
		l2.label,
		l2.label_ar,
		l2.icon,
		l2."route",
		l2.navigation_bar_id,
		l2.parent_id,
		l2.permission_id,
		(l1.level + 1)
		level
	FROM
		items l1
		JOIN accounts_schema.navigation_bar_item l2 ON l1.navigation_bar_item_id = l2.parent_id
			AND l2.navigation_bar_id = l1.navigation_bar_id
)
	SELECT
		i.navigation_bar_item_id,
		i.menu_key,
		i.label,
		i.label_ar,
		i.icon,
		i."route",
		i.navigation_bar_id,
		i.parent_id,
		i.permission_id,
		i.level
	FROM
		items i
	LEFT JOIN accounts_schema.user_permissions_list (in_user_id => sqlc.arg('user_id')::int) u ON u.permission_id = i.permission_id
WHERE
	i.permission_id IS NULL
	OR u.permission_id IS NOT NULL
ORDER BY
	level,
	menu_key;

-- name: UserFind :one
SELECT
	*
FROM
	accounts_schema.user
WHERE
	deleted_at IS NULL
	AND (user_email = sqlc.arg('search_key')
		OR user_phone = sqlc.arg('search_key')
		OR user_id = sqlc.arg('user_id'));

-- name: UserList :many
SELECT
	*
FROM
	accounts_schema.user;

-- name: UserCreateUpdate :one
SELECT
	*
FROM
	accounts_schema.user_create_update (in_user_id => sqlc.arg('user_id'), in_user_name => sqlc.arg('user_name'), in_tenant_id => sqlc.arg('tenant_id'), in_caller_id => sqlc.arg('caller_id'), in_user_type_id => sqlc.arg('user_type_id'), in_user_phone => sqlc.arg('user_phone'), in_user_email => sqlc.arg('user_email'), in_user_password => sqlc.arg('user_password'), in_roles => sqlc.arg('roles')::int[]);

-- name: UserFindForUpdate :one
WITH user_roles AS (
	SELECT
		ur.user_id,
		array_agg(ur.role_id)::int[] roles
	FROM
		accounts_schema.user_role ur
	WHERE
		ur.user_id = $1
	GROUP BY
		ur.user_id
)
SELECT
	u.user_id,
	u.user_name,
	u.user_type_id,
	u.user_phone,
	u.tenant_id,
	u.user_email,
	r.roles::int[] roles
FROM
	accounts_schema.user u
	JOIN user_roles r ON u.user_id = r.user_id;

-- name: UserDeleteRestore :one
SELECT
	*
FROM
	accounts_schema.user_delete_restore (in_user_id => sqlc.arg(user_id), in_caller_id => sqlc.arg(caller_id));

-- name: UserPermissionsMap :many
SELECT
	permission_group::varchar(200),
	permissions::jsonb
FROM
	accounts_schema.user_permissions_list_map (in_user_id => sqlc.arg('user_id'));

-- name: UserDelete :one
SELECT
	*
FROM
	accounts_schema.user_delete (in_user_id => sqlc.arg('user_id'), in_caller_id => sqlc.arg('caller_id'));

-- name: UserListInput :many
SELECT
	u.user_id value,
	u.user_name label,
	concat("✉️", u.user_email, "📱", u.user_phone)::varchar note
FROM
	accounts_schema.user u
	JOIN accounts_schema.user_role ur ON u.user_id = ur.user_id
	JOIN accounts_schema.role r ON ur.role_id = r.role_id
		AND r.role_security_level <= accounts_schema.user_security_level_find (sqlc.arg('caller_id'))
GROUP BY
	u.user_id,
	u.user_name,
	u.user_email,
	u.user_phone;

-- name: UserResetPassword :exec
UPDATE
	accounts_schema.user
SET
	user_password = $2
WHERE
	user_email = $1;

