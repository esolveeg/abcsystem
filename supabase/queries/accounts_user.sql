
-- name: UserFind :one
SELECT
    user_id,
    user_name,
    user_security_level,
    user_type_id,
    user_phone,
    user_email,
    user_password,
    created_at,
    updated_at,
    deleted_at
FROM
    accounts_schema.users
WHERE deleted_at is null and (
    user_email = sqlc.arg('search_key')
    OR user_phone = sqlc.arg('search_key')
    OR user_id = sqlc.arg('user_id'));
-- name: UsersList :many
SELECT  
    user_id,
    user_name,
    user_security_level,
    user_type_id,
    user_phone,
    user_email,
    user_password,
    created_at,
    updated_at,
    deleted_at
FROM accounts_schema.users;

-- name: UserCreateUpdate :one
SELECT  
    user_id,
    user_name,
    user_security_level,
    user_type_id,
    user_phone,
    user_email,
    user_password,
    created_at,
    updated_at,
    deleted_at
FROM accounts_schema.user_create_update(
    in_user_id => sqlc.arg('user_id'),
    in_user_name => sqlc.arg('user_name'),
    in_user_security_level => sqlc.arg('user_security_level'),
    in_user_type_id => sqlc.arg('user_type_id'),
    in_user_phone => sqlc.arg('user_phone'),
    in_user_email => sqlc.arg('user_email'),
    in_user_password => sqlc.arg('user_password'),
    in_roles => sqlc.arg('roles')::int[]
);

-- name: UsersDeleteRestore :exec
UPDATE
    accounts_schema.users
SET
    deleted_at = IIF(deleted_at IS NULL, now(), NULL)
WHERE
    user_id = ANY (sqlc.arg('records')::int[]);

-- name: UserPermissionsMap :one
SELECT jsonb_object_agg(permission_group, permissions)
FROM (
    SELECT
        p.permission_group,
        jsonb_object_agg(p.permission_function, true) as permissions
    FROM
        accounts_schema.user_roles ur
    JOIN accounts_schema.role_permissions rp ON rp.role_id = ur.role_id
    JOIN accounts_schema.permissions p ON p.permission_id = rp.permission_id
    where ur.user_id = $1
    GROUP BY p.permission_group
) as permissions_by_group;

-- name: UserFindNavigationBars :many
WITH userpermissions AS (
  SELECT 
    rp.permission_id
  FROM 
    accounts_schema.role_permissions rp
    join accounts_schema.roles r  on rp.role_id = r.role_id 
    join accounts_schema.user_roles ur on r.role_id = ur.role_id
    where ur.user_id = $1
)
, allowed_navigations as (
    SELECT
        navigation_bar_id,
        menu_key "key",
        label,
        label_ar,
        icon,
        "route",
        menu_key,
        parent_id
        from accounts_schema.navigation_bars n
        JOIN userpermissions p on n.permission_id = p.permission_id 
    union 
    SELECT
        navigation_bar_id,
        menu_key "key",
        label,
        label_ar,
        icon,
        "route",
        menu_key,
        parent_id
        from accounts_schema.navigation_bars n 
        where n.permission_id is null
    ORDER BY
        menu_key
) , children_permissions as (
    select * from allowed_navigations where parent_id is not null
) select 
p.navigation_bar_id,
p.menu_key "key",
p.label,
p.label_ar,
p.icon,
p."route",
(
    select Jsonb_Agg(nested_items) from (
        select c.* from children_permissions c where 
        c.parent_id = p.navigation_bar_id
    ) nested_items
) items
from allowed_navigations p where route is null or parent_id is null order by p.navigation_bar_id;

-- name: UserDelete :one
SELECT * FROM accounts_schema.user_delete(sqlc.arg('user_id'));




