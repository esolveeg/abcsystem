

CREATE OR REPLACE FUNCTION accounts_schema.role_create_update(
    in_role_id int,
    in_role_name varchar(200),
    in_role_description varchar(200),
    in_permissions int[]
)
    RETURNS setof accounts_schema.roles
    LANGUAGE plpgsql
    AS $$
    declare v_role_id int;
BEGIN

if NOT IsNull(in_role_id) then
  update accounts_schema.roles 
  set 
  role_name = IsNullReplace(in_role_name , role_name) , 
  role_description = IsNullReplace(in_role_description , role_description)
  where role_id = in_role_id;


  if NOT IsNull(in_permissions) then
    delete from accounts_schema.role_permissions where role_id = in_role_id;
    insert into accounts_schema.role_permissions (role_id , permission_id) select in_role_id , unnest(in_permissions);
  end if;
   
else
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

end if;
  return query select  
    role_id ,
    role_name ,
    role_description ,
    created_at ,
    updated_at ,
    deleted_at from accounts_schema.roles where role_id = isnullreplace(v_role_id , in_role_id);

      
END
$$; 

CREATE OR REPLACE FUNCTION accounts_schema.user_create_update(
    in_user_id int,
    in_user_name varchar(200),
    in_user_security_level int,
    in_user_type_id int,
    in_user_phone varchar(200),
    in_user_email varchar(200),
    in_user_password varchar(200),
    in_roles int[]
)
    RETURNS setof accounts_schema.users
    LANGUAGE plpgsql
    AS $$
    declare v_user_id int;
BEGIN

if NOT IsNull(in_user_id) then
  update accounts_schema.users
  set 
  user_name = IsNullReplace(in_user_name , user_name), 
  user_security_level = in_user_security_level, 
  user_type_id = IsNullReplace(in_user_type_id , user_type_id), 
  user_email = IsNullReplace(in_user_email , user_email), 
  user_phone = IsNullReplace(in_user_phone , user_phone), 
  user_password = IsNullReplace(in_user_password , user_password)
  where user_id = in_user_id;


  if NOT IsNull(in_roles) then
    delete from accounts_schema.user_roles where user_id = in_user_id;
    insert into accounts_schema.user_roles (role_id , user_id) select in_user_id , unnest(in_roles);
  end if;
else
      INSERT INTO accounts_schema.users(
            user_name,
            user_security_level,
            user_type_id,
            user_phone,
            user_email,
            user_password

      ) VALUES (
            in_user_name,
            in_user_security_level,
            in_user_type_id,
            in_user_phone,
            in_user_email,
            in_user_password
        ) RETURNING user_id INTO v_user_id;

       INSERT INTO accounts_schema.user_roles (
            user_id,
            role_id
        ) select v_user_id , unnest(in_roles);
end if;
  return query select  
   user_id ,
	user_name ,
	user_security_level,
	user_type_id ,
	user_phone ,
	user_email ,
	user_password ,
	created_at ,
	updated_at ,
	deleted_at 
from accounts_schema.users where user_id = isnullreplace(v_user_id , in_user_id);
END
$$; 

