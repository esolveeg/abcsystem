

INSERT INTO tenants_schema.tenant ( 
  tenant_id,  
  tenant_phone,  
  tenant_email,  
  tenant_logo_dark,  
  tenant_description,  
  tenant_logo,  
  tenant_logo_dark_vertical,  
  tenant_name,  
  tenant_name_ar,  
  tenant_address_ar,  
  tenant_description_ar,  
  tenant_values,  
  tenant_address,  
  tenant_logo_vertical,  
  tenant_mission,  
  tenant_vision
) VALUES
  (
          '1', 
          '123456789', 
          'info@techcorp.com', 
          'logo_dark.png', 
          'Leading technology solutions tenant', 
          'logo.png', 
          'logo_dark_vertical.png', 
          'ABC Hotels', 
          'شركة التقنية', 
          'شارع التقنية 123، وادي السيليكون', 
          'شركة رائدة في حلول التقنية', 
          'Innovation|Integrity|Excellence', 
          '123 Tech Street, Silicon Valley', 
          'logo_vertical.png', 
          'To revolutionize technology', 
          'To be the global leader in tech'
  );
	


INSERT INTO tenants_schema.page ( 
  page_cover_image,  
  page_cover_video,  
  page_key_words,  
  page_name_ar,  
  page_description,  
  page_breadcrumb,  
  page_route,  
  page_meta_description,  
  page_icon,  
  page_name,  
  page_description_ar,  
  tenant_id
) VALUES
  (
          'home_cover.png', 
          'home_video.mp4', 
          'landing,homepage,tenant', 
          'الصفحة الرئيسية', 
          'The main landing page', 
          'home', 
          '/home', 
          'Welcome to our homepage', 
          'home', 
          'Home', 
          'الصفحة الرئيسية الفعلية', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels')
  ), 
  (
          'about_cover.png', 
          'about_video.mp4', 
          'about,tenant,info', 
          'من نحن', 
          'About our tenant', 
          'about', 
          '/about', 
          'Learn more about us', 
          'about', 
          'About', 
          'عن شركتنا', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels')
  ), 
  (
          'blog_cover.png', 
          'blog_video.mp4', 
          'blog,articles,news', 
          'المدونة', 
          'The tenant blog', 
          'blog', 
          '/blog', 
          'Read our latest articles', 
          'blog', 
          'Blog', 
          'مدونة الشركة', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels')
  ), 
  (
          'projects_cover.png', 
          'projects_video.mp4', 
          'projects,portfolio,work', 
          'المشاريع', 
          'Our projects', 
          'projects', 
          '/projects', 
          'Discover our work', 
          'projects', 
          'Projects', 
          'مشاريعنا', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels')
  ), 
  (
          'services_cover.png', 
          'services_video.mp4', 
          'services,offerings,solutions', 
          'الخدمات', 
          'Services we offer', 
          'services', 
          '/services', 
          'Explore our services', 
          'services', 
          'Services', 
          'الخدمات التي نقدمها', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels')
  ), 
  (
          'contact_cover.png', 
          'contact_video.mp4', 
          'contact,email,phone,location', 
          'اتصل بنا', 
          'Contact us page', 
          'contact', 
          '/contact', 
          'Get in touch with us', 
          'contact', 
          'Contact', 
          'صفحة اتصل بنا', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels')
  );
	
