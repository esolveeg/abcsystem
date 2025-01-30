CREATE OR REPLACE FUNCTION execute_dynamic_pagination (query_base text, sort_column text, sort_func text, primary_key text, page_number int, page_size int)
	RETURNS SETOF RECORD
	AS $$
DECLARE
	dynamic_query text;
BEGIN
	-- Step 1: Generate the dynamic SQL query
	dynamic_query := generate_dynamic_query (query_base, sort_column, is_null_replace(sort_func, 'asc'), primary_key, is_null_replace(page_number, 1), is_null_replace(page_size, 10));
	-- Step 2: Execute the dynamic query
	RETURN QUERY EXECUTE dynamic_query;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION generate_dynamic_query (query_base text, sort_column text, sort_func text, primary_key text, page_number int, page_size int)
	RETURNS text
	AS $$
DECLARE
	from_clause text;
	appended_count_clause text;
	limit_offset_clause text;
	final_query text;
BEGIN
	-- Call helper functions to generate each part of the query
	from_clause := get_from (query_base);
	appended_count_clause := append_count (query_base, sort_column);
	limit_offset_clause := FORMAT('order by %s %s , %s %s LIMIT %s OFFSET %s', sort_column, sort_func, primary_key, sort_func, page_size, (page_number - 1) * page_size);
	-- Build the final query dynamically
	final_query := FORMAT('WITH count AS (
            SELECT COUNT(*) FROM %s
        ) %s %s', from_clause, -- Part from GetFrom
		appended_count_clause, -- Part from AppendCount
		limit_offset_clause -- Part from ConstructPaginator
);
	-- Return the final query
	RETURN final_query;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION construct_paginator (sort_column text, sort_value text, sort_func text, primary_key text)
	RETURNS text
	AS $$
DECLARE
	OPERATOR TEXT;
BEGIN
	-- Determine the operator based on the sort order
	IF LOWER(sort_func) = 'desc' THEN
		OPERATOR := '<';
	ELSE
		OPERATOR := '>';
	END IF;
	-- Construct and return the query string
	RETURN FORMAT('%I %s %L ORDER BY %I %s, %I %s LIMIT %s', sort_column, -- %I: Escapes column name
		OPERATOR, -- %s: Operator
		sort_value, -- %L: Escapes literals safely
		sort_column, -- %I: Sort column
		sort_func, -- %s: Sort direction (ASC/DESC)
		primary_key, -- %I: Primary key for tiebreaker
		sort_func, -- %s: Sort direction for primary key
		2 -- %s: Limit value
);
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION append_count (query_base text, sort_column text)
	RETURNS text
	AS $$
DECLARE
	modified_query text;
BEGIN
	-- Replace the first occurrence of 'from' with ',c.count count from'
	modified_query := REPLACE(LOWER(query_base), 'from', ', c.count count from');
	-- Replace the first occurrence of 'where' with 'cross join count c where'
	modified_query := Replace(modified_query, 'where', 'CROSS JOIN count c WHERE');
	RETURN modified_query;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_from (query_base text)
	RETURNS text
	AS $$
DECLARE
	query_lower text;
	from_index int;
BEGIN
	-- Convert the query to lowercase
	query_lower := LOWER(query_base);
	-- Find the position of 'from' in the query
	from_index := POSITION('from' IN query_lower);
	-- If 'from' is not found, return an empty string
	IF from_index = 0 THEN
		RETURN '';
	END IF;
	-- Return the substring after 'from'
	RETURN SUBSTRING(query_base FROM from_index + 4);
	-- Skip 'from'
END;
$$
LANGUAGE plpgsql;

