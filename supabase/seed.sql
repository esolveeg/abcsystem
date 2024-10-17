
insert into accounts_schema.permissions(permission_name , permission_function , permission_group , permission_description) values 
('roles list' , 'RolesList' , 'roles' , 'permission to list roles'),
('role create' , 'RoleCreate' , 'roles' , 'permission to create  role'),
('role update' , 'RoleUpdate' , 'roles' , 'permission to update  role'),
('role delete restore' , 'RoleDeleteRestore' , 'roles' , 'permission to delete restore   role');
insert into accounts_schema.roles (role_name , role_description) values ('admin' , 'super user privilages');
insert into accounts_schema.role_permissions (role_id , permission_id) select 1 , permission_id from accounts_schema.permissions;
insert into accounts_schema.user_types(user_type_name) values 
('admin'),
('company');
