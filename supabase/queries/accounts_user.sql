-- name: UserNavigationBarFind :many
with recursive items as (
  select 
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
    from accounts_schema.navigation_bar_item n where n.parent_id is null and n.navigation_bar_id  = sqlc.arg('navigation_bar_id')::int
 union 
 select 
    l2.navigation_bar_item_id,
    l2.menu_key,
    l2.label,
    l2.label_ar,
    l2.icon,
    l2."route",
    l2.navigation_bar_id,
    l2.parent_id,
    l2.permission_id,
    (l1.level + 1) level
 from items l1 join accounts_schema.navigation_bar_item l2 on l1.navigation_bar_item_id = l2.parent_id and l2.navigation_bar_id = l1.navigation_bar_id 
) select  
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
from items i 
left join accounts_schema.user_permissions_list(in_user_id => sqlc.arg('user_id')::int) u on u.permission_id = i.permission_id 
where i.permission_id is null or u.permission_id is not null
order by 
level,
menu_key;

-- name: UserFind :one
SELECT
    user_id,
    user_name,
    user_type_id,
    user_phone,
    user_email,
    user_password,
    created_at,
    updated_at,
    deleted_at
FROM
    accounts_schema.user
WHERE deleted_at is null and (
    user_email = sqlc.arg('search_key')
    OR user_phone = sqlc.arg('search_key')
    OR user_id = sqlc.arg('user_id'));
-- name: UserList :many
SELECT  
    user_id,
    user_name,
    user_type_id,
    user_phone,
    user_email,
    user_password,
    created_at,
    updated_at,
    deleted_at
FROM accounts_schema.user;

-- name: UserCreateUpdate :one
SELECT  
    user_id,
    user_name,
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
    in_caller_id => sqlc.arg('caller_id'),
    in_user_type_id => sqlc.arg('user_type_id'),
    in_user_phone => sqlc.arg('user_phone'),
    in_user_email => sqlc.arg('user_email'),
    in_user_password => sqlc.arg('user_password'),
    in_roles => sqlc.arg('roles')::int[]
);
-- name: UserFindForUpdate :one
with user_roles as (
    select ur.user_id , array_agg(ur.role_id)::int[] roles from accounts_schema.user_role ur where ur.user_id = $1 group by ur.user_id
)
select 
    u.user_id,
    u.user_name,
    u.user_type_id,
    u.user_phone,
    u.user_email, 
    r.roles::int[] roles
from accounts_schema.user u
join user_roles r on u.user_id = r.user_id;

-- name: UserDeleteRestore :one
SELECT user_id,
    user_name,
    user_type_id,
    user_phone,
    user_email,
    user_password,
    created_at,
    updated_at,
    deleted_at FROM accounts_schema.user_delete_restore(in_user_id => sqlc.arg(user_id) , in_caller_id => sqlc.arg(caller_id));

-- name: UserPermissionsMap :many
select permission_group::varchar(200), permissions::jsonb from accounts_schema.user_permissions_list_map(in_user_id => sqlc.arg('user_id'));


-- name: UserDelete :one
SELECT 
    user_id,
    user_name,
    user_type_id,
    user_phone,
    user_email,
    user_password,
    created_at,
    updated_at,
    deleted_at
    FROM accounts_schema.user_delete(in_user_id => sqlc.arg('user_id'), in_caller_id => sqlc.arg('caller_id'));

-- name: UserListInput :many
select 
  u.user_id value,
  u.user_name label,
  concat("✉️" , u.user_email ,"📱" , u.user_phone)::varchar note
  from accounts_schema.user u 
  join accounts_schema.user_role ur on u.user_id = ur.user_id
  join accounts_schema.role r on ur.role_id = r.role_id and r.role_security_level <= accounts_schema.user_security_level_find(sqlc.arg('caller_id'))
  group by 
  u.user_id ,
  u.user_name ,
  u.user_email ,
  u.user_phone;

 
-- name: UserResetPassword :exec
UPDATE
    accounts_schema.user
SET
    user_password = $2
WHERE
    user_email = $1;

