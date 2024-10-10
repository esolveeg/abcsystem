
-- name: RoleCreate :one
INSERT INTO accounts_schema.roles(role_name, role_description)
    VALUES ($1, $2)
RETURNING
    *;
