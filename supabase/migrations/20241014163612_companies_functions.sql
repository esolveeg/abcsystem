CREATE OR REPLACE FUNCTION tenants_schema.tenant_create_update (in_tenant_id int, in_tenant_name varchar(200), in_tenant_name_ar varchar(200), in_tenant_phone varchar(200), in_tenant_address text, in_tenant_address_ar text, in_tenant_email varchar(200), in_tenant_values text, in_tenant_mission text, in_tenant_vision text, in_tenant_description text, in_tenant_description_ar text, in_tenant_logo text, in_tenant_logo_vertical text, in_tenant_logo_dark text, in_tenant_logo_dark_vertical text)
	RETURNS SETOF tenants_schema.tenant
	LANGUAGE plpgsql
	AS $$
DECLARE
	v_tenant_id int;
BEGIN
	IF NOT is_null (in_tenant_id) THEN
		UPDATE
			tenants_schema.tenant
		SET
			tenant_name = in_tenant_name,
			tenant_name_ar = in_tenant_name_ar,
			tenant_phone = in_tenant_phone,
			tenant_address = in_tenant_address,
			tenant_address_ar = in_tenant_address_ar,
			tenant_email = in_tenant_email,
			tenant_values = in_tenant_values,
			tenant_mission = in_tenant_mission,
			tenant_vision = in_tenant_vision,
			tenant_description = in_tenant_description,
			tenant_description_ar = in_tenant_description_ar,
			tenant_logo = in_tenant_logo,
			tenant_logo_vertical = in_tenant_logo_vertical,
			tenant_logo_dark = in_tenant_logo_dark,
			tenant_logo_dark_vertical = in_tenant_logo_dark_vertcal,
			updated_at = NOW()
		WHERE
			tenant_id = in_tenant_id;
	ELSE
		INSERT INTO tenants_schema.tenant (
			tenant_name,
			tenant_name_ar,
			tenant_phone,
			tenant_address,
			tenant_values,
			tenant_mission,
			tenant_vision,
			tenant_address_ar,
			tenant_email,
			tenant_description,
			tenant_description_ar,
			tenant_logo,
			tenant_logo_vertical,
			tenant_logo_dark,
			tenant_logo_dark_vertical)
		VALUES (
			in_tenant_name,
			in_tenant_name_ar,
			in_tenant_phone,
			in_tenant_address,
			in_tenant_values,
			in_tenant_mission,
			in_tenant_vision,
			in_tenant_address_ar,
			in_tenant_email,
			in_tenant_description,
			in_tenant_description_ar,
			in_tenant_logo,
			in_tenant_logo_vertical,
			in_tenant_logo_dark,
			in_tenant_logo_dark_vertical)
	RETURNING
		tenant_id INTO v_tenant_id;
	END IF;
	RETURN query
	SELECT
		tenant_id,
		tenant_name,
		tenant_name_ar,
		tenant_phone,
		tenant_address,
		tenant_address_ar,
		tenant_description,
		tenant_description_ar,
		tenant_email,
		tenant_logo,
		tenant_logo_vertical,
		tenant_logo_dark,
		tenant_logo_dark_vertical,
		tenant_values,
		tenant_mission,
		tenant_vision,
		created_at,
		updated_at,
		deleted_at
	FROM
		tenants_schema.tenant
	WHERE
		tenant_id = is_null_replace(v_tenant_id, in_tenant_id);
END
$$;

CREATE OR REPLACE FUNCTION tenants_schema.page_create_update (in_page_id int, in_page_name varchar(200), in_page_name_ar varchar(200), in_page_description varchar(200), in_page_description_ar varchar(200), in_page_breadcrumb varchar(200), in_tenant_id int, in_page_route varchar(200), in_page_cover_image text, in_page_cover_video text, in_page_key_words text, in_page_meta_description text, in_page_icon text)
	RETURNS SETOF tenants_schema.page
	LANGUAGE plpgsql
	AS $$
DECLARE
	v_page_id int;
BEGIN
	IF NOT is_null (in_page_id) THEN
		-- Update existing page if `in_page_id` is provided
		UPDATE
			tenants_schema.page
		SET
			page_name = in_page_name,
			page_name_ar = in_page_name_ar,
			page_description = in_page_description,
			page_description_ar = in_page_description_ar,
			page_breadcrumb = in_page_breadcrumb,
			tenant_id = in_tenant_id,
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
		INSERT INTO tenants_schema.page (
			page_name,
			page_name_ar,
			page_description,
			page_description_ar,
			page_breadcrumb,
			tenant_id,
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
			in_tenant_id,
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
		tenant_id,
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
		tenants_schema.page
	WHERE
		page_id = is_null_replace(v_page_id, in_page_id);
END
$$;

CREATE OR REPLACE FUNCTION tenants_schema.section_create_update (in_section_id int, in_section_name varchar(200), in_section_name_ar varchar(200), in_section_description varchar(200), in_section_description_ar varchar(200), in_tenant_id int, in_section_background text, in_section_images varchar, in_section_icon text)
	RETURNS SETOF tenants_schema.section
	LANGUAGE plpgsql
	AS $$
DECLARE
	v_section_id int;
BEGIN
	IF NOT is_null (in_section_id) THEN
		-- Update existing section if `in_section_id` is provided
		UPDATE
			tenants_schema.section
		SET
			section_name = in_section_name,
			section_name_ar = in_section_name_ar,
			section_description = in_section_description,
			section_description_ar = in_section_description_ar,
			tenant_id = in_tenant_id,
			section_background = in_section_background,
			section_images = in_section_images,
			section_icon = in_section_icon,
			updated_at = NOW()
		WHERE
			section_id = in_section_id;
	ELSE
		-- Insert new section if `in_section_id` is not provided
		INSERT INTO tenants_schema.section (
			section_name,
			section_name_ar,
			section_description,
			section_description_ar,
			tenant_id,
			section_background,
			section_images,
			section_icon)
		VALUES (
			in_section_name,
			in_section_name_ar,
			in_section_description,
			in_section_description_ar,
			in_tenant_id,
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
		tenant_id,
		section_background,
		section_images,
		section_icon,
		created_at,
		updated_at,
		deleted_at
	FROM
		tenants_schema.section
	WHERE
		section_id = is_null_replace(v_section_id, in_section_id);
END
$$;

CREATE OR REPLACE FUNCTION tenants_schema.partial_create_update (in_partial_id int, in_partial_name varchar(200), in_partial_type_id int, in_tenant_id int, in_partial_image text, in_partial_images text, in_partial_video text, in_is_featured bool, in_partial_brief text, in_partial_content text)
	RETURNS SETOF tenants_schema.partial
	LANGUAGE plpgsql
	AS $$
DECLARE
	v_partial_id int;
BEGIN
	IF NOT is_null (in_partial_id) THEN
		-- Update existing partial if `in_partial_id` is provided
		UPDATE
			tenants_schema.partial
		SET
			partial_name = in_partial_name,
			partial_type_id = in_partial_type_id,
			tenant_id = in_tenant_id,
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
		INSERT INTO tenants_schema.partial (
			partial_name,
			partial_type_id,
			tenant_id,
			partial_image,
			partial_images,
			partial_video,
			is_featured,
			partial_brief,
			partial_content)
		VALUES (
			in_partial_name,
			in_partial_type_id,
			in_tenant_id,
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
		tenant_id,
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
		tenants_schema.partial
	WHERE
		partial_id = is_null_replace(v_partial_id, in_partial_id);
END
$$;

