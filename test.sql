

INSERT INTO accounts_schema.role ( 
  role_name,  
  role_description,  
  role_security_level
) VALUES
  (
          'moderator', 
          'moderator role', 
          '1'
  );
INSERT INTO accounts_schema.role_permission ( 
  role_id,  
  permission_id
) VALUES
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'BucketCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'BucketUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SettingList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'RoleList')
  );
	


INSERT INTO accounts_schema.navigation_bar ( 
  navigation_bar_name
) VALUES
  (
          'admins backoffice'
  );
	


INSERT INTO accounts_schema.navigation_bar_item ( 
  menu_key,  
  label,  
  label_ar,  
  icon,  
  route,  
  navigation_bar_id
) VALUES
  (
          '01_dashboard', 
          'Dashboard', 
          'لوحة التحكم', 
          'dashboard_icon', 
          '/dashboard', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice')
  ), 
  (
          '02_accounts', 
          'Accounts', 
          'الحسابات', 
          'accounts_icon', 
          NULL, 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice')
  ), 
  (
          '03_system', 
          'System', 
          'النظام', 
          'system_icon', 
          NULL, 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice')
  );
	


INSERT INTO accounts_schema.navigation_bar_item ( 
  icon,  
  route,  
  parent_id,  
  permission_id,  
  navigation_bar_id,  
  menu_key,  
  label,  
  label_ar
) VALUES
  (
          'roles_icon', 
          '/accounts/roles', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '02_accounts'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'RoleList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '01_roles', 
          'Roles', 
          'الأدوار'
  ), 
  (
          'users_icon', 
          '/accounts/users', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '02_accounts'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'UserList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '02_users', 
          'Users', 
          'المستخدمين'
  ), 
  (
          'navigation_icon', 
          '/accounts/navigation', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '02_accounts'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'NavigationBarList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '03_navigation', 
          'Navigation', 
          'القوائم'
  ), 
  (
          'translations_icon', 
          '/system/translations', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TranslationList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '01_translations', 
          'Translations', 
          'الترجمات'
  ), 
  (
          'icons_icon', 
          '/system/icons', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'IconList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '02_icons', 
          'Icons', 
          'الأيقونات'
  ), 
  (
          'buckets_icon', 
          '/system/buckets', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'BucketList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '03_buckets', 
          'Buckets', 
          'المجلدات'
  ), 
  (
          'objects_icon', 
          '/system/objects', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'ObjectList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '04_files', 
          'Objects', 
          'الملفات'
  ), 
  (
          'settings_icon', 
          '/system/settings', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SettingList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '05_settings', 
          'Settings', 
          'الإعدادات'
  );
	


INSERT INTO accounts_schema.navigation_bar_item ( 
  label_ar,  
  icon,  
  route,  
  parent_id,  
  permission_id,  
  navigation_bar_id,  
  menu_key,  
  label
) VALUES
  (
          'المستخدمين', 
          'users_icon', 
          '/accounts/users/create', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '02_users'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'UserCreate'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '02_users_create', 
          'Users Create'
  );
	


INSERT INTO accounts_schema.user ( 
  user_phone,  
  user_email,  
  user_password,  
  user_name,  
  user_type_id
) VALUES
  (
          '0 1118614244', 
          'karim@devkit.com', 
          '$2a$10$8WFgph1WPiAcdBT3SLISOu.fT0hDfVpGLFHCJGe4oKDyzGs33carO', 
          'karim', 
          (SELECT user_type_id FROM accounts_schema.user_type WHERE user_type_name = 'admin')
  ), 
  (
          '1202290100', 
          'yossuf@devkit.com', 
          '$2a$10$zit1iN/cN34b1pNNvlNtq.Y4X9E7LvRA33SwXGdUoX6kuMNgl1N5i', 
          'yossuf', 
          (SELECT user_type_id FROM accounts_schema.user_type WHERE user_type_name = 'company')
  );
INSERT INTO accounts_schema.user_role ( 
  user_id,  
  role_id
) VALUES
  (
          (SELECT user_id FROM accounts_schema.user WHERE user_email = 'karim@devkit.com'), 
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'super admin')
  ), 
  (
          (SELECT user_id FROM accounts_schema.user WHERE user_email = 'yossuf@devkit.com'), 
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator')
  );
	
