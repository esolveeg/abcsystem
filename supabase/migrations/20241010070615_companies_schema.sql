CREATE SCHEMA tenants_schema;

CREATE TABLE tenants_schema.tenant (
	tenant_id serial PRIMARY KEY,
	tenant_name varchar(200) NOT NULL UNIQUE,
	tenant_name_ar varchar(200),
	tenant_phone varchar(200) UNIQUE,
	tenant_address text,
	tenant_address_ar text,
	tenant_description varchar(200),
	tenant_description_ar varchar(200),
	tenant_email varchar(200) UNIQUE,
	tenant_logo text,
	tenant_logo_vertical text,
	tenant_logo_dark text,
	tenant_logo_dark_vertical text,
	tenant_values text,
	tenant_mission text,
	tenant_vision text,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE tenants_schema.page (
	page_id serial PRIMARY KEY,
	page_name varchar(200) NOT NULL,
	page_name_ar varchar(200),
	page_description varchar(200),
	page_description_ar varchar(200),
	page_breadcrumb varchar(200),
	tenant_id int,
	FOREIGN KEY (tenant_id) REFERENCES tenants_schema.tenant (tenant_id),
	page_route varchar(200) NOT NULL,
	page_cover_image text,
	page_cover_video text,
	page_key_words text,
	page_meta_description text,
	page_icon text,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE tenants_schema.section (
	section_id serial PRIMARY KEY,
	section_name varchar(200) NOT NULL,
	section_name_ar varchar(200),
	section_description varchar(200),
	section_description_ar varchar(200),
	tenant_id int,
	FOREIGN KEY (tenant_id) REFERENCES tenants_schema.tenant (tenant_id),
	section_background text,
	section_images text,
	section_icon text,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE tenants_schema.partial_type (
	partial_type_id serial PRIMARY KEY,
	partial_type_name varchar(200) NOT NULL UNIQUE
);

CREATE TABLE tenants_schema.page_section (
	page_id int NOT NULL,
	FOREIGN KEY (page_id) REFERENCES tenants_schema.page (page_id),
	section_id int NOT NULL,
	FOREIGN KEY (section_id) REFERENCES tenants_schema.section (section_id),
	partial_type_id int,
	FOREIGN KEY (partial_type_id) REFERENCES tenants_schema.partial_type (partial_type_id),
	is_featured bool,
	PRIMARY KEY (section_id, page_id, partial_type_id)
);

CREATE TABLE tenants_schema.partial (
	partial_id serial PRIMARY KEY,
	partial_name varchar(200) NOT NULL,
	partial_type_id int NOT NULL,
	FOREIGN KEY (partial_type_id) REFERENCES tenants_schema.partial_type (partial_type_id),
	tenant_id int,
	FOREIGN KEY (tenant_id) REFERENCES tenants_schema.tenant (tenant_id),
	partial_image text,
	partial_images text,
	partial_video text,
	is_featured bool,
	partial_brief text,
	partial_content text,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp,
	deleted_at timestamp
);

