CREATE OR REPLACE FUNCTION companies_schema.section_create_update (in_section_id int, in_section_name varchar(200), in_section_name_ar varchar(200), in_section_description varchar(200), in_section_description_ar varchar(200), in_company_id int, in_section_background text, in_section_images varchar, in_section_icon text)
	RETURNS SETOF companies_schema.section
	LANGUAGE plpgsql
	AS $$
DECLARE
	v_section_id int;
BEGIN
	IF NOT is_null (in_section_id) THEN
		-- Update existing section if `in_section_id` is provided
		UPDATE
			companies_schema.section
		SET
			section_name = in_section_name,
			section_name_ar = in_section_name_ar,
			section_description = in_section_description,
			section_description_ar = in_section_description_ar,
			company_id = in_company_id,
			section_background = in_section_background,
			section_images = in_section_images,
			section_icon = in_section_icon,
			updated_at = NOW()
		WHERE
			section_id = in_section_id;
	ELSE
		-- Insert new section if `in_section_id` is not provided
		INSERT INTO companies_schema.section (
			section_name,
			section_name_ar,
			section_description,
			section_description_ar,
			company_id,
			section_background,
			section_images,
			section_icon)
		VALUES (
			in_section_name,
			in_section_name_ar,
			in_section_description,
			in_section_description_ar,
			in_company_id,
			in_section_route,
			in_section_background,
			in_section_images,
			in_section_icon)
	RETURNING
		section_id INTO v_section_id;
	END IF;
	-- Return the section (either updated or newly created)
	RETURN query
	SELECT
		section_id,
		section_name,
		section_name_ar,
		section_description,
		section_description_ar,
		section_breadcrumb,
		company_id,
		section_route,
		section_background,
		section_icon,
		created_at,
		updated_at,
		deleted_at
	FROM
		companies_schema.section
	WHERE
		section_id = is_null_replace (v_section_id, in_section_id);
END
$$;

