insert into input_types (input_type_name) values 
	('text' ),
	('toggle'),
	('richtext'),
	('date');

insert into accounts_schema.user_types(user_type_name) values 
('admin'),
('company');



insert into settings (
input_type_id ,
setting_key ,
setting_value 
) values (
1,
'site_name',
'Abc Hotels'
);
