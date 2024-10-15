insert into accounts_schema.permissions(permission_name , permission_function , permission_group , permission_description) values 
('roles list' , 'RolesList' , 'roles' , 'permission to list roles'),
('role create' , 'RoleCreate' , 'roles' , 'permission to create  role'),
('role update' , 'RoleUpdate' , 'roles' , 'permission to update  role'),
('role delete restore' , 'RoleDeleteRestore' , 'roles' , 'permission to delete restore   role');
insert into accounts_schema.user_types(user_type_name) values 
('admin'),
('company');
