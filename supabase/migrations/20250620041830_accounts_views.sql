create or replace view accounts_schema.user_view as
with roles as (
  select 
    ur.user_id,
    ur.role_id,
    r.role_name
  from accounts_schema.user_role ur
  join accounts_schema.role r on ur.role_id = r.role_id
)
select 
  u.user_id,
  u.user_name,
  u.user_image,
  u.user_email,
  u.user_phone,
  ut.user_type_id,
  ut.user_type_name,
  accounts_schema.user_security_level_find(u.user_id)::int user_security_level,
  is_null_replace(t.tenant_id , 0)::int tenant_id,
  is_null_replace(t.tenant_name , '')::varchar(255) tenant_name,
  u.created_at,
  u.updated_at,
  u.deleted_at,
  (
    select json_agg(nested_roles) from (
      select 
        r.role_id ,
        r.role_name 
      from 
      roles r 
      where r.user_id = u.user_id
    ) nested_roles
  ) roles
from accounts_schema.user u 
join accounts_schema.user_type ut on u.user_type_id = ut.user_type_id
left join tenants_schema.tenant t on u.tenant_id = t.tenant_id
