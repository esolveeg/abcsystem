CREATE OR REPLACE FUNCTION companies_schema.company_create_update (in_company_id int, in_company_name varchar(200), in_company_name_ar varchar(200), in_company_phone varchar(200), in_company_address text, in_company_address_ar text, in_company_email varchar(200), in_company_values text, in_company_mission text, in_company_vision text, in_company_description text, in_company_description_ar text, in_company_logo text, in_company_logo_vertical text, in_company_logo_dark text, in_company_logo_dark_vertical text)
	RETURNS SETOF companies_schema.company
	LANGUAGE plpgsql
	AS $$
DECLARE
	v_company_id int;
BEGIN
	IF NOT is_null (in_company_id) THEN
		UPDATE
			companies_schema.company
		SET
			company_name = in_company_name,
			company_name_ar = in_company_name_ar,
			company_phone = in_company_phone,
			company_address = in_company_address,
			company_address_ar = in_company_address_ar,
			company_email = in_company_email,
			company_values = in_company_values,
			company_mission = in_company_mission,
			company_vision = in_company_vision,
			company_description = in_company_description,
			company_description_ar = in_company_description_ar,
			company_logo = in_company_logo,
			company_logo_vertical = in_company_logo_vertical,
			company_logo_dark = in_company_logo_dark,
			company_logo_dark_vertical = in_company_logo_dark_vertcal,
			updated_at = NOW()
		WHERE
			company_id = in_company_id;
	ELSE
		INSERT INTO companies_schema.company (
			company_name,
			company_name_ar,
			company_phone,
			company_address,
			company_values,
			company_mission,
			company_vision,
			company_address_ar,
			company_email,
			company_description,
			company_description_ar,
			company_logo,
			company_logo_vertical,
			company_logo_dark,
			company_logo_dark_vertical)
		VALUES (
			in_company_name,
			in_company_name_ar,
			in_company_phone,
			in_company_address,
			in_company_values,
			in_company_mission,
			in_company_vision,
			in_company_address_ar,
			in_company_email,
			in_company_description,
			in_company_description_ar,
			in_company_logo,
			in_company_logo_vertical,
			in_company_logo_dark,
			in_company_logo_dark_vertical)
	RETURNING
		company_id INTO v_company_id;
	END IF;
	RETURN query
	SELECT
		company_id,
		company_name,
		company_name_ar,
		company_phone,
		company_address,
		company_address_ar,
		company_description,
		company_description_ar,
		company_email,
		company_logo,
		company_logo_vertical,
		company_logo_dark,
		company_logo_dark_vertical,
		company_values,
		company_mission,
		company_vision,
		created_at,
		updated_at,
		deleted_at
	FROM
		companies_schema.company
	WHERE
		company_id = is_null_replace(v_company_id, in_company_id);
END
$$;

CREATE OR REPLACE FUNCTION companies_schema.page_create_update (in_page_id int, in_page_name varchar(200), in_page_name_ar varchar(200), in_page_description varchar(200), in_page_description_ar varchar(200), in_page_breadcrumb varchar(200), in_company_id int, in_page_route varchar(200), in_page_cover_image text, in_page_cover_video text, in_page_key_words text, in_page_meta_description text, in_page_icon text)
	RETURNS SETOF companies_schema.page
	LANGUAGE plpgsql
	AS $$
DECLARE
	v_page_id int;
BEGIN
	IF NOT is_null (in_page_id) THEN
		-- Update existing page if `in_page_id` is provided
		UPDATE
			companies_schema.page
		SET
			page_name = in_page_name,
			page_name_ar = in_page_name_ar,
			page_description = in_page_description,
			page_description_ar = in_page_description_ar,
			page_breadcrumb = in_page_breadcrumb,
			company_id = in_company_id,
			page_route = in_page_route,
			page_cover_image = in_page_cover_image,
			page_cover_video = in_page_cover_video,
			page_key_words = in_page_key_words,
			page_meta_description = in_page_meta_description,
			page_icon = in_page_icon,
			updated_at = NOW()
		WHERE
			page_id = in_page_id;
	ELSE
		-- Insert new page if `in_page_id` is not provided
		INSERT INTO companies_schema.page (
			page_name,
			page_name_ar,
			page_description,
			page_description_ar,
			page_breadcrumb,
			company_id,
			page_route,
			page_cover_image,
			page_cover_video,
			page_key_words,
			page_meta_description,
			page_icon)
		VALUES (
			in_page_name,
			in_page_name_ar,
			in_page_description,
			in_page_description_ar,
			in_page_breadcrumb,
			in_company_id,
			in_page_route,
			in_page_cover_image,
			in_page_cover_video,
			in_page_key_words,
			in_page_meta_description,
			in_page_icon)
	RETURNING
		page_id INTO v_page_id;
	END IF;
	-- Return the page (either updated or newly created)
	RETURN query
	SELECT
		page_id,
		page_name,
		page_name_ar,
		page_description,
		page_description_ar,
		page_breadcrumb,
		company_id,
		page_route,
		page_cover_image,
		page_cover_video,
		page_key_words,
		page_meta_description,
		page_icon,
		created_at,
		updated_at,
		deleted_at
	FROM
		companies_schema.page
	WHERE
		page_id = is_null_replace(v_page_id, in_page_id);
END
$$;

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
		company_id,
		section_background,
		section_images,
		section_icon,
		created_at,
		updated_at,
		deleted_at
	FROM
		companies_schema.section
	WHERE
		section_id = is_null_replace(v_section_id, in_section_id);
END
$$;

CREATE OR REPLACE FUNCTION companies_schema.partial_create_update (in_partial_id int, in_partial_name varchar(200), in_partial_type_id int, in_company_id int, in_partial_image text, in_partial_images text, in_partial_video text, in_is_featured bool, in_partial_brief text, in_partial_content text)
	RETURNS SETOF companies_schema.partial
	LANGUAGE plpgsql
	AS $$
DECLARE
	v_partial_id int;
BEGIN
	IF NOT is_null (in_partial_id) THEN
		-- Update existing partial if `in_partial_id` is provided
		UPDATE
			companies_schema.partial
		SET
			partial_name = in_partial_name,
			partial_type_id = in_partial_type_id,
			company_id = in_company_id,
			partial_image = in_partial_image,
			partial_images = in_partial_images,
			partial_video = in_partial_video,
			is_featured = in_is_featured,
			partial_brief = in_partial_brief,
			partial_content = in_partial_content,
			updated_at = NOW()
		WHERE
			partial_id = in_partial_id;
	ELSE
		-- Insert new partial if `in_partial_id` is not provided
		INSERT INTO companies_schema.partial (
			partial_name,
			partial_type_id,
			company_id,
			partial_image,
			partial_images,
			partial_video,
			is_featured,
			partial_brief,
			partial_content)
		VALUES (
			in_partial_name,
			in_partial_type_id,
			in_company_id,
			in_partial_image,
			in_partial_images,
			in_partial_video,
			in_is_featured,
			in_partial_brief,
			in_partial_content)
	RETURNING
		partial_id INTO v_partial_id;
	END IF;
	-- Return the partial (either updated or newly created)
	RETURN query
	SELECT
		partial_id,
		partial_name,
		partial_type_id,
		company_id,
		partial_image,
		partial_images,
		partial_video,
		is_featured,
		partial_brief,
		partial_content,
		created_at,
		updated_at,
		deleted_at
	FROM
		companies_schema.partial
	WHERE
		partial_id = is_null_replace(v_partial_id, in_partial_id);
END
$$;

