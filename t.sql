

INSERT INTO tenants_schema.tenant ( 
  tenant_phone,  
  tenant_email,  
  tenant_logo_dark_vertical,  
  tenant_values,  
  tenant_vision,  
  tenant_links,  
  tenant_address,  
  tenant_address_ar,  
  tenant_description,  
  tenant_logo_dark,  
  tenant_mission,  
  tenant_name_ar,  
  tenant_description_ar,  
  tenant_logo,  
  tenant_logo_vertical,  
  tenant_name
) VALUES
  (
          '123456789', 
          'info@abchotels-eg.com', 
          'tenats/abchotels_light.svg', 
          'Innovation|Integrity|Excellence', 
          'To be the global leader in tech', 
          '{   "facebook": "https://www.facebook.com/profile.php?id=61565334736199",   "instagram": "https://www.instagram.com/rhactushousesanstefano",   "linkedin": "https://www.linkedin.com/company/rhactushousesanstefano/" }', 
          'Madinet Elahlam, 724 El-Horeya Rd, لوران، Qesm AR Ramel، Alexandria Governorate 5451112', 
          'Madinet Elahlam, 724 El-Horeya Rd, لوران، Qesm AR Ramel، Alexandria Governorate 5451112', 
          'The ABC Hotels company has the capability to assist business owners in securing investment opportunities and planning for them in terms of location, construction, implementation, and operation of hotels, resorts, service apartments, and restaurants  The company’s expertise and resources can support business owners throughout the entire life cycle of a hospitality project - from site selection and feasibility analysis to design, construction, and operational management. ABC Hotels’ comprehensive approach allows investors to leverage the company’s proven track record and industry knowledge to bring their hospitality ventures to fruition.  Overall, the ABC Hotels company is positioned to be a valuable strategic partner for business owners seeking to capitalize on opportunities in the hospitality sector. Its ability to provide end to-end support can streamline the investment process and increase the likelihood of a project’s long-term viability and profitability.', 
          'tenats/abchotels_light.svg', 
          'To revolutionize technology', 
          ' ABC Hotels ', 
          'شركة اي بي سي هوتلز لديها القدرة على مساعدة أصحاب الأعمال في تأمين فرص الاستثمار والتخطيط لها من حيث الموقع والبناء والتنفيذ والتشغيل للفنادق والمنتجعات والشقق الفندقية والمطاعم. يمكن أن تدعم خبرات الشركة ومواردها أصحاب الأعمال طوال دورة حياة مشروع الضيافة بأكملها - من اختيار الموقع وتحليل الجدوى إلى التصميم والبناء والإدارة التشغيلية. يتيح النهج الشامل لشركة اي بي سي هوتلز للمستثمرين الاستفادة من سجل الشركة الحافل بالانجازات ومعرفتها الصناعية لتحقيق مشاريعهم في مجال الضيافة. بشكل عام، فإن شركة اي بي سي هوتلز في وضع يسمح لها بأن تكون شريكًا استراتيجيًا قيّمًا لأصحاب الأعمال الذين يسعون إلى الاستفادة من الفرص في قطاع الضيافة. ويمكن لقدرتها على تقديم الدعم الشامل تبسيط عملية الاستثمار وزيادة احتمالية الجدوى والربحية طويلة الأجل للمشروع.', 
          'tenats/abchotels.svg', 
          'tenats/abchotels.svg', 
          'ABC Hotels'
  );
	


INSERT INTO tenants_schema.page ( 
  page_key_words,  
  page_name,  
  page_name_ar,  
  page_description_ar,  
  tenant_id,  
  page_cover_image,  
  page_icon,  
  page_description,  
  page_breadcrumb,  
  page_route,  
  page_cover_video,  
  page_meta_description
) VALUES
  (
          'landing,homepage,company', 
          'Home', 
          'الصفحة الرئيسية', 
          'الصفحة الرئيسية الفعلية', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'home_cover.png', 
          'home', 
          'The main landing page', 
          'Home', 
          '/home', 
          'home_video.mp4', 
          'Welcome to our homepage'
  ), 
  (
          'about,company,info', 
          'About Us', 
          'من نحن', 
          'عن شركتنا', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'about_cover.png', 
          'about', 
          'About our company', 
          'About us', 
          '/about', 
          'about_video.mp4', 
          'Learn more about us'
  ), 
  (
          'projects,portfolio,work', 
          'Projects', 
          'المشاريع', 
          'مشاريعنا', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'projects_cover.png', 
          'projects', 
          'Our projects', 
          'Projects', 
          '/projects', 
          'projects_video.mp4', 
          'Discover our work'
  ), 
  (
          'services,offerings,solutions', 
          'Services', 
          'الخدمات', 
          'الخدمات التي نقدمها', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'services_cover.png', 
          'services', 
          'Services we offer', 
          'Services', 
          '/services', 
          'services_video.mp4', 
          'Explore our services'
  ), 
  (
          'gallery,abc hotels gallery,abc hotels', 
          'Gallery', 
          'الاستوديو', 
          'الاستوديو', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'gallery_cover.png', 
          'gallery', 
          'The company gallery', 
          'Gallery', 
          '/gallery', 
          'gallery_video.mp4', 
          'view abc hotels gallery '
  ), 
  (
          'contact,email,phone,location', 
          'Contact', 
          'اتصل بنا', 
          'صفحة اتصل بنا', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'contact_cover.png', 
          'contact', 
          'Contact us page', 
          'Contact', 
          '/contact', 
          'contact_video.mp4', 
          'Get in touch with us'
  );
	


INSERT INTO tenants_schema.section ( 
  section_name_ar,  
  section_description,  
  section_description_ar,  
  tenant_id,  
  section_background,  
  section_images,  
  section_button_label,  
  section_name,  
  section_header_ar,  
  section_header,  
  section_button_page_id
) VALUES
  (
          'الصورة الافتاحية', 
          'Where seamless management meets exceptional hospitality', 
          'من خلال إدارة متميزة وخدمة عالية الرفاهية 
', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/abchotels/banner.webp', 
          NULL, 
          'Explore Our Story', 
          'home banner', 
          'إقامة بلمسة فريدة  ', 
          ' ABC Hotels <br />  <small>Attention to Basics & Culture</small> ', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'about us')
  ), 
  (
          'عن الشركة', 
          'Step into a world of exceptional hospitality with ABC Hotels. With a perfect mix of expertise and commitment, ABC focuses on enhancing guest experiences while optimizing operations for property owners. From top-tier amenities to prime locations, every detail is carefully managed to ensure each stay is not just memorable, but a treasured experience for our guests', 
          'Step into a world of exceptional hospitality with ABC Hotels. With a perfect mix of expertise and commitment, ABC focuses on enhancing guest experiences while optimizing operations for property owners. From top-tier amenities to prime locations, every detail is carefully managed to ensure each stay is not just memorable, but a treasured experience for our guests', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/abchotels/rhactus_san.webp', 
          NULL, 
          NULL, 
          'home about', 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'الخدمات', 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL, 
          'home services', 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'اهدافنا', 
          'At ABC Hotels, we take great pride in managing a distinctive portfolio of hotels, each offering a unique combination of luxury, comfort, and personalized service. Whether it''s a peaceful seaside getaway, a vibrant city retreat, or a picturesque escape, our locations provide unforgettable experiences. Each property exemplifies our dedication to excellence, ensuring world-class amenities, exceptional hospitality, and meticulous attention to detail throughout our guests'' stay. ', 
          ' نفخر في فنادق ABC بإدارة مجموعة مميزة من الفنادق، حيث يقدم كل منها مزيجًا فريدًا من الفخامة والراحة والخدمة الشخصية. سواء كان ذلك في إجازة هادئة على الشاطئ، أو ملاذًا حضريًا مفعمًا بالحيوية، أو إقامة ساحرة في أحد المدن المميزة، تستطيع مواقعنا توفير تجارب لا تُنسى.   كل مشروع يعكس التزامنا بالتميز، مما يضمن للضيوف مرافق من فئة عالمية، ضيافة استثنائية، وسلاسة أدق التفاصيل خلال إقامتهم. استكشف واختبر الفرق مع فنادق ABC.', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL, 
          'hotels', 
          NULL, 
          'Our Concepts', 
          NULL
  ), 
  (
          'عن الشركة', 
          '<p class="mb-3"> The ABC Hotels company has the capability to assist business owners in securing investment opportunities and planning for them in terms of location, construction, implementation, and operation of hotels, resorts, service apartments, and restaurants </p> <p class="mb-3"> The company’s expertise and resources can support business owners throughout the entire life cycle of a hospitality project - from site selection and feasibility analysis to design, construction, and operational management. ABC Hotels’ comprehensive approach allows investors to leverage the company’s proven track record and industry knowledge to bring their hospitality ventures to fruition. </p> <p> Overall, the ABC Hotels company is positioned to be a valuable strategic partner for business owners seeking to capitalize on opportunities in the hospitality sector. Its ability to provide end to-end support can streamline the investment process and increase the likelihood of a project’s long-term viability and profitability. </p>', 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '/abchotels/rhactus_alamein.webp,/abchotels/rhactus-2.webp,/abchotels/rhactus_san.webp', 
          NULL, 
          'about intro', 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'فريق العمل', 
          'ABC Hotels’ leadership team is comprised of seasoned hospitality experts with extensive industry experience and commitment to excellence. The team’s expertise spans senior executive positions at renowned international hospitality companies and developers. ABC Hotels’ founders have a proven track record of managing world-class hospitality projects, and a deep understanding of local and international concepts, thus introducing local cultures to the international communities.', 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL, 
          'team', 
          NULL, 
          'Meet The Team', 
          NULL
  ), 
  (
          'الخدمات', 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL, 
          'services', 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'المشروعات', 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL, 
          'projects', 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'الاستوديو', 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL, 
          'gallery', 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'اتصل بنا', 
          'At ABC Hotels, your comfort and satisfaction are our highest priorities. If you have any questions regarding your reservation, need assistance with planning your stay, or want to learn more about our exclusive offers and services, we're here to assist you.', 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL, 
          'contact us', 
          NULL, 
          'contact us', 
          NULL
  );
	


INSERT INTO tenants_schema.partial_type ( 
  partial_type_name
) VALUES
  (
          'home service'
  ), 
  (
          'logo'
  ), 
  (
          'hotel'
  ), 
  (
          'team member'
  ), 
  (
          'service'
  ), 
  (
          'project'
  ), 
  (
          'gallery'
  ), 
  (
          'banner'
  );
	


INSERT INTO tenants_schema.page_section ( 
  is_featured,  
  page_id,  
  partial_type_id,  
  section_id
) VALUES
  (
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Home'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'banner'), 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'home banner')
  ), 
  (
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Home'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service'), 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'home about')
  ), 
  (
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Home'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service'), 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'home services')
  ), 
  (
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Home'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'hotel'), 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'hotels')
  ), 
  (
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'About Us'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service'), 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'about intro')
  ), 
  (
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'About Us'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'team member'), 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'team')
  ), 
  (
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Services'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'services')
  ), 
  (
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Projects'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'project'), 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'projects')
  ), 
  (
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Gallery'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'gallery'), 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'gallery')
  ), 
  (
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Contact'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'contact us')
  );
	


INSERT INTO tenants_schema.partial ( 
  partial_image,  
  partial_brief,  
  partial_button_label,  
  partial_button_icon,  
  partial_button_link,  
  address,  
  partial_name,  
  section_id,  
  partial_type_id,  
  partial_images,  
  partial_content,  
  partial_link,  
  partial_links
) VALUES
  (
          'abchotels/restuarant.webp', 
          'ABC provides full-service management for its hotel properties, ensuring seamless operations, exceptional guest satisfaction, and consistent service excellence at all its locations.', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Hotel Management & Operations', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'home services'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service'), 
          NULL, 
          'ABC provides full-service management for its hotel properties, ensuring seamless operations, exceptional guest satisfaction, and consistent service excellence at all its locations.', 
          NULL, 
          NULL
  ), 
  (
          'abchotels/pretzel.webp', 
          'The company offers catering services for food and beverages offering a wide range of international and oriental cuisines. It''s also home to its very own food concept - Pretzel Burger.', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Pretzel', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'home services'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service'), 
          '/abchotels/logo-pretzel.webp', 
          'The company offers catering services for food and beverages offering a wide range of international and oriental cuisines. It''s also home to its very own food concept - Pretzel Burger.', 
          NULL, 
          NULL
  ), 
  (
          'abchotels/rhactus_alamein.webp', 
          'ABC has developed the “Yalabina” reservation platform and an upcoming property management system (PMS), designed to streamline and ensure precise operations as well as boost bookings.', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Yalabina Reservation Platform ', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'home services'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service'), 
          '/abchotels/rhactus_alamein.webp', 
          'ABC has developed the “Yalabina” reservation platform and an upcoming property management system (PMS), designed to streamline and ensure precise operations as well as boost bookings.  ', 
          NULL, 
          NULL
  ), 
  (
          'abchotels/rhactus_alamein.webp', 
          'ABC has developed the “Yalabina” reservation platform and an upcoming property management system (PMS), designed to streamline and ensure precise operations as well as boost bookings.', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Property Management System (P.M.S).', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'home services'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service'), 
          '/abchotels/rhactus_alamein.webp', 
          'ABC has developed the “Yalabina” reservation platform and an upcoming property management system (PMS), designed to streamline and ensure precise operations as well as boost bookings.  ', 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/gallery-12.webp', 
          'NEW ALAMEIN', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Rhactus New Alamein', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'hotels'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'hotel'), 
          NULL, 
          NULL, 
          'https://rhactushotel.com/', 
          NULL
  ), 
  (
          '/abchotels/rhactus_san.webp', 
          'ALEXANDRIA', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Rhactus House San Stefano', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'hotels'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'hotel'), 
          NULL, 
          NULL, 
          'https://rhss.rhactushotel.com/', 
          NULL
  ), 
  (
          '/abchotels/team_Hakim-El-Nahry.webp', 
          'CEO and Co-founder', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Abdel Hakim El Nahry', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'team'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'team member'), 
          NULL, 
          'With over four decades of experience in the hospitality industry, Hakim has progressively ascended to leadership roles since 1993. Having held senior executive positions with renowned international hospitality companies and prominent global developers, he has demonstrated exceptional expertise and leadership in driving the growth and success of the industry.', 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/team_Mohamed-Ahmed.webp', 
          'Member of the Board of Directors', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Mohamed Ahmed', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'team'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'team member'), 
          NULL, 
          'With extensive experience in the hotel and resort industry since 1986, Mohamed has held several senior management positions, including Deputy General Manager and Director of the Food and Beverage sector. He has contributed to the success of renowned international hotels such as Novotel, Pyramisa, Sonesta, El Alamein Hotel, and Emaar Egypt (Marassi). His most recent position was Deputy General Manager and Food and Beverage Sector Manager at Emaar Misr.', 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/team_Assem-Kamal.webp', 
          'Member of the Board of Directors', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Assem Kamal', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'team'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'team member'), 
          NULL, 
          'With a wealth of experience in the hotel and resort industry since 2004, Assem has held several senior administrative roles, including General Manager of El Alamein Hotel and Director of the Rooms Sector. He has contributed to renowned international hotels such as Radisson Blu Dubai, Nuran Green Dubai, Address Dubai Hotel, El Alamein Hotel, and Emaar Misr (Marassi). His most recent position was General Manager of El Alamein Hotel, having previously served as Director of the Rooms Sector at Emaar Misr for a period of 10 years.', 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/team_Mohamed-El-Koumy.webp', 
          'Member of the Board of Directors', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Mohamed Elkoumy', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'team'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'team member'), 
          NULL, 
          'A distinguished board member with a specialization in tourism and property management, Mohamed brings valuable expertise in these sectors, contributing significantly to the strategic direction and growth of the company.', 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/team_Mohamed-Nafea.webp', 
          'Member of the Board of Directors', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Mohamed Elkoumy', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'team'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'team member'), 
          NULL, 
          'A distinguished board member with a specialization in tourism and property management, Mohamed brings valuable expertise in these sectors, contributing significantly to the strategic direction and growth of the company.', 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/rhactus_san.webp', 
          'Member of the Board of Directors', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Hotel Management', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'services'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          NULL, 
          'A distinguished board member with a specialization in tourism and property management, Mohamed brings valuable expertise in these sectors, contributing significantly to the strategic direction and growth of the company.', 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/service-culture.webp', 
          NULL, 
          'View Website', 
          NULL, 
          NULL, 
          NULL, 
          'Hospitality Services', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'services'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          NULL, 
          'ABC Hotels provides top-tier hotel management services that capitalize on enhancing operational performance, maximizing revenue, and maintaining the integrity of every property it manages.', 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/vida.webp', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Hotel Apartment Services', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'services'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          NULL, 
          'We offer a complete range of hotel apartment services, providing long-term guests with the ideal combination of home-like comfort with luxurious hotel amenities.', 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/FoodAndBeverage.webp', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Food and Beverage', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'services'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          NULL, 
          'ABC Hotels specializes in providing comprehensive hospitality services designed to enhance both the guest experience and operational efficiency. Our offerings are tailored for both hotel and community management, ensuring smooth day-to-day operations and a welcoming atmosphere.', 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/Consultancy.webp', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'Consultancy', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'services'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          NULL, 
          'Our food and beverage quality assurance ensure top-tier quality, safety, and cost-effectiveness, providing exceptional dining experiences while optimizing operations.', 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/yb.webp', 
          NULL, 
          'yalabina', 
          'send', 
          'https://yalabina.com', 
          NULL, 
          'Yalabina', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'services'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          NULL, 
          'Yalabina is the ultimate platform from ABC Hotels, offering guests a seamless experience from discovering our properties to securing their reservations with ease.', 
          'https://yalabina.com', 
          NULL
  ), 
  (
          '/abchotels/rhactus_alamein.webp', 
          NULL, 
          'View Website', 
          'external-link', 
          'https://rhactushotel.com/', 
          'North Coast, K102 Alexandria - Marsa Matrouh Coastal Road, New Alamein City, 51718 El Alamein, Egypt', 
          'Rhactus New Alamein', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'projects'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'project'), 
          NULL, 
          'A luxurious hotel complex in the heart of New Alamein City, offering modern amenities and premium hospitality services tailored for both leisure and business travelers. Experience unparalleled comfort and sophistication in a prime location, designed to meet the needs of discerning guests', 
          NULL, 
          '{   "facebook": "https://www.facebook.com/profile.php?id=61565334736199",   "instagram": "https://www.instagram.com/rhactushousesanstefano",   "linkedin": "https://www.linkedin.com/company/rhactushousesanstefano/" }'
  ), 
  (
          '/abchotels/rhactus_san.webp', 
          NULL, 
          'View Website', 
          'external-link', 
          'https://rhss.rhactushotel.com/', 
          '402 El-Gaish Road, 5452054 Alexandria', 
          'Rhactus House - San Stefano', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'projects'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'project'), 
          NULL, 
          'Boutique serviced apartments in Alexandria''s prime location, combining historical charm with modern luxury and Mediterranean views.', 
          NULL, 
          '{   "instagram": "https://www.instagram.com/rhactushousesanstefano/",   "linkedin": "https://www.linkedin.com/company/rhactushousesanstefano?fbclid=PAZXh0bgNhZW0CMTEAAaYKUBr7SX_dyOA9vFzYVlZwoFv2juCymvJ6WE9uoiJwk6lVwNWUlOS61yM_aem_RFHPj3k_Hkn66AP_ay4_jg" }'
  ), 
  (
          '/abchotels/rhactus_alamein.webp', 
          NULL, 
          'View Website', 
          'external-link', 
          'https://rhactushotel.com/', 
          'North Coast, K102 Alexandria - Marsa Matrouh Coastal Road, New Alamein City, 51718 El Alamein, Egypt', 
          'Rhactus Hotel - Borg Al Arab', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'projects'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'project'), 
          NULL, 
          'A luxurious hotel complex in the heart of New Alamein City, offering modern amenities and premium hospitality services tailored for both leisure and business travelers. Experience unparalleled comfort and sophistication in a prime location, designed to meet the needs of discerning guests', 
          NULL, 
          '{   "facebook": "https://www.facebook.com/profile.php?id=61565334736199",   "instagram": "https://www.instagram.com/rhactushousesanstefano",   "linkedin": "https://www.linkedin.com/company/rhactushousesanstefano/" }'
  ), 
  (
          '/abchotels/rhactus_alamein.webp', 
          NULL, 
          'View Website', 
          'external-link', 
          'https://rhactushotel.com/', 
          'North Coast, K102 Alexandria - Marsa Matrouh Coastal Road, New Alamein City, 51718 El Alamein, Egypt', 
          'Marsa Wazar', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'projects'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'project'), 
          NULL, 
          'A luxurious hotel complex in the heart of New Alamein City, offering modern amenities and premium hospitality services tailored for both leisure and business travelers. Experience unparalleled comfort and sophistication in a prime location, designed to meet the needs of discerning guests', 
          NULL, 
          '{   "facebook": "https://www.facebook.com/profile.php?id=61565334736199",   "instagram": "https://www.instagram.com/rhactushousesanstefano",   "linkedin": "https://www.linkedin.com/company/rhactushousesanstefano/" }'
  ), 
  (
          '/abchotels/gallery-2.webp', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'gallery image 1', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'gallery'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'gallery'), 
          NULL, 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/gallery-3.webp', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'gallery image 2', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'gallery'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'gallery'), 
          NULL, 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          '/abchotels/gallery-3.webp', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          'gallery image 3', 
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'gallery'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'gallery'), 
          NULL, 
          NULL, 
          NULL, 
          NULL
  );
	
