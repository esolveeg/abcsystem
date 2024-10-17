
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

