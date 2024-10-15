
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

