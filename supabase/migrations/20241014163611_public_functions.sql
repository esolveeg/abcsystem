create or replace function get_first_word(input_text text)
returns text as $$
begin
    -- extract the first part before the first underscore
    return split_part(input_text, '_', 1);
end;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION snake_to_spaced(input_text TEXT)
RETURNS TEXT AS $$
BEGIN
    -- Replace underscores with spaces
    RETURN REGEXP_REPLACE(input_text, '_', ' ', 'g');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION iif(condition boolean, true_result ANYELEMENT, false_result ANYELEMENT)
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
CREATE OR REPLACE FUNCTION snake_to_camel(input_text text)
RETURNS text AS $$
DECLARE
    result text := '';
    word text;
BEGIN
    -- Split the input string by underscores
    FOR word IN SELECT unnest(string_to_array(input_text, '_')) LOOP
        -- Capitalize the first letter of each word
        result := result || initcap(word);  
    END LOOP;
    RETURN result;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION is_null(in_value ANYELEMENT)
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


CREATE OR REPLACE FUNCTION is_null_replace(in_value ANYELEMENT , in_target_value ANYELEMENT)
    RETURNS ANYELEMENT
    LANGUAGE plpgsql
AS $$
    declare value_type varchar(30);
BEGIN
    IF is_null(in_value) then 
      return in_target_value;
    ELSE
        RETURN in_value;
    END IF;
END
$$;

CREATE OR REPLACE FUNCTION setting_update(keys text[], vals text[])
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
        setting AS s
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

CREATE OR REPLACE FUNCTION translation_create_update_bulk(in_keys text[], in_english_values text[], in_arabic_values text[])
    RETURNS setof translation
    LANGUAGE plpgsql
    AS $$
BEGIN
drop table if exists temp_prepared_input;
create temp table temp_prepared_input as 
select unnest(in_keys) translation_key , unnest(in_english_values) english_value , unnest(in_arabic_values) arabic_value;



drop table if exists temp_to_be_updated;
 create temp table temp_to_be_updated as 
 select t.translation_key , i.english_value , i.arabic_value from translation t join temp_prepared_input i on t.translation_key = i.translation_key;


drop table if exists temp_to_be_created;
 create temp table temp_to_be_created as 
 select i.translation_key , i.english_value , i.arabic_value from  temp_prepared_input i left join translation t on t.translation_key = i.translation_key where t.translation_key is null;

insert into translation (translation_key , english_value , arabic_value) select translation_key , english_value , arabic_value from temp_to_be_created;

update translation set english_value = i.english_value , arabic_value = i.arabic_value from temp_to_be_updated i where translation.translation_key = i.translation_key;
return query select t.translation_key , t.english_value , t.arabic_value from translation t join temp_prepared_input i on t.translation_key = i.translation_key;
END
$$;






CREATE OR REPLACE FUNCTION icon_create_update_bulk(in_icon_name text[], in_icon_content text[])
    RETURNS setof icon
    LANGUAGE plpgsql
    AS $$
BEGIN
drop table if exists temp_prepared_input;
create temp table temp_prepared_input as 
select unnest(in_icon_name) icon_name , unnest( in_icon_content) icon_content;

drop table if exists temp_to_be_updated;
 create temp table temp_to_be_updated as 
 select ic.icon_id , i.icon_name , i.icon_content from icon ic join temp_prepared_input i on ic.icon_name = i.icon_name;

drop table if exists temp_to_be_created;
 create temp table temp_to_be_created as 
 select i.icon_name , i.icon_content from  temp_prepared_input i left join icon ic on ic.icon_name = i.icon_name where ic.icon_name is null;

insert into icon(icon_name , icon_content) select icon_name , icon_content from temp_to_be_created;

update icon set icon_content = i.icon_content from temp_to_be_updated i where icon.icon_name = i.icon_name;
return query select ic.icon_id , ic.icon_name , ic.icon_content from icon ic join temp_prepared_input i on i.icon_name = ic.icon_name;
END
$$
