CREATE SCHEMA tenants_schema;

CREATE TABLE tenants_schema.tenant (
	tenant_id serial PRIMARY KEY,
	tenant_name varchar(200) NOT NULL UNIQUE,
	tenant_name_ar varchar(200),
	tenant_phone varchar(200) UNIQUE,
	tenant_address text,
	tenant_address_ar text,
	tenant_description text,
	tenant_description_ar text,
	tenant_email varchar(200) UNIQUE,
	tenant_logo text,
	tenant_logo_vertical text,
	tenant_logo_dark text,
	tenant_logo_dark_vertical text,
	tenant_values text,
	tenant_links jsonb,
	tenant_mission text,
	tenant_vision text,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE tenants_schema.partial_type (
	partial_type_id serial PRIMARY KEY,
	partial_type_name varchar(200) NOT NULL UNIQUE
);

CREATE TABLE tenants_schema.page (
	page_id serial PRIMARY KEY,
	page_name varchar(200) NOT NULL,
	page_name_ar varchar(200),
	page_description text,
	page_description_ar text,
	page_breadcrumb varchar(200),
	tenant_id int,
	FOREIGN KEY (tenant_id) REFERENCES tenants_schema.tenant (tenant_id),
	partial_type_id int,
	FOREIGN KEY (partial_type_id) REFERENCES tenants_schema.partial_type (partial_type_id),
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
	section_slug varchar(200) NOT NULL unique,
	section_name_ar varchar(200),
	section_header text,
	section_header_ar text,
	section_button_label text,
	section_button_label_ar text,
	section_button_page_id int,
	FOREIGN KEY (section_button_page_id) REFERENCES tenants_schema.page (page_id),
	section_description text,
	section_description_ar text,
	tenant_id int,
	FOREIGN KEY (tenant_id) REFERENCES tenants_schema.tenant (tenant_id),
	section_background text,
	section_images text,
	section_icon text,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp,
	deleted_at timestamp
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
	partial_name_ar varchar(200),
	partial_code varchar(200),
	partial_type_id int NOT NULL,
	FOREIGN KEY (partial_type_id) REFERENCES tenants_schema.partial_type (partial_type_id),
	section_id int NOT NULL,
	FOREIGN KEY (section_id) REFERENCES tenants_schema.section (section_id),
	partial_image text,
	partial_link text,
	partial_images text,
	partial_video text,
	is_featured bool,
	partial_brief text,
	partial_brief_ar text,
	partial_content text,
	partial_content_ar text,
	partial_button_label text,
	partial_button_label_ar text,
	partial_button_icon text,
	partial_button_link text,
	partial_button_page_id int,
	FOREIGN KEY (partial_button_page_id) REFERENCES tenants_schema.page (page_id),
	partial_icons text,
	address text,
	partial_links jsonb,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp,
	deleted_at timestamp
);

