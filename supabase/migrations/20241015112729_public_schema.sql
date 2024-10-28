
CREATE TABLE tags(
    tag varchar NOT NULL UNIQUE
);
 
CREATE TABLE input_types(
    input_type_id serial PRIMARY KEY,
    input_type_name varchar(20) NOT NULL UNIQUE
);

CREATE TABLE settings(
    setting_id serial PRIMARY KEY,
    input_type_id int NOT NULL,
    FOREIGN KEY (input_type_id) REFERENCES input_types(input_type_id),
    setting_key varchar(100) NOT NULL UNIQUE,
    setting_value text NOT NULL,
    updated_at timestamp

);
CREATE TABLE translations(
    translation_key varchar(200) NOT NULL UNIQUE,
    arabic_value varchar(200) NOT NULL ,
    english_value varchar(200) NOT NULL ,
    primary key(translation_key)
); 

CREATE TABLE icons(
    icon_id serial PRIMARY KEY,
    icon_name varchar(200) NOT NULL UNIQUE,
    icon_content text  NOT NULL
); 

