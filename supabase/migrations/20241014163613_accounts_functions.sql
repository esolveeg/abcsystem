
CREATE OR REPLACE FUNCTION accounts_schema.role_create(
    in_role_name varchar(200),
    in_role_description varchar(200),
    in_permissions int[]
)
    RETURNS setof accounts_schema.roles
    LANGUAGE plpgsql
    AS $$
    declare v_role_id int;
BEGIN
       INSERT INTO accounts_schema.roles (
            role_name,
            role_description 
        ) VALUES (
            in_role_name,
            in_role_description
        ) RETURNING role_id INTO v_role_id;
       INSERT INTO accounts_schema.role_permissions (
            role_id,
            permission_id
        ) select v_role_id , unnest(in_permissions);


    return query select  
	role_id ,
	role_name ,
	role_description ,
	created_at ,
	updated_at ,
	deleted_at from accounts_schema.roles where role_id = v_role_id;

      
END
$$; 

