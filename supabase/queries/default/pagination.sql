WITH tenant AS (
	SELECT
		t.tenant_id,
		t.tenant_name,
		t.tenant_name_ar,
		t.tenant_phone,
		t.tenant_address,
		t.tenant_address_ar,
		t.tenant_description,
		t.tenant_description_ar,
		t.tenant_email,
		t.tenant_logo,
		t.tenant_logo_vertical,
		t.tenant_logo_dark,
		t.tenant_logo_dark_vertical,
		t.tenant_values,
		t.tenant_mission,
		t.tenant_vision,
		t.created_at,
		t.updated_at,
		t.deleted_at
	FROM
		tenants_schema.tenant t
	WHERE
		t.tenant_id = 1
),
tenant_navigations AS (
	SELECT
		n.navigation_bar_id,
		n.navigation_bar_name,
		n.tenant_id
	FROM
		accounts_schema.navigation_bar n
		JOIN tenant t ON n.tenant_id = t.tenant_id
),
navigation_items AS (
	SELECT
		ni.navigation_bar_item_id,
		ni.menu_key,
		ni.label,
		ni.label_ar,
		ni.icon,
		ni.tenant_id,
		ni.partial_type_id,
		ni.navigation_bar_id,
		ni.route
	FROM
		accounts_schema.navigation_bar_item ni
		JOIN tenant_navigations n ON ni.navigation_bar_id = n.navigation_bar_id
),
tenant_pages AS (
	SELECT
		p.page_id,
		p.page_name,
		p.page_name_ar,
		p.page_description,
		p.page_description_ar,
		p.page_breadcrumb,
		p.page_route,
		p.page_cover_image,
		p.page_cover_video,
		p.page_key_words,
		p.page_meta_description,
		p.page_icon,
		p.created_at,
		p.updated_at,
		p.deleted_at
	FROM
		tenants_schema.page p
		JOIN tenant t ON p.tenant_id = t.tenant_id
	WHERE
		p.deleted_at IS NULL
),
page_sections AS (
	SELECT
		ps.page_id,
		s.section_id,
		s.section_name,
		s.section_name_ar,
		s.section_header,
		s.section_header_ar,
		s.section_button_label,
		s.section_button_label_ar,
		s.section_description,
		s.section_description_ar,
		s.tenant_id,
		s.section_background,
		s.section_images,
		s.section_icon,
		s.created_at,
		s.updated_at,
		s.deleted_at
	FROM
		tenants_schema.page_section ps
		JOIN tenant_pages p ON ps.page_id = p.page_id
		JOIN tenants_schema.section s ON ps.section_id = s.section_id
	WHERE
		s.deleted_at IS NULL
),
section_partials AS (
	SELECT
		partial_id,
		p.partial_name,
		p.partial_name_ar,
		p.partial_type_id,
		p.section_id,
		p.partial_image,
		p.partial_link,
		p.partial_images,
		p.partial_video,
		p.is_featured,
		p.partial_brief,
		p.partial_brief_ar,
		p.partial_content,
		p.partial_content_ar,
		p.partial_button_label,
		p.partial_button_label_ar,
		p.partial_button_icon,
		p.partial_button_link,
		p.partial_button_page_id,
		p.partial_icons,
		p.address,
		p.partial_links,
		p.created_at,
		p.updated_at,
		p.deleted_at
	FROM
		tenants_schema.partial p
		JOIN page_sections ps ON ps.section_id = p.section_id
	WHERE
		p.deleted_at IS NULL
)
SELECT
	t.tenant_id,
	t.tenant_name,
	t.tenant_name_ar,
	t.tenant_phone,
	t.tenant_address,
	t.tenant_address_ar,
	t.tenant_description,
	t.tenant_description_ar,
	t.tenant_email,
	t.tenant_logo,
	t.tenant_logo_vertical,
	t.tenant_logo_dark,
	t.tenant_logo_dark_vertical,
	t.tenant_values,
	t.tenant_mission,
	t.tenant_vision,
	t.created_at,
	t.updated_at,
	t.deleted_at,
	COALESCE(pages.data, '[]'::json) AS pages,
	COALESCE(navigations.data, '[]'::json) AS navigations
FROM
	tenant t
	LEFT JOIN LATERAL (
		SELECT
			json_agg(json_build_object('page_id', p.page_id, 'page_name', p.page_name, 'page_name_ar', p.page_name_ar, 'page_description', p.page_description, 'page_description_ar', p.page_description_ar, 'page_breadcrumb', p.page_breadcrumb, 'page_route', p.page_route, 'page_cover_image', p.page_cover_image, 'page_cover_video', p.page_cover_video, 'page_key_words', p.page_key_words, 'page_meta_description', p.page_meta_description, 'page_icon', p.page_icon, 'created_at', p.created_at, 'updated_at', p.updated_at, 'deleted_at', p.deleted_at, 'sections', COALESCE(sections.data, '[]'::json))) AS data
		FROM
			tenant_pages p
			LEFT JOIN LATERAL (
				SELECT
					json_agg(json_build_object('section_id', s.section_id, 'section_name', s.section_name, 'section_name_ar', s.section_name_ar, 'section_header', s.section_header, 'section_header_ar', s.section_header_ar, 'section_button_label', s.section_button_label, 'section_button_label_ar', s.section_button_label_ar, 'section_description', s.section_description, 'section_description_ar', s.section_description_ar, 'tenant_id', s.tenant_id, 'section_background', s.section_background, 'section_images', s.section_images, 'section_icon', s.section_icon, 'created_at', s.created_at, 'updated_at', s.updated_at, 'deleted_at', s.deleted_at, 'partials', COALESCE(partials.data, '[]'::json))) AS data
				FROM
					page_sections s
					LEFT JOIN LATERAL (
						SELECT
							json_agg(json_build_object('partial_id', p.partial_id, 'partial_name', p.partial_name, 'partial_name_ar', p.partial_name_ar, 'partial_type_id', p.partial_type_id, 'section_id', p.section_id, 'partial_image', p.partial_image, 'partial_link', p.partial_link, 'partial_images', p.partial_images, 'partial_video', p.partial_video, 'is_featured', p.is_featured, 'partial_brief', p.partial_brief, 'partial_brief_ar', p.partial_brief_ar, 'partial_content', p.partial_content, 'partial_content_ar', p.partial_content_ar, 'partial_button_label', p.partial_button_label, 'partial_button_label_ar', p.partial_button_label_ar, 'partial_button_icon', p.partial_button_icon, 'partial_button_link', p.partial_button_link, 'partial_button_page_id', p.partial_button_page_id, 'partial_icons', p.partial_icons, 'address', p.address, 'partial_links', p.partial_links, 'created_at', p.created_at, 'updated_at', p.updated_at, 'deleted_at', p.deleted_at)) AS data
						FROM
							section_partials p
						WHERE
							p.section_id = s.section_id) partials ON TRUE) sections ON TRUE) pages ON TRUE
	LEFT JOIN LATERAL (
		SELECT
			json_agg(json_build_object('navigation_bar_id', n.navigation_bar_id, 'navigation_bar_name', n.navigation_bar_name, 'items', COALESCE(items.data, '[]'::json))) AS data
		FROM
			tenant_navigations n
			LEFT JOIN LATERAL (
				SELECT
					json_agg(json_build_object('navigation_bar_item_id', ni.navigation_bar_item_id, 'menu_key', ni.menu_key, 'label', ni.label, 'label_ar', ni.label_ar, 'icon', ni.icon, 'route', ni.route)) AS data
				FROM
					navigation_items ni
				WHERE
					ni.navigation_bar_id = n.navigation_bar_id) items ON TRUE) navigations ON TRUE
WHERE
	t.deleted_at IS NULL;

