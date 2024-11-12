
CREATE OR REPLACE FUNCTION accounts_schema.test_security_level_enforcement()
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    super_role_id INT;
    normal_role_id INT;
    super_user_id INT;
    normal_user_id INT;
BEGIN
    -- 1. Create role with high security level (Super Role: 100)
    INSERT INTO accounts_schema.role (role_name, role_security_level, role_description)
    VALUES ('Super Role', 100, 'Role with highest security level')
    RETURNING role_id INTO super_role_id;

    -- 2. Create role with low security level (Normal Role: 1)
    INSERT INTO accounts_schema.role (role_name, role_security_level, role_description)
    VALUES ('Normal Role', 1, 'Role with lowest security level')
    RETURNING role_id INTO normal_role_id;

    -- 3. Create user with high security level (Super User: 100)
    INSERT INTO accounts_schema.user (user_name, user_type_id, user_email, user_phone, user_password)
    VALUES ('Super User', 1, 'superuser@example.com', '123456789', 'password')
    RETURNING user_id INTO super_user_id;
    INSERT INTO accounts_schema.user_role (user_id, role_id) VALUES (super_user_id, super_role_id);

    -- 4. Create user with low security level (Normal User: 1)
    INSERT INTO accounts_schema.user (user_name, user_type_id, user_email, user_phone, user_password)
    VALUES ('Normal User', 1, 'normaluser@example.com', '987654321', 'password')
    RETURNING user_id INTO normal_user_id;
    INSERT INTO accounts_schema.user_role (user_id, role_id) VALUES (normal_user_id, normal_role_id);

    -- 5. Try to create a new role with higher security level (50) from Normal User; expect exception
    BEGIN
        PERFORM accounts_schema.role_create_update(
            in_role_id => 0,
            in_caller_id => normal_user_id,
            in_role_security_level => 50,
            in_role_name => 'new role high level',
            in_role_description => 'testing high level creation',
            in_permissions => array[1]
        );
        RAISE EXCEPTION 'Test failed: Normal User should not be able to create role with higher security level.';
    EXCEPTION WHEN others THEN
        RAISE NOTICE 'Test passed: Normal User cannot create a high-security-level role as expected.';
    END;

    -- 6. Try to create the same role from Super User; expect success
    BEGIN
        PERFORM accounts_schema.role_create_update(
            in_role_id => NULL,
            in_caller_id => super_user_id,
            in_role_security_level => 50,
            in_role_name => 'New Role High Level',
            in_role_description => 'Testing high level creation',
            in_permissions => NULL
        );
        RAISE NOTICE 'Test passed: Super User can create a high-security-level role as expected.';
    EXCEPTION WHEN others THEN
        RAISE;
    END;

    -- 7. Try to update the created role from Normal User; expect exception
    BEGIN
        PERFORM accounts_schema.role_create_update(
            in_role_id => super_role_id,
            in_caller_id => normal_user_id,
            in_role_security_level => 50,
            in_role_name => 'Updated Role High Level',
            in_role_description => 'Attempted by Normal User',
            in_permissions => NULL
        );
        RAISE EXCEPTION 'Test failed: Normal User should not be able to update high-security-level role.';
    EXCEPTION WHEN others THEN
        RAISE NOTICE 'Test passed: Normal User cannot update high-security-level role as expected.';
    END;

    -- 8. Try to update the role from Super User; expect success
    PERFORM accounts_schema.role_create_update(
        in_role_id => super_role_id,
        in_caller_id => super_user_id,
        in_role_security_level => 50,
        in_role_name => 'Updated Role High Level',
        in_role_description => 'Updated by Super User',
        in_permissions => NULL
    );

    -- 9. Try to update Super User's data by Normal User; expect exception
    BEGIN
        PERFORM accounts_schema.user_create_update(
            in_user_id => super_user_id,
            in_user_name => 'Updated Super User',
            in_caller_id => normal_user_id,
            in_user_type_id => 1,
            in_user_phone => '123123123',
            in_user_email => 'superuser@example.com',
            in_user_password => 'password',
            in_roles => array[super_role_id]
        );
        RAISE EXCEPTION 'Test failed: Normal User should not be able to update Super User data.';
    EXCEPTION WHEN others THEN
        RAISE NOTICE 'Test passed: Normal User cannot update Super User data as expected.';
    END;

    -- 10. Try to update Normal User's data by Super User; expect success
    PERFORM accounts_schema.user_create_update(
        in_user_id => normal_user_id,
        in_user_name => 'Updated Normal User',
        in_caller_id => super_user_id,
        in_user_type_id => 1,
        in_user_phone => '987654321',
        in_user_email => 'normaluser@example.com',
        in_user_password => 'password',
        in_roles => array[normal_role_id]
    );

    -- 11. Try to create a new user with Super Role by Normal User; expect exception
    BEGIN
        PERFORM accounts_schema.user_create_update(
            in_user_id => NULL,
            in_user_name => 'Test User',
            in_caller_id => normal_user_id,
            in_user_type_id => 1,
            in_user_phone => '111222333',
            in_user_email => 'testuser@example.com',
            in_user_password => 'password',
            in_roles => array[super_role_id]
        );
        RAISE EXCEPTION 'Test failed: Normal User should not be able to create a user with Super Role.';
    EXCEPTION WHEN others THEN
        RAISE NOTICE 'Test passed: Normal User cannot create a user with Super Role as expected.';
    END;

    -- 12. Try to create a new user with Normal Role by Normal User; expect success
    PERFORM accounts_schema.user_create_update(
        in_user_id => NULL,
        in_user_name => 'Test User Normal',
        in_caller_id => normal_user_id,
        in_user_type_id => 1,
        in_user_phone => '111222333',
        in_user_email => 'testusernormal@example.com',
        in_user_password => 'password',
        in_roles => array[normal_role_id]
    );

    -- 13. Try to create a new user with Super Role by Super User; expect success
    PERFORM accounts_schema.user_create_update(
        in_user_id => NULL,
        in_user_name => 'Test User Super',
        in_caller_id => super_user_id,
        in_user_type_id => 1,
        in_user_phone => '444555666',
        in_user_email => 'testusersuper@example.com',
        in_user_password => 'password',
        in_roles => array[super_role_id]
    );

    RAISE NOTICE 'All tests completed successfully.';

    -- Cleanup: Delete only the records created by this test
    DELETE FROM accounts_schema.user_role WHERE role_id IN (super_role_id, normal_role_id) or user_id IN (super_user_id, normal_user_id) ;
    DELETE FROM accounts_schema.user WHERE user_id IN (super_user_id, normal_user_id) ;
    DELETE FROM accounts_schema.role_permission WHERE role_id IN (super_role_id, normal_role_id) ;
    DELETE FROM accounts_schema.role WHERE role_id IN (super_role_id, normal_role_id) ;
END
$$;
