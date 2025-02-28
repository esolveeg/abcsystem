CREATE SCHEMA properties_schema;

CREATE TABLE properties_schema.property_category (
	property_category_id serial PRIMARY KEY,
	property_category_name varchar(200) NOT NULL,
	created_at timestamp NOT NULL DEFAULT NOW(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE properties_schema.compound (
	compound_id serial PRIMARY KEY,
	compound_name varchar(200) UNIQUE NOT NULL,
	compound_name_ar varchar(200) UNIQUE,
	compound_image varchar(200),
	created_at timestamp NOT NULL DEFAULT NOW(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE properties_schema.city (
	city_id serial PRIMARY KEY,
	city_name varchar(200) UNIQUE NOT NULL,
	city_name_ar varchar(200) UNIQUE,
	city_image varchar(200),
	created_at timestamp NOT NULL DEFAULT NOW(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE properties_schema.location (
	location_id serial PRIMARY KEY,
	city_id int NOT NULL,
	FOREIGN KEY (city_id) REFERENCES properties_schema.city (city_id),
	location_name varchar(200) UNIQUE NOT NULL,
	location_name_ar varchar(200) UNIQUE,
	location_image varchar(200),
	created_at timestamp NOT NULL DEFAULT NOW(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE properties_schema.amenity_group (
	amenity_group_id serial PRIMARY KEY,
	amenity_group_name varchar(200) UNIQUE NOT NULL,
	property_category_id int,
	FOREIGN KEY (property_category_id) REFERENCES properties_schema.property_category (property_category_id),
	amenity_group_icon varchar(200),
	created_at timestamp NOT NULL DEFAULT NOW(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE properties_schema.amenity_value_type (
	amenity_value_type_id serial PRIMARY KEY,
	amenity_value_type varchar(200) NOT NULL UNIQUE
);

CREATE TABLE properties_schema.amenity (
	amenity_id serial PRIMARY KEY,
	amenity_group_id integer NOT NULL,
	FOREIGN KEY (amenity_group_id) REFERENCES properties_schema.amenity_group (amenity_group_id),
	/* One-to-Many relationship */
	amenity_name varchar(200) UNIQUE NOT NULL,
	amenity_name_ar varchar(200) UNIQUE,
	amenity_icon varchar(200),
	amenity_input_label varchar,
	amenity_input_label_ar varchar,
	amenity_value_type_id int NOT NULL,
	FOREIGN KEY (amenity_value_type_id) REFERENCES properties_schema.amenity_value_type (amenity_value_type_id),
	created_at timestamp NOT NULL DEFAULT NOW(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE properties_schema.bed_type (
	bed_type_id serial PRIMARY KEY,
	bed_type varchar(200) NOT NULL UNIQUE,
	bed_type_ar varchar(200) UNIQUE,
	/* Enforces unique bed type names */
	bed_length real,
	bed_width real,
	bed_type_icon varchar(200)
);

CREATE TABLE properties_schema.property_type (
	property_type_id serial PRIMARY KEY,
	property_type_name varchar(200) NOT NULL UNIQUE,
	property_type_name_ar varchar(200) UNIQUE,
	property_type_icon varchar(200),
	property_category_id int NOT NULL,
	FOREIGN KEY (property_category_id) REFERENCES properties_schema.property_category (property_category_id),
	created_at timestamp NOT NULL DEFAULT NOW(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE properties_schema.property (
	property_id serial PRIMARY KEY,
	property_name varchar(200) NOT NULL UNIQUE,
	property_name_ar varchar(200) UNIQUE,
	address_line varchar(200) NOT NULL,
	address_line_ar varchar(200) ,
	instant_approve boolean,
	star_rating int,
	iframe_url text,
	location_url text NOT NULL,
	property_type_id int NOT NULL,
	FOREIGN KEY (property_type_id) REFERENCES properties_schema.property_type (property_type_id),
	location_id int NOT NULL,
	FOREIGN KEY (location_id) REFERENCES properties_schema.location (location_id),
	compound_id int,
	FOREIGN KEY (compound_id) REFERENCES properties_schema.compound (compound_id),
	tenant_id int NOT NULL,
	FOREIGN KEY (tenant_id) REFERENCES tenants_schema.tenant (tenant_id),
	property_image text,
	property_images text,
	property_description text,
	property_description_ar text,
	checkin_time_from time,
	checkin_time_to time,
	checkout_time_from time,
	checkout_time_to time,
	created_at timestamp NOT NULL DEFAULT NOW(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE properties_schema.reservable_unit_type (
	reservable_unit_type_id serial PRIMARY KEY,
	reservable_unit_type_name varchar(200) NOT NULL UNIQUE,
	reservable_unit_type_name_ar varchar(200) UNIQUE,
	property_category_id int NOT NULL,
	rooms_count int NOT NULL,
	FOREIGN KEY (property_category_id) REFERENCES properties_schema.property_category (property_category_id)
);

CREATE TABLE properties_schema.reservable_unit (
	reservable_unit_id serial PRIMARY KEY,
	reservable_unit_name varchar(200) NOT NULL UNIQUE,
	reservable_unit_name_ar varchar(200) UNIQUE,
	/* Enforces unique room type names */
	reservable_unit_description text,
	reservable_unit_description_ar text,
	/* Enforces unique room type names */
	minimum_guests_number int NOT NULL,
	maximum_guests_number int NOT NULL,
	unit_area real NOT NULL,
	reservable_unit_type_id int NOT NULL,
	FOREIGN KEY (reservable_unit_type_id) REFERENCES properties_schema.reservable_unit_type (reservable_unit_type_id),
	property_id int NOT NULL,
	FOREIGN KEY (property_id) REFERENCES properties_schema.property (property_id),
	bathrooms_count int NOT NULL,
	is_closed boolean DEFAULT FALSE,
	base_price real,
	reservable_unit_image text,
	reservable_unit_images text,
	created_at timestamp NOT NULL DEFAULT NOW(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE properties_schema.reservable_unit_room (
	reservable_unit_room_id serial PRIMARY KEY,
	reservable_unit_room_name varchar(200) NOT NULL UNIQUE,
	/* Enforces unique room type names */
	reservable_unit_room_image text,
	reservable_unit_room_images text,
	reservable_unit_id int NOT NULL,
	FOREIGN KEY (reservable_unit_id) REFERENCES properties_schema.reservable_unit (reservable_unit_id),
	created_at timestamp NOT NULL DEFAULT NOW(),
	updated_at timestamp,
	deleted_at timestamp
);

CREATE TABLE properties_schema.reservable_unit_room_bed (
	reservable_unit_room_id int NOT NULL,
	FOREIGN KEY (reservable_unit_room_id) REFERENCES properties_schema.reservable_unit_room (reservable_unit_room_id),
	bed_type_id int NOT NULL,
	FOREIGN KEY (bed_type_id) REFERENCES properties_schema.bed_type (bed_type_id),
	bed_count int NOT NULL,
	PRIMARY KEY (reservable_unit_room_id, bed_type_id)
);

CREATE TABLE properties_schema.unit_amenity (
	unit_id int NOT NULL,
	unit_type varchar NOT NULL,
	is_featured boolean DEFAULT FALSE,
	amenity_id int NOT NULL,
	FOREIGN KEY (amenity_id) REFERENCES properties_schema.amenity (amenity_id),
	amenity_value text,
	PRIMARY KEY (unit_id, amenity_id, unit_type)
);

