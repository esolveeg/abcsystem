
CREATE SCHEMA companies_schema;
create table companies_schema.companies(
	company_id serial PRIMARY KEY,
	company_name varchar(200) NOT NULL UNIQUE,
	company_name_ar varchar(200) ,
	company_phone varchar(200) UNIQUE,
	company_address TEXT,
	company_address_ar TEXT,
	company_description varchar(200),
	company_description_ar varchar(200),
	company_email varchar(200) UNIQUE,
	company_logo TEXT ,
	company_logo_vertical TEXT,
	company_logo_dark TEXT,
	company_logo_darl_vertical TEXT,
	created_at timestamp not null default now(),
	updated_at timestamp,
	deleted_at timestamp 
);

create table companies_schema.section_partials_types(
	section_partials_type_id int primary key,
	section_partial_type varchar(200) not null unique
);
create table companies_schema.sections(
	section_id serial primary key,
	company_id int not null,
	FOREIGN KEY (company_id) REFERENCES companies_schema.companies(company_id),
	section_name varchar(200) not null,
	section_name_ar varchar(200),
	section_icon varchar(200),
	section_description varchar(200),
	section_description_ar varchar(200),
	section_images text,
	section_image text,
	section_background_image text,
	section_video text,
	section_background_video text,
	created_at timestamp not null default now(),
	updated_at timestamp,
	deleted_at timestamp 
);

create table companies_schema.section_partials(
	section_partial_id serial primary key,
	section_id int not null,
	FOREIGN KEY (section_id) REFERENCES companies_schema.sections(section_id),
	section_partial_name varchar(200) not null ,
	section_partial_name_ar varchar(200) not null ,
	section_partial_icon varchar(200),
	section_partial_description varchar(200),
	section_partial_description_ar varchar(200),
	section_partial_images text,
	section_partial_image text,
	section_partial_content text,
	section_partial_content_ar text,
	section_partial_video text,
	created_at timestamp not null default now(),
	updated_at timestamp,
	deleted_at timestamp 
);

