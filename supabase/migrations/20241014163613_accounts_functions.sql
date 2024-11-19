--This function retrieves a list of permissions for a specific user (in_user_id)
-- by joining several tables: role_permission, role, user_role, and permission.
--It returns a table with columns: permission_id, permission_group, and permission_function.
CREATE OR REPLACE FUNCTION accounts_schema.user_permissions_list (in_user_id int)
	RETURNS TABLE (
		permission_id int,
		permission_group varchar(200),
		permission_function varchar(200))
	LANGUAGE plpgsql
	AS $$
BEGIN
	RETURN query
	SELECT
		rp.permission_id,
		p.permission_group,
		p.permission_function
	FROM
		accounts_schema.role_permission rp
		JOIN accounts_schema.role r ON rp.role_id = r.role_id
		JOIN accounts_schema.user_role ur ON r.role_id = ur.role_id
		JOIN accounts_schema.permission p ON rp.permission_id = p.permission_id
	WHERE
		ur.user_id = in_user_id;
END
$$;

-- This function groups the permissions for a user into permission groups and returns a JSONB object
-- where the keys are permission_function, and the value is always true.
-- this endpoint result will be cached to be able to access the accessebility of certain user to a certain permission on O(1) constant time
CREATE OR REPLACE FUNCTION accounts_schema.user_permissions_list_map (in_user_id int)
	RETURNS TABLE (
		permission_group varchar(200),
		permissions jsonb)
	LANGUAGE plpgsql
	AS $$
BEGIN
	RETURN query
	SELECT
		p.permission_group,
		jsonb_object_agg(p.permission_function, TRUE) AS permissions
	FROM
		accounts_schema.user_permissions_list (in_user_id) p
GROUP BY
	p.permission_group;
END
$$;

-- Function: accounts_schema.permissions_populate
--
-- Purpose:
-- This function populates the `permission` table in the `accounts_schema` schema with predefined permissions for each table
-- in the schema, based on possible actions (create, update, delete, restore, find). It generates permission names,
-- descriptions, function names, and groups dynamically for each table that has a single primary key column (excluding
-- tables with duplicate primary keys).
--
-- Logic Overview:
-- 1. Defines a set of available actions (`create`, `update`, `delete_restore`, `delete`, `find`).
-- 2. Identifies tables in the schema that have a primary key and excludes tables that have duplicate primary keys which is bridge tables like role_permission or user_role.
-- 3. For each eligible table, generates permission entries (name, description, function, group) based on the table name
--    and available actions.
-- 4. Inserts the generated permissions into the `permission` table in the `accounts_schema`.
-- 5. Returns all the permissions from the `permission` table after insertion.
--
-- The generated permission entries are named following a snake_case convention and are mapped to a camelCase function name.
-- Each permission also includes a description that follows the format "permission_to_<action>_on_table_<table_name>"
-- and a group based on the table name.
CREATE OR REPLACE FUNCTION accounts_schema.permissions_populate (execluded_tables varchar[], added_tables varchar[])
	RETURNS SETOF accounts_schema.permission
	LANGUAGE plpgsql
	AS $$
BEGIN
	WITH added_tables_prepared AS (
		SELECT
			unnest(added_tables) full_table_name
),
tables_to_add AS (
	SELECT
		split_part(full_table_name, '.', 1) table_schema,
	split_part(full_table_name, '.', 2) table_name
FROM
	added_tables_prepared
),
available_actions AS (
	SELECT
		unnest(ARRAY['list', 'create', 'update', 'delete_restore', 'delete', 'find']) action_name
),
primary_keys AS (
	SELECT
		tc.table_schema,
		tc.table_name,
		kcu.column_name AS primary_key_column
	FROM
		information_schema.table_constraints AS tc
		JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
			AND tc.table_schema = kcu.table_schema
	WHERE (tc.table_schema LIKE '%_schema'
		OR tc.table_schema = 'public')
	AND tc.table_name != 'permission'
	AND tc.table_name != ANY (execluded_tables)
	AND tc.constraint_type = 'PRIMARY KEY'
),
duplicate_keys AS (
	SELECT
		table_schema,
		table_name
	FROM
		primary_keys
	GROUP BY
		table_schema,
		table_name
	HAVING
		COUNT(DISTINCT primary_key_column) > 1
),
tables_to_handle AS (
	SELECT
		pk.table_schema,
		pk.table_name
	FROM
		primary_keys pk
		LEFT JOIN duplicate_keys dk ON pk.table_schema = dk.table_schema
			AND pk.table_name = dk.table_name
	WHERE
		dk.table_name IS NULL
	UNION
	SELECT
		table_schema,
		table_name
	FROM
		tables_to_add
),
permissions_to_create AS (
	SELECT
		snake_to_spaced (concat(table_name, '_', action_name)) permission_name,
	snake_to_spaced (concat('permission_to_', action_name, '_on_table_', table_name)) permission_description,
	snake_to_camel (concat(table_name, '_', action_name)) permission_function,
get_first_word (table_name) permission_group
FROM
	tables_to_handle
	CROSS JOIN available_actions)
	INSERT INTO accounts_schema.permission (
		permission_function,
		permission_name,
		permission_description,
		permission_group)
	SELECT
		permission_function,
		permission_name,
		permission_description,
		permission_group
	FROM
		permissions_to_create
	ORDER BY
		permission_group,
		permission_name;
	RETURN query
	SELECT
		permission_id,
		permission_function,
		permission_name,
		permission_description,
		permission_group
	FROM
		accounts_schema.permission
	ORDER BY
		permission_group,
		permission_name;
END
$$;

-- return the maximum role_security_level for specific user
CREATE OR REPLACE FUNCTION accounts_schema.user_security_level_find (in_user_id int)
	RETURNS int
	LANGUAGE plpgsql
	AS $$
DECLARE
	v_security_level int;
BEGIN
	SELECT
		max(r.role_security_level) INTO v_security_level
	FROM
		accounts_schema.user_role ur
		JOIN accounts_schema.role r ON ur.role_id = r.role_id
	WHERE
		ur.user_id = in_user_id;
	RETURN v_security_level;
END
$$;

-- Function: accounts_schema.check_caller_security_level
-- Purpose: This function checks the security level of a user (caller_id) when they attempt actions involving roles or other users, such as updates.
-- Based on the provided arguments, it performs a security level check against either a specified role or user.
-- Polymorphic Behavior: If updated_role_id is provided (and updated_user_id is NULL), the function compares the caller’s security level with that of the target role.
-- Conversely, if updated_user_id is provided (and updated_role_id is NULL), it compares with the target user’s security level.
-- Usage:
-- - Call the function with updated_role_id for role-based security checks, or updated_user_id for user-based checks.
-- - Ensure at least one of updated_role_id or updated_user_id is provided; otherwise, an exception will be raised.
-- Expected Errors:
-- - If both updated_role_id and updated_user_id are NULL, an exception is raised as one identifier is required.
-- - If the caller’s security level is insufficient for the requested action (compared to either the role or user security level), an exception is raised indicating insufficient permissions.
CREATE OR REPLACE FUNCTION accounts_schema.check_caller_security_level (updated_role_id int, updated_user_id int, caller_id int)
	RETURNS int
	LANGUAGE plpgsql
	AS $$
DECLARE
	v_role_security_level int;
	v_caller_security_level int;
	v_updated_user_security_level int;
	v_role_id int;
BEGIN
	SELECT
		accounts_schema.user_security_level_find (in_user_id => caller_id) INTO v_caller_security_level;
	IF is_null (updated_role_id) AND is_null (updated_user_id) THEN
		RETURN v_caller_security_level;
	END IF;
	IF caller_id = 0 THEN
		RAISE EXCEPTION 'caller id must be passed';
	END IF;
	-- check if the security level of updated role is higher
	IF NOT is_null (updated_role_id) THEN
		SELECT
			role_security_level INTO v_role_security_level
		FROM
			accounts_schema.role
		WHERE
			role_id = updated_role_id;
		IF v_caller_security_level < v_role_security_level THEN
			RAISE EXCEPTION 'the user security level % is lower than the updated role security level %', v_caller_security_level, v_role_security_level;
		END IF;
	END IF;
	-- check if the security level of updated user is higher
	IF NOT is_null (updated_user_id) THEN
		SELECT
			max(r.role_security_level) INTO v_updated_user_security_level
		FROM
			accounts_schema.user_role ur
			JOIN accounts_schema.role r ON ur.role_id = r.role_id
		WHERE
			ur.user_id = updated_user_id;
		IF v_caller_security_level < v_updated_user_security_level THEN
			RAISE EXCEPTION 'the user security level % is lower than the updated user security level %', v_caller_security_level, v_updated_user_security_level;
		END IF;
	END IF;
	RETURN v_caller_security_level;
END
$$;

-- Function: accounts_schema.role_create_update
-- Purpose: This function allows the creation or updating of roles. It first verifies that the caller’s security level is high enough to perform the action on the target role.
-- If an in_role_id is provided, it updates the role’s information; otherwise, it creates a new role.
-- If permissions are provided, they are updated or inserted as necessary.
-- Possible Errors:
-- - If the caller’s security level is lower than the new or updated role’s security level, an exception is raised.
-- - The function will propagate any exceptions raised from check_caller_security_level.
CREATE OR REPLACE FUNCTION accounts_schema.role_create_update (in_role_id int, in_caller_id int, in_company_id int, in_role_security_level int, in_role_name varchar(200), in_role_description varchar(200), in_permissions int[])
	RETURNS SETOF accounts_schema.role
	LANGUAGE plpgsql
	AS $$
DECLARE
	v_role_security_level int;
	v_caller_security_level int;
	v_role_id int;
BEGIN
	BEGIN
		SELECT
			accounts_schema.check_caller_security_level (updated_user_id => 0, updated_role_id => in_role_id, caller_id => in_caller_id) INTO v_caller_security_level;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE;
	END;
	IF v_caller_security_level < in_role_security_level THEN
		RAISE EXCEPTION 'the user security level % is lower than the new security level %', v_caller_security_level, in_role_security_level;
		END IF;
	IF NOT is_null (in_role_id) THEN
		UPDATE
			accounts_schema.role
		SET
			role_name = is_null_replace (in_role_name, role_name),
			company_id = (is_null (in_company_id, NULL)),
			role_description = is_null_replace (in_role_description, role_description),
			role_security_level = in_role_security_level,
			updated_at = NOW()
		WHERE
			role_id = in_role_id;
		IF NOT is_null (in_permissions) THEN
			DELETE FROM accounts_schema.role_permission
			WHERE role_id = in_role_id;
			INSERT INTO accounts_schema.role_permission (
				role_id,
				permission_id)
			SELECT
				in_role_id,
				unnest(in_permissions);
			END IF;
	ELSE
		INSERT INTO accounts_schema.role (
			role_name,
			role_security_level,
			company_id,
			role_description)
		VALUES (
			in_role_name,
			is_null (
				in_company_id, NULL),
			in_role_security_level,
			in_role_description)
	RETURNING
		role_id INTO v_role_id;
		INSERT INTO accounts_schema.role_permission (
			role_id,
			permission_id)
		SELECT
			v_role_id,
			unnest(in_permissions);
		END IF;
	RETURN query
	SELECT
		role_id,
		role_name,
		company_id,
		role_security_level,
		role_description,
		created_at,
		updated_at,
		deleted_at
	FROM
		accounts_schema.role
	WHERE
		role_id = is_null_replace (v_role_id, in_role_id);
END
$$;

-- Function: accounts_schema.user_create_update
-- Purpose: This function creates or updates a user’s information and roles. It validates that the caller’s security level allows the requested action on the user.
-- If in_user_id is provided, it updates the user’s details; otherwise, it creates a new user.
-- If roles are provided, the user’s roles are updated or assigned.
-- Possible Errors:
-- - If the caller’s security level is lower than the highest security level of the roles being assigned to the user, an exception is raised.
-- - The function will propagate any exceptions raised from check_caller_security_level.
CREATE OR REPLACE FUNCTION accounts_schema.user_create_update (in_user_id int, in_user_name varchar(200), in_caller_id int, in_company_id int, in_user_type_id int, in_user_phone varchar(200), in_user_email varchar(200), in_user_password varchar(200), in_roles int[])
	RETURNS SETOF accounts_schema.user
	LANGUAGE plpgsql
	AS $$
DECLARE
	v_max_role_security_level int;
	v_caller_security_level int;
	v_user_id int;
BEGIN
	BEGIN
		SELECT
			accounts_schema.check_caller_security_level (updated_role_id => 0, updated_user_id => in_user_id, caller_id => in_caller_id) INTO v_caller_security_level;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE;
	END;
	SELECT
		max(role_security_level) INTO v_max_role_security_level
	FROM
		accounts_schema.role
	WHERE
		role_id = ANY (in_roles);
	IF v_caller_security_level < v_max_role_security_level THEN
		RAISE EXCEPTION 'the current user security level: % ,is lower than the one of the passed roles security level: %', v_caller_security_level, v_max_role_security_level;
		RETURN;
		END IF;
	IF NOT is_null (in_user_id) THEN
		UPDATE
			accounts_schema.user
		SET
			user_name = is_null_replace (in_user_name, user_name),
			user_type_id = is_null_replace (in_user_type_id, user_type_id),
			company_id = is_null (in_company_id, NULL),
			user_email = is_null_replace (in_user_email, user_email),
			user_phone = is_null_replace (in_user_phone, user_phone),
			user_password = is_null_replace (in_user_password, user_password),
			updated_at = NOW()
		WHERE
			user_id = in_user_id;
		IF NOT is_null (in_roles) THEN
			DELETE FROM accounts_schema.user_role
			WHERE user_id = in_user_id;
			INSERT INTO accounts_schema.user_role (
				user_id,
				role_id)
			SELECT
				in_user_id,
				unnest(in_roles);
			END IF;
	ELSE
		INSERT INTO accounts_schema.user (
			user_name,
			user_type_id,
			company_id,
			user_phone,
			user_email,
			user_password)
		VALUES (
			in_user_name,
			in_user_type_id,
			in_company_id,
			in_user_phone,
			in_user_email,
			in_user_password)
	RETURNING
		user_id INTO v_user_id;
		INSERT INTO accounts_schema.user_role (
			user_id,
			role_id)
		SELECT
			v_user_id,
			unnest(in_roles);
		END IF;
	RETURN query
	SELECT
		user_id,
		user_name,
		user_type_id,
		user_phone,
		company_id,
		user_email,
		user_password,
		created_at,
		updated_at,
		deleted_at
	FROM
		accounts_schema.user
	WHERE
		user_id = is_null_replace (v_user_id, in_user_id);
END
$$;

-- Function: accounts_schema.user_delete
-- Purpose: This function deletes a user and their associated records, including authentication data and assigned roles.
-- It checks the caller’s security level to ensure they have permission to delete the specified user.
-- Possible Errors:
-- - If the caller’s security level is lower than the user being deleted, an exception is raised.
-- - The function will propagate any exceptions raised from check_caller_security_level.
CREATE OR REPLACE FUNCTION accounts_schema.user_delete (in_user_id int, in_caller_id int)
	RETURNS SETOF accounts_schema.user
	LANGUAGE plpgsql
	AS $$
BEGIN
	BEGIN
		SELECT
			accounts_schema.check_caller_security_level (updated_role_id => 0, updated_user_id => in_user_id, caller_id => in_caller_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE;
	END;
	-- delete auth user
	WITH temp_user_email AS (
		SELECT
			user_email
		FROM
			accounts_schema.user
		WHERE
			user_id = in_user_id)
	DELETE FROM auth.users USING temp_user_email
	WHERE email = temp_user_email.user_email;
	-- delete user roles
	DELETE FROM accounts_schema.user_role
	WHERE user_id = in_user_id;
	-- delete users
	RETURN query DELETE FROM accounts_schema.user
	WHERE user_id = in_user_id
	RETURNING
		*;
END
$$;

-- Function: accounts_schema.user_delete_restore
-- Purpose: This function toggles a user’s deletion status between deleted and active.
-- Usage: Provide in_user_id and in_caller_id for security validation and status toggle.
-- Errors: Raises an exception if the caller’s security level is insufficient, or if check_caller_security_level fails.
CREATE OR REPLACE FUNCTION accounts_schema.user_delete_restore (in_user_id int, in_caller_id int)
	RETURNS SETOF accounts_schema.user
	LANGUAGE plpgsql
	AS $$
BEGIN
	BEGIN
		SELECT
			accounts_schema.check_caller_security_level (updated_role_id => 0, updated_user_id => in_user_id, caller_id => in_caller_id);
	EXCEPTION
		WHEN OTHERS THEN
			-- Re-raise the exception caught from check_caller_security_level
			RAISE;
	END;
	RETURN query UPDATE
		accounts_schema.user
	SET
		deleted_at = IIF (deleted_at IS NULL, now(), NULL)
	WHERE
		user_id = in_user_id
	RETURNING
		*;
END
$$;

-- Function: accounts_schema.role_delete
-- Purpose: This function deletes a role and its associated permissions.
-- Usage: Call with the role ID and caller's ID for security validation.
-- Errors: Raises an exception if the caller’s security level is insufficient, or if check_caller_security_level fails.
CREATE OR REPLACE FUNCTION accounts_schema.role_delete (in_role_id int, in_caller_id int)
	RETURNS SETOF accounts_schema.role
	LANGUAGE plpgsql
	AS $$
BEGIN
	BEGIN
		SELECT
			accounts_schema.check_caller_security_level (updated_user_id => 0, updated_role_id => in_role_id, caller_id => in_caller_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE;
	END;
	-- delete auth user
	DELETE FROM role_permissions
	WHERE role_id = in_role_id;
	RETURN query DELETE FROM accounts_schema.role
	WHERE role_id = in_role_id
	RETURNING
		*;
END
$$;

-- Function: accounts_schema.role_delete_restore
-- Purpose: This function toggles a role’s deletion status between deleted and active.
-- Usage: Provide in_role_id and in_caller_id for security validation and status toggle.
-- Errors: Raises an exception if the caller’s security level is insufficient, or if check_caller_security_level fails.
CREATE OR REPLACE FUNCTION accounts_schema.role_delete_restore (in_role_id int, in_caller_id int)
	RETURNS SETOF accounts_schema.role
	LANGUAGE plpgsql
	AS $$
BEGIN
	BEGIN
		SELECT
			accounts_schema.check_caller_security_level (updated_user_id => 0, updated_role_id => in_role_id, caller_id => in_caller_id);
	EXCEPTION
		WHEN OTHERS THEN
			-- Re-raise the exception caught from check_caller_security_level
			RAISE;
	END;
	RETURN query UPDATE
		accounts_schema.role
	SET
		deleted_at = IIF (deleted_at IS NULL, now(), NULL)
	WHERE
		role_id = in_role_id
	RETURNING
		*;
END
$$;

