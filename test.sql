

INSERT INTO accounts_schema.role ( 
  role_security_level,  
  role_name,  
  role_description
) VALUES
  (
          '1', 
          'moderator', 
          'moderator role'
  );
INSERT INTO accounts_schema.role_permission ( 
  role_id,  
  permission_id
) VALUES
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'UserList')
  );
	


INSERT INTO accounts_schema.navigation_bar ( 
  navigation_bar_name
) VALUES
  (
          'admins backoffice'
  ), 
  (
          'company backoffice'
  );
	


INSERT INTO accounts_schema.navigation_bar_item ( 
  label_ar,  
  icon,  
  route,  
  navigation_bar_id,  
  menu_key,  
  label
) VALUES
  (
          'لوحة التحكم', 
          'dashboard', 
          '/dashboard', 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '01_dashboard', 
          'Dashboard'
  ), 
  (
          'الحسابات', 
          'people', 
          NULL, 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '02_accounts', 
          'Accounts'
  ), 
  (
          'النظام', 
          'settings', 
          NULL, 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '03_system', 
          'System'
  );
	


INSERT INTO accounts_schema.navigation_bar_item ( 
  permission_id,  
  navigation_bar_id,  
  menu_key,  
  label,  
  label_ar,  
  icon,  
  route,  
  parent_id
) VALUES
  (
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'RoleList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '01_roles', 
          'Roles', 
          'الأدوار', 
          'group_users', 
          '/accounts/role', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '02_accounts')
  ), 
  (
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'UserList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '02_users', 
          'Users', 
          'المستخدمين', 
          'user_add', 
          '/accounts/user', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '02_accounts')
  ), 
  (
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'NavigationBarList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '03_navigation', 
          'Navigation', 
          'القوائم', 
          'maps', 
          '/accounts/navigation', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '02_accounts')
  ), 
  (
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TranslationList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '01_translations', 
          'Translations', 
          'الترجمات', 
          'globe', 
          '/system/translation', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system')
  ), 
  (
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'IconList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '02_icons', 
          'Icons', 
          'الأيقونات', 
          'design', 
          '/system/icon', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system')
  ), 
  (
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'BucketList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '03_buckets', 
          'Buckets', 
          'المجلدات', 
          'folder', 
          '/system/bucket', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system')
  ), 
  (
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'ObjectList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '04_files', 
          'Objects', 
          'الملفات', 
          'file', 
          '/system/object', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system')
  ), 
  (
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SettingList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '05_settings', 
          'Settings', 
          'الإعدادات', 
          'settings_icon', 
          '/system/setting', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system')
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
          'user_verified', 
          '/accounts/users/create', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '02_users'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'UserCreate'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '02_users_create', 
          'Users Create'
  );
	


INSERT INTO accounts_schema.user ( 
  user_name,  
  user_type_id,  
  user_phone,  
  user_email,  
  user_password
) VALUES
  (
          'ahmed', 
          (SELECT user_type_id FROM accounts_schema.user_type WHERE user_type_name = 'admin'), 
          '0 1118614244', 
          'ahmed@devkit.com', 
          '$2a$10$lS9ITYLPJEESB6wmwjdmj.tIwCyI9mrkHlqensOtdFd51btBSXL7y'
  ), 
  (
          'kareem', 
          (SELECT user_type_id FROM accounts_schema.user_type WHERE user_type_name = 'admin'), 
          '1202290100', 
          'kareem@devkit.com', 
          '$2a$10$yUUQ6sTXv63PosjLA0LD.OYnb5ZGTmyrPkIQuMGUPL5Z56NXnDyIS'
  );
INSERT INTO accounts_schema.user_role ( 
  user_id,  
  role_id
) VALUES
  (
          (SELECT user_id FROM accounts_schema.user WHERE user_email = 'ahmed@devkit.com'), 
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'super admin')
  ), 
  (
          (SELECT user_id FROM accounts_schema.user WHERE user_email = 'kareem@devkit.com'), 
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator')
  );
	
