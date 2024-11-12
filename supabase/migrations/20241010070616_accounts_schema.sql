
CREATE SCHEMA accounts_schema;

-- Permissions table: Defines individual actions or functionalities that can be granted to roles
create table accounts_schema.permission(
	permission_id serial PRIMARY KEY,
	permission_function varchar(200) NOT NULL UNIQUE, -- System identifier for the permission LIKE UserCreate or ProductDelete,
	permission_name varchar(200) NOT NULL, -- Human-readable name for the permission like create user , delete product,
	permission_description varchar(200),
	permission_group varchar(200) NOT NULL -- Group category to organize permissions it should be the first phrase of the permission function like user , product
);

-- Roles table: Defines roles that can be assigned to users, each with an associated security level
create table accounts_schema.role(
	role_id serial primary key,
	role_name varchar(200) not null unique,
	role_security_level int NOT NULL,  -- Security level of the role (higher value = more privilege) like super admin : 100 , moderator 10 , sales agent 1,
	role_description varchar(200),
	created_at timestamp not null default now(),
	updated_at timestamp,
	deleted_at timestamp 
);

CREATE TABLE accounts_schema.role_permission(
	role_id int NOT NULL,
	FOREIGN KEY (role_id) REFERENCES accounts_schema.role(role_id),
	permission_id int NOT NULL,
	FOREIGN KEY (permission_id) REFERENCES accounts_schema.permission(permission_id),
	PRIMARY KEY (role_id, permission_id)
);

-- User Types Table: Defines different types of users in the system (e.g., Admin, Customer, Employee ..etc)
create table accounts_schema.user_type(
	user_type_id serial primary key,
	user_type_name varchar(200) not null unique
);

-- Users Table: Stores individual user data and associates users with a user type 
-- also the user_email on this table should be able to join with auth.users table at supabase for authentication if everythings works well but i avoided to explicilty add a freign key here to avoid complexity 
create table accounts_schema.user(
	user_id serial primary key,
	user_name varchar(200) not null,
	user_type_id int NOT NULL,
	FOREIGN KEY (user_type_id) REFERENCES accounts_schema.user_type  (user_type_id),
	user_phone varchar(200) unique,
	user_email varchar(200) not null unique, -- should have record with same email on auth.users table from supabase,
	user_password varchar(200),
	created_at timestamp not null default now(),
	updated_at timestamp,
	deleted_at timestamp 
);

CREATE TABLE accounts_schema.user_role(
	user_id int NOT NULL,
	FOREIGN KEY (user_id) REFERENCES accounts_schema.user(user_id),
	role_id int NOT NULL,
	FOREIGN KEY (role_id) REFERENCES accounts_schema.role(role_id),
	PRIMARY KEY (user_id, role_id)
);
-- Navigation Bar Table: Represents different navigation menus within the application
CREATE TABLE accounts_schema.navigation_bar(
    navigation_bar_id serial PRIMARY KEY,
    navigation_bar_name varchar(200) UNIQUE NOT NULL
);
-- Navigation Bar Items Table: Represents individual items or links in a navigation bar
CREATE TABLE accounts_schema.navigation_bar_item(
    navigation_bar_item_id serial PRIMARY KEY,
    menu_key varchar(200) UNIQUE NOT NULL,
    label varchar(200) NOT NULL,  -- Display label for the item,
    label_ar varchar(200), -- Display label in Arabic (for localization)
    icon varchar(200), -- icon to show on this item on the front end , it could match icon_name from icons table or could be any string from diffrent icon library,
    "route" varchar(200) UNIQUE, -- URL route associated with the item to help frontend create navigation bar component dynamically,
    navigation_bar_id int,
    FOREIGN KEY (navigation_bar_id) REFERENCES accounts_schema.navigation_bar(navigation_bar_id),
    parent_id int ,-- Self-referential ID, allows item to belong to a parent item (for nested menus) if this is null the this item on the root level
    FOREIGN KEY (parent_id) REFERENCES accounts_schema.navigation_bar_item(navigation_bar_item_id),
    permission_id int  -- Permission required to access this item
);
