

INSERT INTO accounts_schema.role ( 
  role_name,  
  role_description,  
  tenant_id,  
  role_security_level
) VALUES
  (
          'abc moderator', 
          'tenant moderator role', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'Tech Innovators'), 
          '10'
  );
INSERT INTO accounts_schema.role_permission ( 
  role_id,  
  permission_id
) VALUES
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PartialList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PartialCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PartialUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PartialDelete')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PartialDeleteRestore')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'ObjectList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'ObjectCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'ObjectDelete')
  );
	


INSERT INTO accounts_schema.user ( 
  user_name,  
  user_type_id,  
  user_phone,  
  user_email,  
  user_password,  
  tenant_id
) VALUES
  (
          'hassan', 
          (SELECT user_type_id FROM accounts_schema.user_type WHERE user_type_name = 'tenant'), 
          '1020002001', 
          'hassan@devkit.com', 
          '$2a$10$pWjzWgYCnpc7Bf311NP1sOddD3Lv4IfYzYqoirBaYqTrL6sg0Qm8.', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels')
  ), 
  (
          'rashad', 
          (SELECT user_type_id FROM accounts_schema.user_type WHERE user_type_name = 'tenant'), 
          '1020002002', 
          'rashad@devkit.com', 
          '$2a$10$Bq/RuDPRotjHNEb/j1E5nONV0wYTAXc4iIt51IxzYA1yHZuDMicYC', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels')
  );
INSERT INTO accounts_schema.user_role ( 
  user_id,  
  role_id
) VALUES
  (
          (SELECT user_id FROM accounts_schema.user WHERE user_email = 'hassan@devkit.com'), 
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator')
  ), 
  (
          (SELECT user_id FROM accounts_schema.user WHERE user_email = 'rashad@devkit.com'), 
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'abc moderator')
  );
	


INSERT INTO accounts_schema.navigation_bar ( 
  navigation_bar_name,  
  tenant_id
) VALUES
  (
          'abchotels_header', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels')
  ), 
  (
          'abchotels_footer', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels')
  );
	


INSERT INTO accounts_schema.navigation_bar_item ( 
  label_ar,  
  route,  
  navigation_bar_id,  
  tenant_id,  
  partial_type_id,  
  menu_key,  
  label
) VALUES
  (
          'الرئيسية', 
          '/landing', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_header'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '01_header_home', 
          'Home'
  ), 
  (
          'عن الشركة', 
          '/about', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_header'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '02_header_about', 
          'About Us'
  ), 
  (
          'الخدمات', 
          '/services', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_header'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          '03_header_services', 
          'Services'
  ), 
  (
          'المشاريع', 
          '/projects', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_header'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'project'), 
          '04_header_projects', 
          'Projects'
  ), 
  (
          'الاستوديو', 
          '/gallery', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_header'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '05_header_gallery', 
          'Gallery'
  ), 
  (
          'اتصل بنا', 
          '/contact', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_header'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '06_header_contact', 
          'Contact'
  ), 
  (
          'عن الشركة', 
          '/about', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_footer'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '01_footer_about', 
          'About ABC Hotels'
  ), 
  (
          'الاستوديو', 
          '/gallery', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_footer'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '02_footer_gallery', 
          'Our Gallery'
  ), 
  (
          'الخدمات', 
          '/projects', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_footer'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '03_footer_services', 
          'Our Services'
  ), 
  (
          'يلا بينا', 
          'https://yalabina.com/', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_footer'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '04_footer_yalabina', 
          'Yalabina Reservation Platform'
  ), 
  (
          'اتصل بنا', 
          '/contact', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_footer'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '05_footer_contact_us', 
          'Contact Us'
  );
	
