

INSERT INTO tenants_schema.tenant ( 
  tenant_address,  
  tenant_address_ar,  
  tenant_description_ar,  
  tenant_logo_vertical,  
  tenant_mission,  
  tenant_name_ar,  
  tenant_values,  
  tenant_description,  
  tenant_logo,  
  tenant_logo_dark,  
  tenant_vision,  
  tenant_email,  
  tenant_phone,  
  tenant_logo_dark_vertical,  
  tenant_name
) VALUES
  (
          'Madinet Elahlam, 724 El-Horeya Rd, لوران، Qesm AR Ramel، Alexandria Governorate 5451112', 
          'Madinet Elahlam, 724 El-Horeya Rd, لوران، Qesm AR Ramel، Alexandria Governorate 5451112', 
          'شركة اي بي سي هوتلز لديها القدرة على مساعدة أصحاب الأعمال في تأمين فرص الاستثمار والتخطيط لها من حيث الموقع والبناء والتنفيذ والتشغيل للفنادق والمنتجعات والشقق الفندقية والمطاعم. يمكن أن تدعم خبرات الشركة ومواردها أصحاب الأعمال طوال دورة حياة مشروع الضيافة بأكملها - من اختيار الموقع وتحليل الجدوى إلى التصميم والبناء والإدارة التشغيلية. يتيح النهج الشامل لشركة اي بي سي هوتلز للمستثمرين الاستفادة من سجل الشركة الحافل بالانجازات ومعرفتها الصناعية لتحقيق مشاريعهم في مجال الضيافة. بشكل عام، فإن شركة اي بي سي هوتلز في وضع يسمح لها بأن تكون شريكًا استراتيجيًا قيّمًا لأصحاب الأعمال الذين يسعون إلى الاستفادة من الفرص في قطاع الضيافة. ويمكن لقدرتها على تقديم الدعم الشامل تبسيط عملية الاستثمار وزيادة احتمالية الجدوى والربحية طويلة الأجل للمشروع.', 
          'tenats/abchotels.svg', 
          'To revolutionize technology', 
          ' ABC Hotels ', 
          'Innovation|Integrity|Excellence', 
          'The ABC Hotels company has the capability to assist business owners in securing investment opportunities and planning for them in terms of location, construction, implementation, and operation of hotels, resorts, service apartments, and restaurants  The company’s expertise and resources can support business owners throughout the entire life cycle of a hospitality project - from site selection and feasibility analysis to design, construction, and operational management. ABC Hotels’ comprehensive approach allows investors to leverage the company’s proven track record and industry knowledge to bring their hospitality ventures to fruition.  Overall, the ABC Hotels company is positioned to be a valuable strategic partner for business owners seeking to capitalize on opportunities in the hospitality sector. Its ability to provide end to-end support can streamline the investment process and increase the likelihood of a project’s long-term viability and profitability.', 
          'tenats/abchotels.svg', 
          'tenats/abchotels_light.svg', 
          'To be the global leader in tech', 
          'info@abchotels-eg.com', 
          '123456789', 
          'tenats/abchotels_light.svg', 
          'ABC Hotels'
  );
	


INSERT INTO tenants_schema.page ( 
  page_name,  
  page_name_ar,  
  page_description,  
  tenant_id,  
  page_route,  
  page_cover_video,  
  page_meta_description,  
  page_icon,  
  page_description_ar,  
  page_breadcrumb,  
  page_cover_image,  
  page_key_words
) VALUES
  (
          'Home', 
          'الصفحة الرئيسية', 
          'The main landing page', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/home', 
          'home_video.mp4', 
          'Welcome to our homepage', 
          'home', 
          'الصفحة الرئيسية الفعلية', 
          'Home', 
          'home_cover.png', 
          'landing,homepage,company'
  ), 
  (
          'About Us', 
          'من نحن', 
          'About our company', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/about', 
          'about_video.mp4', 
          'Learn more about us', 
          'about', 
          'عن شركتنا', 
          'About us', 
          'about_cover.png', 
          'about,company,info'
  ), 
  (
          'Projects', 
          'المشاريع', 
          'Our projects', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/projects', 
          'projects_video.mp4', 
          'Discover our work', 
          'projects', 
          'مشاريعنا', 
          'Projects', 
          'projects_cover.png', 
          'projects,portfolio,work'
  ), 
  (
          'Services', 
          'الخدمات', 
          'Services we offer', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/services', 
          'services_video.mp4', 
          'Explore our services', 
          'services', 
          'الخدمات التي نقدمها', 
          'Services', 
          'services_cover.png', 
          'services,offerings,solutions'
  ), 
  (
          'Gallery', 
          'الاستوديو', 
          'The company gallery', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/gallery', 
          'gallery_video.mp4', 
          'view abc hotels gallery ', 
          'gallery', 
          'الاستوديو', 
          'Gallery', 
          'gallery_cover.png', 
          'gallery,abc hotels gallery,abc hotels'
  ), 
  (
          'Contact', 
          'اتصل بنا', 
          'Contact us page', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/contact', 
          'contact_video.mp4', 
          'Get in touch with us', 
          'contact', 
          'صفحة اتصل بنا', 
          'Contact', 
          'contact_cover.png', 
          'contact,email,phone,location'
  );
	


INSERT INTO tenants_schema.section ( 
  section_name,  
  section_name_ar,  
  section_description,  
  page_id,  
  section_description_ar,  
  tenant_id,  
  section_background,  
  section_images,  
  section_button_label
) VALUES
  (
          'ABC Hotels: Attention to Basics & Culture', 
          'إقامة بلمسة فريدة  ', 
          'Where seamless management meets exceptional hospitality', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'about us'), 
          'من خلال إدارة متميزة وخدمة عالية الرفاهية 
', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'images/abchotels/banner.webp', 
          NULL, 
          'Explore Our Story'
  ), 
  (
          'home about', 
          'عن الشركة', 
          'Explore Our Story', 
          NULL, 
          'Step into a world of exceptional hospitality with ABC Hotels. With a perfect mix of expertise and commitment, ABC focuses on enhancing guest experiences while optimizing operations for property owners. From top-tier amenities to prime locations, every detail is carefully managed to ensure each stay is not just memorable, but a treasured experience for our guests', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'images/abchotes/rhactus_san.jpg', 
          NULL, 
          NULL
  ), 
  (
          'home services', 
          'الخدمات', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'home logos', 
          'اللوجوهات', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '/images/abchotels/logo-pretzel.webp,/images/abchotels/rhactuslogo.png,/images/abchotels/yalabina.png', 
          NULL
  ), 
  (
          'Our Concepts', 
          'اهدافنا', 
          'At ABC Hotels, we take great pride in managing a distinctive portfolio of hotels, each offering a unique combination of luxury, comfort, and personalized service. Whether it''s a peaceful seaside getaway, a vibrant city retreat, or a picturesque escape, our locations provide unforgettable experiences. Each property exemplifies our dedication to excellence, ensuring world-class amenities, exceptional hospitality, and meticulous attention to detail throughout our guests'' stay. ', 
          NULL, 
          ' نفخر في فنادق ABC بإدارة مجموعة مميزة من الفنادق، حيث يقدم كل منها مزيجًا فريدًا من الفخامة والراحة والخدمة الشخصية. سواء كان ذلك في إجازة هادئة على الشاطئ، أو ملاذًا حضريًا مفعمًا بالحيوية، أو إقامة ساحرة في أحد المدن المميزة، تستطيع مواقعنا توفير تجارب لا تُنسى.   كل مشروع يعكس التزامنا بالتميز، مما يضمن للضيوف مرافق من فئة عالمية، ضيافة استثنائية، وسلاسة أدق التفاصيل خلال إقامتهم. استكشف واختبر الفرق مع فنادق ABC.', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'about intro', 
          'عن الشركة', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          '/images/rhactus_alamein.webp,/images/rhactus-2.webp,/images/abchotels/rhactus_san.jpg', 
          NULL
  ), 
  (
          'Meet The Team', 
          'فريق العمل', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'services', 
          'الخدمات', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'projects', 
          'المشروعات', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'gallery', 
          'الاستوديو', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'contact us', 
          'اتصل بنا', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          NULL, 
          NULL, 
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
  section_id,  
  is_featured,  
  page_id,  
  partial_type_id
) VALUES
  (
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'ABC Hotels: Attention to Basics & Culture'), 
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Home'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'banner')
  ), 
  (
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'home about'), 
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Home'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service')
  ), 
  (
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'home services'), 
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Home'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service')
  ), 
  (
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'home logos'), 
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Home'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'logo')
  ), 
  (
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'Our Concepts'), 
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Home'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'hotel')
  ), 
  (
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'about intro'), 
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'About Us'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service')
  ), 
  (
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'Meet The Team'), 
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'About Us'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'team member')
  ), 
  (
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'services'), 
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Services'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service')
  ), 
  (
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'projects'), 
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Projects'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'project')
  ), 
  (
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'gallery'), 
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Gallery'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'gallery')
  ), 
  (
          (SELECT section_id FROM tenants_schema.section WHERE section_name = 'contact us'), 
          'FALSE', 
          (SELECT page_id FROM tenants_schema.page WHERE page_name = 'Contact'), 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service')
  );
	


INSERT INTO tenants_schema.partial ( 
  partial_name,  
  tenant_id,  
  partial_image,  
  partial_images,  
  partial_brief,  
  partial_link,  
  partial_button_icon,  
  partial_button_link,  
  partial_type_id,  
  partial_content,  
  partial_button_label,  
  partial_links
) VALUES
  (
          'Hotel Management & Operations', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/gallery/restuarant.webp', 
          NULL, 
          'ABC provides full-service management for its hotel properties, ensuring seamless operations, exceptional guest satisfaction, and consistent service excellence at all its locations.', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service'), 
          'ABC provides full-service management for its hotel properties, ensuring seamless operations, exceptional guest satisfaction, and consistent service excellence at all its locations.', 
          NULL, 
          NULL
  ), 
  (
          'F&B Catering', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/gallery/burger.webp', 
          'images/abchotels/logo-pretzel.webp', 
          'The company offers catering services for food and beverages offering a wide range of international and oriental cuisines. It''s also home to its very own food concept - Pretzel Burger.', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service'), 
          'The company offers catering services for food and beverages offering a wide range of international and oriental cuisines. It''s also home to its very own food concept - Pretzel Burger.', 
          NULL, 
          NULL
  ), 
  (
          'Yalabina Reservation Platform & P.M.S.', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/gallery/room.webp', 
          '/images/abchotels/yalabina.png', 
          'ABC has developed the “Yalabina” reservation platform and an upcoming property management system (PMS), designed to streamline and ensure precise operations as well as boost bookings.', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'home service'), 
          'ABC has developed the “Yalabina” reservation platform and an upcoming property management system (PMS), designed to streamline and ensure precise operations as well as boost bookings.  ', 
          NULL, 
          NULL
  ), 
  (
          'pretzel burgers logo', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/logo-pretzel.webp', 
          NULL, 
          NULL, 
          'https://pretzel.exploremelon.com/', 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'logo'), 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'yalabina logo', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/logo-pretzel.webp', 
          NULL, 
          NULL, 
          'https://yalabina.com/home', 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'logo'), 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'rhactus hotel logo', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/yalabina.png', 
          NULL, 
          NULL, 
          'https://rhactushotel.com/', 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'logo'), 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'Rhactus New Alamein', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/gallery/rhactuss.webp', 
          NULL, 
          'NEW ALAMEIN', 
          'https://rhactushotel.com/', 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'hotel'), 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'Rhactus House San Stefano', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/rhactus_san.webp', 
          NULL, 
          'ALEXANDRIA', 
          'https://rhss.rhactushotel.com/', 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'hotel'), 
          NULL, 
          NULL, 
          NULL
  ), 
  (
          'Abdel Hakim El Nahry', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/team/Hakim-El-Nahry.webp', 
          NULL, 
          'CEO and Co-founder', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'team member'), 
          'With over four decades of experience in the hospitality industry, Hakim has progressively ascended to leadership roles since 1993. Having held senior executive positions with renowned international hospitality companies and prominent global developers, he has demonstrated exceptional expertise and leadership in driving the growth and success of the industry.', 
          NULL, 
          NULL
  ), 
  (
          'Mohamed Ahmed', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/team/Mohamed-Ahmed.webp', 
          NULL, 
          'Member of the Board of Directors', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'team member'), 
          'With extensive experience in the hotel and resort industry since 1986, Mohamed has held several senior management positions, including Deputy General Manager and Director of the Food and Beverage sector. He has contributed to the success of renowned international hotels such as Novotel, Pyramisa, Sonesta, El Alamein Hotel, and Emaar Egypt (Marassi). His most recent position was Deputy General Manager and Food and Beverage Sector Manager at Emaar Misr.', 
          NULL, 
          NULL
  ), 
  (
          'Assem Kamal', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/team/Assem-Kamal.webp', 
          NULL, 
          'Member of the Board of Directors', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'team member'), 
          'With a wealth of experience in the hotel and resort industry since 2004, Assem has held several senior administrative roles, including General Manager of El Alamein Hotel and Director of the Rooms Sector. He has contributed to renowned international hotels such as Radisson Blu Dubai, Nuran Green Dubai, Address Dubai Hotel, El Alamein Hotel, and Emaar Misr (Marassi). His most recent position was General Manager of El Alamein Hotel, having previously served as Director of the Rooms Sector at Emaar Misr for a period of 10 years.', 
          NULL, 
          NULL
  ), 
  (
          'Mohamed Elkoumy', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/team/Mohamed-Nafea.webp', 
          NULL, 
          'Member of the Board of Directors', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'team member'), 
          'A distinguished board member with a specialization in tourism and property management, Mohamed brings valuable expertise in these sectors, contributing significantly to the strategic direction and growth of the company.', 
          NULL, 
          NULL
  ), 
  (
          'Hotel Management', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/team/Hakim-El-Nahry.webp', 
          NULL, 
          'Member of the Board of Directors', 
          NULL, 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          'With extensive experience in the hotel and resort industry since 2001, Mohamed has held several senior management positions, including Director of the Human Resources sector. He has been part of renowned international hotels such as Hilton Cairo Pyramids, Hilton Resort Hurghada, El Alamein Hotel, and Emaar Misr (Marassi). His most recent position was Director of the Human Resources Sector at Emaar Egypt (Marassi), where he served for 10 years.', 
          NULL, 
          NULL
  ), 
  (
          'Hospitality Services', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/services/HospitalityServices.webp', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          'ABC Hotels provides top-tier hotel management services that capitalize on enhancing operational performance, maximizing revenue, and maintaining the integrity of every property it manages.', 
          'View Website', 
          NULL
  ), 
  (
          'Food and Beverage', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/services/FoodAndBeverage.webp', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          'ABC Hotels specializes in providing comprehensive hospitality services designed to enhance both the guest experience and operational efficiency. Our offerings are tailored for both hotel and community management, ensuring smooth day-to-day operations and a welcoming atmosphere.', 
          NULL, 
          NULL
  ), 
  (
          'Consultancy', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/services/Consultancy.webp', 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          NULL, 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'service'), 
          'Our food and beverage quality assurance ensure top-tier quality, safety, and cost-effectiveness, providing exceptional dining experiences while optimizing operations.', 
          NULL, 
          NULL
  ), 
  (
          'Rhactus New Alamein', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/rhactus_alamein.webp', 
          NULL, 
          NULL, 
          NULL, 
          'external-link', 
          'https://rhactushotel.com/', 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'project'), 
          'A luxurious hotel complex in the heart of New Alamein City, offering modern amenities and premium hospitality services tailored for both leisure and business travelers. Experience unparalleled comfort and sophistication in a prime location, designed to meet the needs of discerning guests', 
          'View Website', 
          '{   "facebook": "https://www.facebook.com/profile.php?id=61565334736199",   "instagram": "https://www.instagram.com/rhactushousesanstefano",   "linkedin": "https://www.linkedin.com/company/rhactushousesanstefano/" }'
  ), 
  (
          'Rhactus House - San Stefano', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/rhactus_san.webp', 
          NULL, 
          NULL, 
          NULL, 
          'external-link', 
          'https://rhss.rhactushotel.com/', 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'project'), 
          'Boutique serviced apartments in Alexandria''s prime location, combining historical charm with modern luxury and Mediterranean views.', 
          'View Website', 
          '{   "instagram": "https://www.instagram.com/rhactushousesanstefano/",   "linkedin": "https://www.linkedin.com/company/rhactushousesanstefano?fbclid=PAZXh0bgNhZW0CMTEAAaYKUBr7SX_dyOA9vFzYVlZwoFv2juCymvJ6WE9uoiJwk6lVwNWUlOS61yM_aem_RFHPj3k_Hkn66AP_ay4_jg" }'
  ), 
  (
          'Pretzel Burgers', 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          '/images/abchotels/pretzel.webp', 
          NULL, 
          NULL, 
          NULL, 
          'external-link', 
          'https://pretzel.exploremelon.com/', 
          (SELECT partial_type_id FROM tenants_schema.partial_type WHERE partial_type_name = 'project'), 
          'Our flagship gourmet burger restaurant concept, offering artisanal sandwiches crafted with premium ingredients, currently operating within ABC Hotel properties. Experience a unique blend of flavors and culinary excellence in a vibrant dining atmosphere.', 
          'View Website', 
          '{   "facebook": "https://www.facebook.com/pretzelburgers.eg?mibextid=ZbWKwL",   "instagram": "https://www.instagram.com/pretzelburgers.eg/?igshid=MzRlODBiNWFlZA%3D%3D" }'
  );
	
