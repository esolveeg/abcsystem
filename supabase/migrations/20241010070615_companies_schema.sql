CREATE SCHEMA companies_schema;

CREATE TABLE companies_schema.company (
	company_id serial PRIMARY KEY,
	company_name varchar(200) NOT NULL UNIQUE,
	company_name_ar varchar(200),
	company_phone varchar(200) UNIQUE,
	company_address text,
	company_address_ar text,
	company_description varchar(200),
	company_description_ar varchar(200),
	company_email varchar(200) UNIQUE,
	company_logo text,
	company_logo_vertical text,
	company_logo_dark text,
	company_logo_dark_vertical text,
	company_values text,
	company_mission text,
	company_vision text,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE companies_schema.page (
	page_id serial PRIMARY KEY,
	page_name varchar(200) NOT NULL,
	page_name_ar varchar(200),
	page_description varchar(200),
	page_description_ar varchar(200),
	page_breadcrumb varchar(200),
	company_id int,
	FOREIGN KEY (company_id) REFERENCES companies_schema.company (company_id),
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

CREATE TABLE companies_schema.section (
	section_id serial PRIMARY KEY,
	section_name varchar(200) NOT NULL,
	section_name_ar varchar(200),
	section_description varchar(200),
	section_description_ar varchar(200),
	company_id int,
	FOREIGN KEY (company_id) REFERENCES companies_schema.company (company_id),
	section_background text,
	section_images text,
	section_icon text,
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE companies_schema.partial_type (
	partial_type_id serial PRIMARY KEY,
	partial_type_name varchar(200) NOT NULL UNIQUE
);

CREATE TABLE companies_schema.page_section (
	page_id int NOT NULL,
	FOREIGN KEY (page_id) REFERENCES companies_schema.page (page_id),
	section_id int NOT NULL,
	FOREIGN KEY (section_id) REFERENCES companies_schema.section (section_id),
	partial_type_id int,
	FOREIGN KEY (partial_type_id) REFERENCES companies_schema.partial_type (partial_type_id),
	is_featured bool,
	PRIMARY KEY (section_id, page_id, partial_type_id)
);

CREATE TABLE companies_schema.partial (
	partial_id serial PRIMARY KEY,
	partial_name varchar(200) NOT NULL,
	partial_type_id int NOT NULL,
	FOREIGN KEY (partial_type_id) REFERENCES companies_schema.partial_type (partial_type_id),
	company_id int,
	FOREIGN KEY (company_id) REFERENCES companies_schema.company (company_id),
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

