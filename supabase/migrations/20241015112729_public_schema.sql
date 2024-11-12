
CREATE TABLE tag(
    tag varchar NOT NULL UNIQUE
);
 
CREATE TABLE input_type(
    input_type_id serial PRIMARY KEY,
    input_type_name varchar(20) NOT NULL UNIQUE
);

CREATE TABLE setting(
    setting_id serial PRIMARY KEY,
    input_type_id int NOT NULL,
    FOREIGN KEY (input_type_id) REFERENCES input_type(input_type_id),
    setting_key varchar(100) NOT NULL UNIQUE,
    setting_value text NOT NULL,
    updated_at timestamp

);
CREATE TABLE translation(
    translation_key varchar(200) NOT NULL UNIQUE,
    arabic_value varchar(200) NOT NULL ,
    english_value varchar(200) NOT NULL ,
    primary key(translation_key)
); 

CREATE TABLE icon(
    icon_id serial PRIMARY KEY,
    icon_name varchar(200) NOT NULL UNIQUE,
    icon_content text  NOT NULL
); 

CREATE TABLE log(
    log_id serial PRIMARY KEY,
    log_title varchar(200) NOT NULL,
    user_id int NOT NULL,
    record_id int,
    action_name varchar(100),
    table_name varchar(100),
    permission_name varchar(200),
    created_at timestamp not null default now()
); 

