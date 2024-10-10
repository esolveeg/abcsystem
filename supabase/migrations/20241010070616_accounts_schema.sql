
CREATE SCHEMA accounts_schema;


create table accounts_schema.permissions(
	permission_id serial PRIMARY KEY,
	permission_function varchar(200) NOT NULL UNIQUE,
	permission_name varchar(200) NOT NULL,
	permission_description varchar(200),
	permission_group varchar(200) NOT NULL
);



create table accounts_schema.roles(
	role_id serial primary key,
	role_name varchar(200) not null unique,
	role_description varchar(200),
	created_at timestamp not null default now(),
	updated_at timestamp,
	deleted_at timestamp 
);


CREATE TABLE accounts_schema.role_permissions(
	role_id int NOT NULL,
	FOREIGN KEY (role_id) REFERENCES accounts_schema.roles(role_id),
	permission_id int NOT NULL,
	FOREIGN KEY (permission_id) REFERENCES accounts_schema.permissions(permission_id),
	PRIMARY KEY (role_id, permission_id)
);
