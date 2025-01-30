

INSERT INTO accounts_schema.role ( 
  role_name,  
  role_description,  
  role_security_level
) VALUES
  (
          'moderator1', 
          'moderator role1', 
          '1'
  ), 
  (
          'moderator2', 
          'moderator role2', 
          '1'
  ), 
  (
          'moderator3', 
          'moderator role3', 
          '1'
  ), 
  (
          'moderator4', 
          'moderator role4', 
          '1'
  ), 
  (
          'moderator5', 
          'moderator role5', 
          '1'
  ), 
  (
          'moderator6', 
          'moderator role6', 
          '1'
  ), 
  (
          'moderator7', 
          'moderator role7', 
          '1'
  ), 
  (
          'moderator8', 
          'moderator role8', 
          '1'
  ), 
  (
          'moderator9', 
          'moderator role9', 
          '1'
  ), 
  (
          'moderator10', 
          'moderator role10', 
          '1'
  ), 
  (
          'moderator11', 
          'moderator role11', 
          '1'
  ), 
  (
          'moderator12', 
          'moderator role12', 
          '1'
  ), 
  (
          'moderator13', 
          'moderator role13', 
          '1'
  ), 
  (
          'moderator14', 
          'moderator role14', 
          '1'
  ), 
  (
          'moderator15', 
          'moderator role15', 
          '1'
  ), 
  (
          'moderator16', 
          'moderator role16', 
          '1'
  ), 
  (
          'moderator17', 
          'moderator role17', 
          '1'
  ), 
  (
          'moderator18', 
          'moderator role18', 
          '1'
  ), 
  (
          'moderator19', 
          'moderator role19', 
          '1'
  ), 
  (
          'moderator20', 
          'moderator role20', 
          '1'
  ), 
  (
          'moderator21', 
          'moderator role21', 
          '1'
  ), 
  (
          'moderator22', 
          'moderator role22', 
          '1'
  ), 
  (
          'moderator23', 
          'moderator role23', 
          '1'
  ), 
  (
          'moderator24', 
          'moderator role24', 
          '1'
  ), 
  (
          'moderator25', 
          'moderator role25', 
          '1'
  ), 
  (
          'moderator26', 
          'moderator role26', 
          '1'
  ), 
  (
          'moderator27', 
          'moderator role27', 
          '1'
  ), 
  (
          'moderator28', 
          'moderator role28', 
          '1'
  ), 
  (
          'moderator29', 
          'moderator role29', 
          '1'
  ), 
  (
          'moderator30', 
          'moderator role30', 
          '1'
  ), 
  (
          'moderator31', 
          'moderator role31', 
          '1'
  ), 
  (
          'moderator32', 
          'moderator role32', 
          '1'
  ), 
  (
          'moderator33', 
          'moderator role33', 
          '1'
  ), 
  (
          'moderator34', 
          'moderator role34', 
          '1'
  ), 
  (
          'moderator35', 
          'moderator role35', 
          '1'
  ), 
  (
          'moderator36', 
          'moderator role36', 
          '1'
  ), 
  (
          'moderator37', 
          'moderator role37', 
          '1'
  ), 
  (
          'moderator38', 
          'moderator role38', 
          '1'
  ), 
  (
          'moderator39', 
          'moderator role39', 
          '1'
  ), 
  (
          'moderator40', 
          'moderator role40', 
          '1'
  ), 
  (
          'moderator41', 
          'moderator role41', 
          '1'
  ), 
  (
          'moderator42', 
          'moderator role42', 
          '1'
  ), 
  (
          'moderator43', 
          'moderator role43', 
          '1'
  ), 
  (
          'moderator44', 
          'moderator role44', 
          '1'
  ), 
  (
          'moderator45', 
          'moderator role45', 
          '1'
  ), 
  (
          'moderator46', 
          'moderator role46', 
          '1'
  ), 
  (
          'moderator47', 
          'moderator role47', 
          '1'
  ), 
  (
          'moderator48', 
          'moderator role48', 
          '1'
  ), 
  (
          'moderator49', 
          'moderator role49', 
          '1'
  ), 
  (
          'moderator50', 
          'moderator role50', 
          '1'
  ), 
  (
          'moderator51', 
          'moderator role51', 
          '1'
  ), 
  (
          'moderator52', 
          'moderator role52', 
          '1'
  ), 
  (
          'moderator53', 
          'moderator role53', 
          '1'
  ), 
  (
          'moderator54', 
          'moderator role54', 
          '1'
  ), 
  (
          'moderator55', 
          'moderator role55', 
          '1'
  ), 
  (
          'moderator56', 
          'moderator role56', 
          '1'
  ), 
  (
          'moderator57', 
          'moderator role57', 
          '1'
  ), 
  (
          'moderator58', 
          'moderator role58', 
          '1'
  ), 
  (
          'moderator59', 
          'moderator role59', 
          '1'
  ), 
  (
          'moderator60', 
          'moderator role60', 
          '1'
  ), 
  (
          'moderator61', 
          'moderator role61', 
          '1'
  ), 
  (
          'moderator62', 
          'moderator role62', 
          '1'
  );
INSERT INTO accounts_schema.role_permission ( 
  role_id,  
  permission_id
) VALUES
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator1'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator1'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator1'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator1'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator1'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator1'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator1'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator1'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator1'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator1'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator1'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator1'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator2'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator2'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator2'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator2'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator2'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator2'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator2'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator2'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator2'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator2'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator2'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator2'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator3'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator3'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator3'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator3'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator3'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator3'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator3'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator3'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator3'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator3'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator3'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator3'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator4'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator4'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator4'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator4'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator4'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator4'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator4'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator4'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator4'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator4'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator4'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator4'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator5'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator5'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator5'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator5'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator5'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator5'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator5'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator5'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator5'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator5'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator5'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator5'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator6'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator6'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator6'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator6'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator6'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator6'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator6'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator6'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator6'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator6'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator6'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator6'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator7'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator7'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator7'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator7'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator7'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator7'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator7'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator7'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator7'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator7'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator7'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator7'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator8'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator8'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator8'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator8'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator8'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator8'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator8'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator8'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator8'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator8'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator8'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator8'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator9'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator9'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator9'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator9'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator9'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator9'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator9'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator9'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator9'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator9'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator9'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator9'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator10'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator10'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator10'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator10'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator10'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator10'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator10'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator10'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator10'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator10'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator10'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator10'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator11'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator11'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator11'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator11'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator11'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator11'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator11'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator11'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator11'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator11'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator11'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator11'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator12'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator12'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator12'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator12'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator12'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator12'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator12'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator12'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator12'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator12'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator12'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator12'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator13'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator13'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator13'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator13'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator13'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator13'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator13'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator13'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator13'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator13'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator13'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator13'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator14'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator14'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator14'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator14'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator14'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator14'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator14'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator14'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator14'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator14'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator14'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator14'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator15'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator15'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator15'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator15'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator15'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator15'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator15'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator15'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator15'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator15'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator15'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator15'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator16'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator16'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator16'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator16'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator16'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator16'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator16'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator16'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator16'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator16'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator16'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator16'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator17'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator17'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator17'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator17'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator17'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator17'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator17'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator17'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator17'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator17'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator17'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator17'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator18'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator18'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator18'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator18'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator18'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator18'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator18'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator18'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator18'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator18'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator18'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator18'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator19'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator19'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator19'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator19'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator19'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator19'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator19'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator19'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator19'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator19'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator19'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator19'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator20'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator20'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator20'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator20'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator20'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator20'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator20'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator20'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator20'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator20'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator20'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator20'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator21'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator21'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator21'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator21'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator21'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator21'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator21'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator21'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator21'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator21'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator21'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator21'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator22'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator22'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator22'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator22'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator22'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator22'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator22'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator22'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator22'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator22'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator22'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator22'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator23'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator23'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator23'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator23'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator23'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator23'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator23'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator23'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator23'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator23'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator23'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator23'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator24'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator24'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator24'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator24'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator24'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator24'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator24'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator24'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator24'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator24'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator24'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator24'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator25'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator25'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator25'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator25'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator25'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator25'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator25'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator25'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator25'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator25'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator25'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator25'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator26'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator26'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator26'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator26'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator26'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator26'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator26'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator26'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator26'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator26'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator26'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator26'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator27'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator27'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator27'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator27'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator27'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator27'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator27'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator27'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator27'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator27'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator27'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator27'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator28'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator28'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator28'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator28'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator28'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator28'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator28'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator28'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator28'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator28'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator28'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator28'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator29'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator29'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator29'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator29'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator29'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator29'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator29'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator29'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator29'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator29'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator29'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator29'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator30'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator30'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator30'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator30'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator30'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator30'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator30'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator30'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator30'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator30'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator30'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator30'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator31'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator31'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator31'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator31'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator31'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator31'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator31'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator31'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator31'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator31'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator31'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator31'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator32'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator32'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator32'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator32'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator32'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator32'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator32'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator32'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator32'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator32'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator32'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator32'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator33'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator33'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator33'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator33'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator33'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator33'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator33'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator33'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator33'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator33'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator33'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator33'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator34'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator34'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator34'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator34'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator34'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator34'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator34'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator34'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator34'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator34'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator34'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator34'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator35'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator35'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator35'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator35'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator35'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator35'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator35'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator35'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator35'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator35'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator35'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator35'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator36'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator36'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator36'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator36'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator36'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator36'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator36'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator36'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator36'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator36'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator36'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator36'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator37'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator37'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator37'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator37'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator37'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator37'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator37'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator37'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator37'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator37'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator37'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator37'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator38'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator38'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator38'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator38'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator38'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator38'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator38'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator38'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator38'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator38'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator38'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator38'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator39'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator39'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator39'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator39'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator39'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator39'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator39'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator39'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator39'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator39'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator39'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator39'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator40'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator40'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator40'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator40'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator40'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator40'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator40'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator40'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator40'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator40'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator40'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator40'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator41'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator41'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator41'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator41'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator41'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator41'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator41'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator41'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator41'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator41'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator41'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator41'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator42'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator42'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator42'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator42'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator42'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator42'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator42'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator42'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator42'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator42'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator42'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator42'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator43'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator43'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator43'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator43'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator43'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator43'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator43'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator43'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator43'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator43'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator43'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator43'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator44'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator44'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator44'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator44'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator44'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator44'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator44'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator44'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator44'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator44'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator44'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator44'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator45'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator45'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator45'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator45'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator45'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator45'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator45'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator45'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator45'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator45'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator45'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator45'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator46'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator46'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator46'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator46'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator46'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator46'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator46'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator46'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator46'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator46'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator46'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator46'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator47'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator47'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator47'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator47'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator47'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator47'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator47'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator47'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator47'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator47'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator47'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator47'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator48'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator48'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator48'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator48'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator48'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator48'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator48'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator48'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator48'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator48'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator48'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator48'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator49'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator49'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator49'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator49'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator49'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator49'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator49'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator49'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator49'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator49'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator49'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator49'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator50'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator50'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator50'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator50'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator50'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator50'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator50'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator50'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator50'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator50'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator50'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator50'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator51'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator51'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator51'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator51'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator51'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator51'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator51'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator51'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator51'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator51'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator51'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator51'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator52'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator52'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator52'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator52'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator52'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator52'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator52'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator52'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator52'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator52'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator52'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator52'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator53'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator53'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator53'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator53'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator53'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator53'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator53'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator53'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator53'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator53'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator53'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator53'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator54'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator54'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator54'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator54'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator54'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator54'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator54'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator54'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator54'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator54'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator54'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator54'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator55'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator55'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator55'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator55'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator55'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator55'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator55'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator55'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator55'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator55'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator55'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator55'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator56'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator56'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator56'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator56'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator56'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator56'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator56'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator56'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator56'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator56'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator56'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator56'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator57'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator57'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator57'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator57'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator57'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator57'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator57'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator57'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator57'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator57'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator57'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator57'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator58'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator58'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator58'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator58'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator58'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator58'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator58'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator58'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator58'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator58'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator58'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator58'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator59'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator59'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator59'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator59'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator59'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator59'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator59'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator59'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator59'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator59'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator59'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator59'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator60'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator60'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator60'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator60'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator60'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator60'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator60'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator60'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator60'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator60'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator60'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator60'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator61'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator61'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator61'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator61'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator61'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator61'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator61'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator61'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator61'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator61'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator61'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator61'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator62'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator62'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator62'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator62'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TenantUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator62'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator62'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator62'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator62'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'PageUpdate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator62'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionCreate')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator62'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionFind')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator62'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionList')
  ), 
  (
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator62'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SectionUpdate')
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
  navigation_bar_id,  
  menu_key,  
  label,  
  label_ar,  
  icon,  
  route
) VALUES
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '01_dashboard', 
          'Dashboard', 
          'لوحة التحكم', 
          'dashboard', 
          '/dashboard'
  ), 
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '02_accounts', 
          'Accounts', 
          'الحسابات', 
          'people', 
          NULL
  ), 
  (
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '03_system', 
          'System', 
          'النظام', 
          'settings', 
          NULL
  );
	


INSERT INTO accounts_schema.navigation_bar_item ( 
  route,  
  parent_id,  
  permission_id,  
  navigation_bar_id,  
  menu_key,  
  label,  
  label_ar,  
  icon
) VALUES
  (
          '/accounts/role', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '02_accounts'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'RoleList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '01_roles', 
          'Roles', 
          'الأدوار', 
          'group_users'
  ), 
  (
          '/accounts/user', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '02_accounts'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'UserList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '02_users', 
          'Users', 
          'المستخدمين', 
          'user_add'
  ), 
  (
          '/accounts/navigation', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '02_accounts'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'NavigationBarList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '03_navigation', 
          'Navigation', 
          'القوائم', 
          'maps'
  ), 
  (
          '/system/translation', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'TranslationList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '01_translations', 
          'Translations', 
          'الترجمات', 
          'globe'
  ), 
  (
          '/system/icon', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'IconList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '02_icons', 
          'Icons', 
          'الأيقونات', 
          'design'
  ), 
  (
          '/system/bucket', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'BucketList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '03_buckets', 
          'Buckets', 
          'المجلدات', 
          'folder'
  ), 
  (
          '/system/object', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'ObjectList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '04_files', 
          'Objects', 
          'الملفات', 
          'file'
  ), 
  (
          '/system/setting', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '03_system'), 
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'SettingList'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '05_settings', 
          'Settings', 
          'الإعدادات', 
          'settings_icon'
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
          (SELECT permission_id FROM accounts_schema.permission WHERE permission_function = 'UserCreate'), 
          (SELECT navigation_bar_id FROM accounts_schema.navigation_bar WHERE navigation_bar_name = 'admins backoffice'), 
          '02_users_create', 
          'Users Create', 
          'المستخدمين', 
          'user_verified', 
          '/accounts/users/create', 
          (SELECT navigation_bar_item_id FROM accounts_schema.navigation_bar_item WHERE menu_key = '02_users')
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
          'ahme@devkit.com', 
          '$2a$10$pCXIiMVv0LfyXS8p.S5PG.EdLh2F4/7YxHXl9McxCh4UL6.d5OXWW'
  ), 
  (
          'kareem', 
          (SELECT user_type_id FROM accounts_schema.user_type WHERE user_type_name = 'admin'), 
          '1202290100', 
          'kareem@devkit.com', 
          '$2a$10$d4ZiSsxWeGDKiV7gw/QNpO9Rp0jBr.X9SfXuvs2pXaWRi1Sl7Su/2'
  );
INSERT INTO accounts_schema.user_role ( 
  user_id,  
  role_id
) VALUES
  (
          (SELECT user_id FROM accounts_schema.user WHERE user_email = 'ahme@devkit.com'), 
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'super admin')
  ), 
  (
          (SELECT user_id FROM accounts_schema.user WHERE user_email = 'kareem@devkit.com'), 
          (SELECT role_id FROM accounts_schema.role WHERE role_name = 'moderator')
  );
	
