


CREATE OR REPLACE FUNCTION companies_schema.company_create_update(
in_company_id int, 
in_company_name varchar(200),
in_company_name_ar varchar(200),
in_company_phone varchar(200),
in_company_address text,
in_company_address_ar text,
in_company_email varchar(200),
in_company_values TEXT,
in_company_mission TEXT,
in_company_vision TEXT,
in_company_description text,
in_company_description_ar text,
in_company_logo text,
in_company_logo_vertical text,
in_company_logo_dark text,
in_company_logo_dark_vertical text
)
    RETURNS setof companies_schema.company
    LANGUAGE plpgsql
    AS $$
    declare v_company_id int;
BEGIN

if NOT is_null(in_company_id) then
  update accounts_schema.company
  set 
company_name = in_company_name ,
company_name_ar = in_company_name_ar ,
company_phone = in_company_phone ,
company_address = in_company_address ,
company_address_ar = in_company_address_ar ,
company_email = in_company_email ,
company_values = in_company_values,
company_mission= in_company_mission,
company_vision = in_company_vision,
company_description = in_company_description ,
company_description_ar = in_company_description_ar ,
company_logo = in_company_logo ,
company_logo_vertical = in_company_logo_vertical ,
company_logo_dark = in_company_logo_dark ,
company_logo_dark_vertical = in_company_logo_dark_vertcal ,
            updated_at = NOW()
  where company_id = in_company_id;
else
INSERT INTO companies_schema.company(
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
	company_logo_dark_vertical
) VALUES (
in_company_name,
in_company_name_ar ,
in_company_phone ,
in_company_address ,
in_company_values,
in_company_mission,
in_company_vision,
in_company_address_ar ,
in_company_email ,
in_company_description ,
in_company_description_ar ,
in_company_logo ,
in_company_logo_vertical ,
in_company_logo_dark ,
in_company_logo_dark_vertical 
) RETURNING company_id INTO v_company_id;

end if;
  return query select  
	company_id ,
	company_name ,
	company_name_ar ,
	company_phone ,
	company_address ,
	company_address_ar ,
	company_description ,
	company_description_ar ,
	company_email ,
	company_logo ,
	company_logo_vertical ,
	company_logo_dark ,
	company_logo_dark_vertical ,
	company_values ,
	company_mission ,
	company_vision ,
	created_at ,
	updated_at ,
	deleted_at 
 from companies_schema.company where company_id
 = is_null_replace(v_company_id , in_company_id);
END
$$; 

