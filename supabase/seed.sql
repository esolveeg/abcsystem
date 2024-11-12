select * from accounts_schema.permissions_populate(execluded_tables => array['navigation_bar_item' , 'log' , 'setting' , 'input_type' ] , added_tables => array['storage.bucket' , 'storage.object' ]);
insert into accounts_schema.role (role_name , role_description , role_security_level) values ('super admin' , 'this is the most privlidged role that can do all the permissions on the sysstem' , 100);
insert into accounts_schema.role_permission(role_id , permission_id) select 1 , permission_id from accounts_schema.permission;
insert into input_type (input_type_name) values 
	('text' ),
	('toggle'),
	('richtext'),
	('date');

insert into accounts_schema.user_type(user_type_name) values 
('admin'),
('company');



insert into setting(
input_type_id ,
setting_key ,
setting_value 
) values (
1,
'site_name',
'Abc Hotels'
);

