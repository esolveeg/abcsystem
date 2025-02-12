

INSERT INTO accounts_schema.role ( 
  role_name,  
  role_description,  
  tenant_id,  
  role_security_level
) VALUES
  (
          'abc moderator', 
          'tenant moderator role', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '10'
  ), 
  (
          'tech  moderator', 
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
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
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
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
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
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'tech  moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'tech  moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'tech  moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'tech  moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'tech  moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'tech  moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'tech  moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'tech  moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'tech  moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'tech  moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'tech  moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  );
	


INSERT INTO accounts_schema.user ( 
  user_password,  
  tenant_id,  
  user_name,  
  user_type_id,  
  user_phone,  
  user_email
) VALUES
  (
          '$2a$10$h7XrhF7AJZDEvJjS8vqK.eRV4tFsp9T6.VyyZi5DUQQw7ijLNNb9y', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'hassan', 
          (SELECT user_type_id FROM accounts_schema.user_type WHERE user_type_name = 'tenant'), 
          '1020002001', 
          'hassan@devkit.com'
  ), 
  (
          '$2a$10$xvrlJgdCBiWycpEpm4OoyudZUEdvo7d3v6yCSlpQfOMBlWEWUjZ5K', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'rashad', 
          (SELECT user_type_id FROM accounts_schema.user_type WHERE user_type_name = 'tenant'), 
          '1020002002', 
          'rashad@devkit.com'
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
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'tech  moderator')
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
  navigation_bar_id,  
  tenant_id,  
  partial_type_id,  
  menu_key,  
  label,  
  label_ar,  
  route
) VALUES
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_header'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '01_header_home', 
          'Home', 
          'الرئيسية', 
          '/home'
  ), 
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_header'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '02_header_about', 
          'About Us', 
          'عن الشركة', 
          '/about'
  ), 
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_header'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          '03_header_services', 
          'Services', 
          'الخدمات', 
          '/services'
  ), 
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_header'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'project'), 
          '04_header_projects', 
          'Projects', 
          'المشاريع', 
          '/projects'
  ), 
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_header'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '05_header_gallery', 
          'Gallery', 
          'الاستوديو', 
          '/gallery'
  ), 
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_header'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '06_header_contact', 
          'Contact', 
          'اتصل بنا', 
          '/contact'
  ), 
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_footer'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '01_footer_about', 
          'About ABC Hotels', 
          'عن الشركة', 
          '/about'
  ), 
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_footer'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '02_footer_gallery', 
          'Our Gallery', 
          'الاستوديو', 
          '/gallery'
  ), 
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_footer'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '03_footer_services', 
          'Our Services', 
          'الخدمات', 
          '/projects'
  ), 
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_footer'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '04_footer_yalabina', 
          'Yalabina Reservation Platform', 
          'يلا بينا', 
          'https://yalabina.com/'
  ), 
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'abchotels_footer'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '05_footer_contact_us', 
          'Contact Us', 
          'اتصل بنا', 
          '/contact'
  );
	
