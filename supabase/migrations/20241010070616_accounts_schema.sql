CREATE SCHEMA accounts_schema;

-- Permissions table: Defines individual actions or functionalities that can be granted to roles
CREATE TABLE accounts_schema.permission (
	permission_id serial PRIMARY KEY,
	permission_function varchar(200) NOT NULL UNIQUE, -- System identifier for the permission LIKE UserCreate or ProductDelete,
	permission_name varchar(200) NOT NULL, -- Human-readable name for the permission like create user , delete product,
	permission_description varchar(200),
	permission_group varchar(200) NOT NULL -- Group category to organize permissions it should be the first phrase of the permission function like user , product
);

-- Roles table: Defines roles that can be assigned to users, each with an associated security level
CREATE TABLE accounts_schema.role (
	role_id serial PRIMARY KEY,
	tenant_id int,
	FOREIGN KEY (tenant_id) REFERENCES tenants_schema.tenant (tenant_id),
	role_name varchar(200) NOT NULL,
	role_security_level int NOT NULL, -- Security level of the role (higher value = more privilege) like super admin : 100 , moderator 10 , sales agent 1,
	role_description varchar(200),
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE accounts_schema.role_permission (
	role_id int NOT NULL,
	FOREIGN KEY (role_id) REFERENCES accounts_schema.role (role_id),
	permission_id int NOT NULL,
	FOREIGN KEY (permission_id) REFERENCES accounts_schema.permission (permission_id),
	PRIMARY KEY (role_id, permission_id)
);

-- User Types Table: Defines different types of users in the system (e.g., Admin, Customer, Employee ..etc)
CREATE TABLE accounts_schema.user_type (
	user_type_id serial PRIMARY KEY,
	user_type_name varchar(200) NOT NULL UNIQUE
);

-- Users Table: Stores individual user data and associates users with a user type
-- also the user_email on this table should be able to join with auth.users table at supabase for authentication if everythings works well but i avoided to explicilty add a freign key here to avoid complexity
CREATE TABLE accounts_schema.user (
	user_id serial PRIMARY KEY,
	user_name varchar(200) NOT NULL,
	user_image varchar(200),
	tenant_id int,
	FOREIGN KEY (tenant_id) REFERENCES tenants_schema.tenant (tenant_id),
	user_type_id int NOT NULL,
	FOREIGN KEY (user_type_id) REFERENCES accounts_schema.user_type (user_type_id),
	user_phone varchar(200) UNIQUE,
	user_email varchar(200) NOT NULL UNIQUE, -- should have record with same email on auth.users table from supabase,
	user_password varchar(200),
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE accounts_schema.user_role (
	user_id int NOT NULL,
	FOREIGN KEY (user_id) REFERENCES accounts_schema.user (user_id),
	role_id int NOT NULL,
	FOREIGN KEY (role_id) REFERENCES accounts_schema.role (role_id),
	PRIMARY KEY (user_id, role_id)
);

-- Navigation Bar Table: Represents different navigation menus within the application
CREATE TABLE accounts_schema.navigation_bar (
	navigation_bar_id serial PRIMARY KEY,
	navigation_bar_name varchar(200) UNIQUE NOT NULL,
	tenant_id int,
	FOREIGN KEY (tenant_id) REFERENCES tenants_schema.tenant (tenant_id)
);

-- Navigation Bar Items Table: Represents individual items or links in a navigation bar
CREATE TABLE accounts_schema.navigation_bar_item (
	navigation_bar_item_id serial PRIMARY KEY,
	menu_key varchar(200) UNIQUE NOT NULL,
	label varchar(200) NOT NULL, -- Display label for the item,
	label_ar varchar(200), -- Display label in Arabic (for localization)
	icon varchar(200), -- icon to show on this item on the front end , it could match icon_name from icons table or could be any string from diffrent icon library,
	tenant_id int,
	FOREIGN KEY (tenant_id) REFERENCES tenants_schema.tenant (tenant_id),
	partial_type_id int,
	FOREIGN KEY (partial_type_id) REFERENCES tenants_schema.partial_type (partial_type_id),
  parent_id int, -- Self-referential ID, allows item to belong to a parent item (for nested menus) if this is null the this item on the root level FOREIGN KEY (parent_id) REFERENCES accounts_schema.navigation_bar_item (navigation_bar_item_id),
	navigation_bar_id int,
  keywords text,
	FOREIGN KEY (navigation_bar_id) REFERENCES accounts_schema.navigation_bar (navigation_bar_id),
	permission_id int, -- Permission required to access this item
	FOREIGN KEY (permission_id) REFERENCES accounts_schema.permission (permission_id),
	"route" varchar(200)
);

