
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
