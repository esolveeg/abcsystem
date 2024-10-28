
 CREATE OR REPLACE FUNCTION IsNull(in_value ANYELEMENT)
    RETURNS boolean
    LANGUAGE plpgsql
AS $$
    declare value_type varchar(30);
BEGIN

    IF in_value IS NULL THEN 
        RETURN TRUE;
    END IF;
    select pg_typeof(in_value) into value_type;
    IF value_type = 'character varying' OR value_type = 'text'  THEN
        IF in_value = '' OR in_value IS NULL THEN
            RETURN true;
        ELSE
            RETURN false;
        END IF;
    ELSIF value_type = 'integer' OR  value_type = 'real'  THEN
        IF in_value = 0 OR in_value IS NULL THEN
            RETURN true;
        ELSE
            RETURN false;
        END IF;

    ELSEIF value_type LIKE '%[]' THEN
        IF array_length(in_value , 1) IS NULL THEN
            RETURN true;
        ELSE
            RETURN false;
        END IF;
    ELSIF value_type = 'time with time zone' 
    OR  value_type = 'time without time zone'  
    OR  value_type = 'timestamp with time zone'  
    OR  value_type = 'timestamp without time zone'  
    OR  value_type = 'boolean'  
    OR  value_type = 'boolean'  
    THEN
        IF in_value IS NULL THEN
            RETURN true;
        ELSE
            RETURN false;
        END IF;
    ELSE
        -- Handle other data types if needed
        RAISE EXCEPTION 'Unsupported data type: %', pg_typeof(in_value);
    END IF;
END
$$;

CREATE OR REPLACE FUNCTION IIF(condition boolean, true_result ANYELEMENT, false_result ANYELEMENT)
    RETURNS ANYELEMENT
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF condition THEN
        RETURN true_result;
    ELSE
        RETURN false_result;
    END IF;
END
$$; 
 

CREATE OR REPLACE FUNCTION IsNullReplace(in_value ANYELEMENT , in_target_value ANYELEMENT)
    RETURNS ANYELEMENT
    LANGUAGE plpgsql
AS $$
    declare value_type varchar(30);
BEGIN
    IF IsNull(in_value) then 
      return in_target_value;
    ELSE
        RETURN in_value;
    END IF;
END
$$;

CREATE OR REPLACE FUNCTION settings_bulk_create(keys text[], vals text[])
    RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Create a temporary table to hold the new values
    CREATE TEMP TABLE temp_settings AS
    SELECT
        unnest($1) AS setting_key,
        unnest($2) AS setting_value;
    -- Update the main table based on the temporary table
    UPDATE
        settings AS s
    SET
        setting_value = t.setting_value
    FROM
        temp_settings AS t
    WHERE
        s.setting_key = t.setting_key;
    -- Drop the temporary table
    DROP TABLE temp_settings;
END
$$; 

CREATE OR REPLACE FUNCTION translations_create_update_bulk(in_keys text[], in_english_values text[], in_arabic_values text[])
    RETURNS setof translations
    LANGUAGE plpgsql
    AS $$
BEGIN

create temp table temp_prepared_input as 
select unnest(in_keys) translation_key , unnest(in_english_values) english_value , unnest(in_arabic_values) arabic_value;



 create temp table temp_to_be_updated as 
 select t.translation_key , i.english_value , i.arabic_value from translations t join temp_prepared_input i on t.translation_key = i.translation_key;


 create temp table temp_to_be_created as 
 select i.translation_key , i.english_value , i.arabic_value from  temp_prepared_input i left join translations t on t.translation_key = i.translation_key where t.translation_key is null;

insert into translations (translation_key , english_value , arabic_value) select translation_key , english_value , arabic_value from temp_to_be_created;

update translations set english_value = i.english_value , arabic_value = i.arabic_value from temp_to_be_updated i where translations.translation_key = i.translation_key;
return query select t.translation_key , t.english_value , t.arabic_value from translations t join temp_prepared_input i on t.translation_key = i.translation_key;
END
$$;



CREATE OR REPLACE FUNCTION icons_create_update_bulk(in_icons_name text[], in_icons_content text[])
    RETURNS setof icons
    LANGUAGE plpgsql
    AS $$
BEGIN
drop table if exists temp_prepared_input;
create temp table temp_prepared_input as 
select unnest(in_icons_name) icon_name , unnest( in_icons_content) icon_content;

drop table if exists temp_to_be_updated;
 create temp table temp_to_be_updated as 
 select ic.icon_id , i.icon_name , i.icon_content from icons ic join temp_prepared_input i on ic.icon_name = i.icon_name;

drop table if exists temp_to_be_created;
 create temp table temp_to_be_created as 
 select i.icon_name , i.icon_content from  temp_prepared_input i left join icons ic on ic.icon_name = i.icon_name where ic.icon_name is null;

insert into icons(icon_name , icon_content) select icon_name , icon_content from temp_to_be_created;

update icons set icon_content = i.icon_content from temp_to_be_updated i where icons.icon_name = i.icon_name;
return query select ic.icon_id , ic.icon_name , ic.icon_content from icons ic join temp_prepared_input i on i.icon_name = ic.icon_name;
END
$$;
