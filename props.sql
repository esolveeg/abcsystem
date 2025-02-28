

INSERT INTO properties_schema.amenity_value_type ( 
  amenity_value_type
) VALUES
  (
          'number'
  ), 
  (
          'text'
  ), 
  (
          'toggle'
  );
	


INSERT INTO properties_schema.property_category ( 
  property_category_name
) VALUES
  (
          'hotels'
  ), 
  (
          'others'
  );
	


INSERT INTO properties_schema.reservable_unit_type ( 
  reservable_unit_type_name,  
  property_category_id,  
  rooms_count
) VALUES
  (
          'Deluxe Family', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels'), 
          '1'
  ), 
  (
          'Deluxe King', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels'), 
          '1'
  ), 
  (
          'Premium King', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels'), 
          '1'
  ), 
  (
          'Deluxe Triple', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels'), 
          '1'
  ), 
  (
          'Deluxe Twin', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels'), 
          '1'
  ), 
  (
          'Royal Suite', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels'), 
          '4'
  ), 
  (
          'one bedroom apartment', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'others'), 
          '1'
  ), 
  (
          'two-bedroom apartment', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'others'), 
          '2'
  ), 
  (
          'three-bedroom apartment', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'others'), 
          '3'
  ), 
  (
          'Villa', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'others'), 
          '5'
  );
	


INSERT INTO properties_schema.property_type ( 
  property_type_name,  
  property_category_id
) VALUES
  (
          'apartment', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'others')
  ), 
  (
          'chalet', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'others')
  ), 
  (
          'hotel', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels')
  ), 
  (
          'inn', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels')
  ), 
  (
          'motel', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels')
  ), 
  (
          'tent', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'others')
  ), 
  (
          'villa', 
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'others')
  );
	


INSERT INTO properties_schema.bed_type ( 
  bed_type,  
  bed_length,  
  bed_width
) VALUES
  (
          'extra-large double bed', 
          '80', 
          '76'
  ), 
  (
          'single bed', 
          '75', 
          '30'
  );
	


INSERT INTO properties_schema.amenity_group ( 
  property_category_id,  
  amenity_group_name
) VALUES
  (
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels'), 
          'General Facilities'
  ), 
  (
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels'), 
          'Room Amenities'
  ), 
  (
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels'), 
          'Business Facilities'
  ), 
  (
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels'), 
          'General Amenities'
  ), 
  (
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels'), 
          'Health and Wellness'
  ), 
  (
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'hotels'), 
          'Activities'
  ), 
  (
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'others'), 
          'Safety and Security'
  ), 
  (
          (SELECT property_category_id FROM properties_schema.property_category WHERE property_category_name = 'others'), 
          'Cleaning Services'
  );
	


INSERT INTO properties_schema.amenity ( 
  amenity_icon,  
  amenity_value_type_id,  
  amenity_input_label,  
  amenity_group_id,  
  amenity_name
) VALUES
  (
          'Fitness', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Fitness Centre', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Activities'), 
          'Fitness Centre'
  ), 
  (
          'Golf', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Nearby Golf Course', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Activities'), 
          'Golf Course (within 3 km)'
  ), 
  (
          'Jacuzzi', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Hot Tub/Jacuzzi', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Activities'), 
          'Hot Tub/Jacuzzi'
  ), 
  (
          'Massage', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Massage Service', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Activities'), 
          'Massage'
  ), 
  (
          'Meeting', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Meeting/Banquet Facilities', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Business Facilities'), 
          'Meeting/Banquet Facilities'
  ), 
  (
          'Patio', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Patio', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Business Facilities'), 
          'Patio'
  ), 
  (
          'Sea', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Sea View', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Business Facilities'), 
          'Sea View'
  ), 
  (
          'CCTV', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has CCTV in Common Areas', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Cleaning Services'), 
          'CCTV in Common Areas'
  ), 
  (
          'Dry_clean', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Dry Cleaning Service', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Cleaning Services'), 
          'Dry Cleaning'
  ), 
  (
          'Fire_ext', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Fire Extinguishers', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Cleaning Services'), 
          'Fire Extinguishers'
  ), 
  (
          'Ironing', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Ironing Service', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Cleaning Services'), 
          'Ironing Service'
  ), 
  (
          'Laundry', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Laundry Service', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Cleaning Services'), 
          'Laundry'
  ), 
  (
          'Business', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Business Centre', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Amenities'), 
          'Business Centre'
  ), 
  (
          'Disabled', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Facilities for Disabled Guests', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Amenities'), 
          'Facilities for Disabled Guests'
  ), 
  (
          'camera', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Fax/Photocopying Service', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Amenities'), 
          'Fax/Photocopying'
  ), 
  (
          'Non-smoking', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Non-smoking Rooms', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Amenities'), 
          'Non-smoking Rooms'
  ), 
  (
          'Front_office', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has 24-hour Front Desk', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          '24-hour Front Desk'
  ), 
  (
          'Airport', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Provides Airport Shuttle', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Airport Shuttle'
  ), 
  (
          'Babysitting', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Provides Babysitting/Child Services', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Babysitting/Child Services'
  ), 
  (
          'Bar', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Bar', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Bar'
  ), 
  (
          'shower-head', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Bath with rain shower', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Bath with rain shower'
  ), 
  (
          'menu', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'number'), 
          'Library Nearby', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Bibliotheca Alexandrina'
  ), 
  (
          'Bicycle', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Provides Bicycle Rental', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Bicycle Rental'
  ), 
  (
          'Breakfast', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Offers Breakfast in Room', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Breakfast in the Room'
  ), 
  (
          'Car', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Provides Car Hire', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Car Hire'
  ), 
  (
          'Playground', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Childrens Playground', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Childrens Playground'
  ), 
  (
          'Concierge', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Concierge Service', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Concierge Service'
  ), 
  (
          'Free WiFi', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Offers Free Wifi', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Free Wifi'
  ), 
  (
          'fridge', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Fridge', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Fridge'
  ), 
  (
          'Restaurant', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Offers Fully Equipped Kitchen', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Fully equipped kitchen'
  ), 
  (
          'Garden', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Garden', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Garden'
  ), 
  (
          'Gift', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Gift Shop', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Gift Shop'
  ), 
  (
          'wave', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'number'), 
          'Nearby Bay', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Gleem Bay'
  ), 
  (
          'Kids_club', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Kids Club', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Kids Club'
  ), 
  (
          'Library', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Library', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Library'
  ), 
  (
          'Restaurant', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Restaurant', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Restaurant'
  ), 
  (
          'Room_Service', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Room Service', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Room Service'
  ), 
  (
          'diamond', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'number'), 
          'Museum Nearby', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Royal Jewellery Museum'
  ), 
  (
          'shopping', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'number'), 
          'Nearby Mall', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'San Stefano Grand Plaza Mall'
  ), 
  (
          'Shops', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Shops On Site', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Shops (on site)'
  ), 
  (
          'Terrace', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Terrace', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Terrace'
  ), 
  (
          'Tour', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Tour Desk', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Tour Desk'
  ), 
  (
          'washing-machine', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Washing Machine', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'General Facilities'), 
          'Washing Machine'
  ), 
  (
          'Family', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Family Rooms', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Health and Wellness'), 
          'Family Rooms'
  ), 
  (
          'Lift', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Lift', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Health and Wellness'), 
          'Lift'
  ), 
  (
          'Sauna', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Sauna', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Health and Wellness'), 
          'Sauna'
  ), 
  (
          'Spa', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Spa and Wellness Centre', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Health and Wellness'), 
          'Spa and Wellness Centre'
  ), 
  (
          'ac', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Air Conditioning', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Room Amenities'), 
          'Air Conditioning'
  ), 
  (
          'Balcony', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Balcony', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Room Amenities'), 
          'Balcony'
  ), 
  (
          'Cable', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Cable Channels', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Room Amenities'), 
          'Cable Channels'
  ), 
  (
          'castle', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'number'), 
          'Nearby Citadel', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Room Amenities'), 
          'Citadel of Qaitbay'
  ), 
  (
          'Smoking', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Designated Smoking Area', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Room Amenities'), 
          'Designated Smoking Area'
  ), 
  (
          'TV', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Flat-screen TV', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Room Amenities'), 
          'Flat-screen TV'
  ), 
  (
          'building', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'number'), 
          'Nearby Museum', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Room Amenities'), 
          'Graeco-Roman Museum'
  ), 
  (
          'Hairdryer', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Hairdryer', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Room Amenities'), 
          'Hairdryer'
  ), 
  (
          'Heating', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Heating', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Room Amenities'), 
          'Heating'
  ), 
  (
          'Iron', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Iron', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Room Amenities'), 
          'Iron'
  ), 
  (
          'Minibar', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Minibar', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Room Amenities'), 
          'Minibar'
  ), 
  (
          'Satellite', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Satellite Channels', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Room Amenities'), 
          'Satellite Channels'
  ), 
  (
          'Security', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has 24-hour Security', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Safety and Security'), 
          '24-hour Security'
  ), 
  (
          'Fishing', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Fishing Facility', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Safety and Security'), 
          'Fishing'
  ), 
  (
          'Safety', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Safety Deposit Box', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Safety and Security'), 
          'Safety Deposit Box'
  ), 
  (
          'Skiing', 
          (SELECT amenity_value_type_id FROM properties_schema.amenity_value_type WHERE amenity_value_type = 'toggle'), 
          'Has Skiing Facility', 
          (SELECT amenity_group_id FROM properties_schema.amenity_group WHERE amenity_group_name = 'Safety and Security'), 
          'Skiing'
  );
	


INSERT INTO properties_schema.city ( 
  city_name,  
  city_image
) VALUES
  (
          'El Ain El Sokhna', 
          'images/cities_sharmalsheikh.webp'
  ), 
  (
          'Hurghada', 
          'images/cities_hurghada.webp'
  ), 
  (
          'North Coast', 
          'images/cities_northcoast.webp'
  );
	


INSERT INTO properties_schema.location ( 
  city_id,  
  location_name,  
  location_image
) VALUES
  (
          (SELECT city_id FROM properties_schema.city WHERE city_name = 'Hurghada'), 
          'Al Mamsha El Seyahi', 
          'images/locations_mamsha.webp'
  ), 
  (
          (SELECT city_id FROM properties_schema.city WHERE city_name = 'North Coast'), 
          'El Alamein', 
          'images/locations_elalamein.webp'
  ), 
  (
          (SELECT city_id FROM properties_schema.city WHERE city_name = 'North Coast'), 
          'New Alamein', 
          'images/locations_newelalamein.webp'
  ), 
  (
          (SELECT city_id FROM properties_schema.city WHERE city_name = 'El Ain El Sokhna'), 
          'Porto Sokhna', 
          'images/locations_portoelsokhna.webp'
  ), 
  (
          (SELECT city_id FROM properties_schema.city WHERE city_name = 'El Ain El Sokhna'), 
          'Telal', 
          'images/locations_telalelsokhna.webp'
  ), 
  (
          (SELECT city_id FROM properties_schema.city WHERE city_name = 'Hurghada'), 
          'Vilages Road', 
          'images/locations_villagesroad.webp'
  );
	


INSERT INTO properties_schema.property ( 
  property_description,  
  instant_approve,  
  property_type_id,  
  checkin_time_to,  
  checkout_time_from,  
  checkout_time_to,  
  property_name,  
  address_line,  
  star_rating,  
  iframe_url,  
  compound_id,  
  tenant_id,  
  property_image,  
  property_images,  
  checkin_time_from,  
  location_url,  
  location_id
) VALUES
  (
          'Featuring air-conditioned accommodation with a private pool, garden view and a balcony, Telal sokhna villa is located in Ain Sokhna. The spacious holiday home features a terrace, 3 bedrooms, a living room and a well-equipped kitchen. Free private parking is available at the holiday home. The nearest airport is Cairo International Airport, 161 km from Telal sokhna villa.', 
          'false', 
          (SELECT property_type_id FROM properties_schema.property_type WHERE property_type_name = 'villa'), 
          '14:00', 
          '12:00', 
          '14:00', 
          'Telal sokhna Villa', 
          'The nearest airport is Cairo International Airport, 161 km from Telal sokhna villa.', 
          '0', 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'properties/510290051.jpg', 
          'properties/510290051.jpg,properties/510290082.jpg,properties/510290087.jpg,properties/510290090.jpg,properties/510290092.jpg,properties/510290094.jpg,properties/510290097.jpg,properties/510290099.jpg,properties/510290100.jpg,properties/510290102.jpg,properties/510290111.jpg,properties/510290122.jpg,properties/510290132.jpg,properties/510290144.jpg,properties/510290148.jpg', 
          '12:00', 
          'https://maps.app.goo.gl/snRFij93pVGYpc3L8', 
          (SELECT location_id FROM properties_schema.location WHERE location_name = 'Porto Sokhna')
  ), 
  (
          'Located in El Alamein, 34 km from Porto Marina, Vida Marina Resort Marassi provides air-conditioned rooms and a bar. Among the facilities of this property are a restaurant, room service and a 24-hour front desk, along with free WiFi throughout the property. Rooms are fitted with a balcony. At the hotel, each room includes a terrace. A buffet breakfast is available daily at Vida Marina Resort Marassi. The nearest airport is Borg el Arab International Airport, 112 km from the accommodation.', 
          'false', 
          (SELECT property_type_id FROM properties_schema.property_type WHERE property_type_name = 'hotel'), 
          '14:00', 
          '12:00', 
          '14:00', 
          'Vida Marina Resort Marassi', 
          'Sedy Abdelrahman', 
          '4', 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'properties/558805311.jpg', 
          'properties/558805311.jpg,properties/559324005.jpg,properties/559324013.jpg,properties/559324013.jpg,properties/559324022.jpg,properties/563378774.jpg,properties/563378910.jpg,properties/563378964.jpg,properties/563379114.jpg,properties/563379274.jpg,properties/563379374.jpg', 
          '12:00', 
          'https://maps.app.goo.gl/zfwKztgaNneLHnp27', 
          (SELECT location_id FROM properties_schema.location WHERE location_name = 'New Alamein')
  ), 
  (
          'Located 400 metres from Safi Beach, Marassi Boutique Hotel-Marina2 offers 3-star accommodation in El Alamein and features a restaurant. The property is non-smoking and is situated 35 km from Porto Marina. The nearest airport is Borg el Arab International Airport, 112 km from the hotel.', 
          'false', 
          (SELECT property_type_id FROM properties_schema.property_type WHERE property_type_name = 'motel'), 
          '14:00', 
          '12:00', 
          '14:00', 
          'Marassi Boutique Hotel', 
          '400 metres from Safi Beach', 
          '3', 
          NULL, 
          (SELECT compound_id FROM properties_schema.compound WHERE compound_name = 'marasi'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'properties/548116096.jpg', 
          'properties/548116096.jpg,properties/548116215.jpg,properties/548116244.jpg,properties/548116252.jpg,properties/548128851.jpg,properties/548128959.jpg,properties/559341500.jpg,properties/559341503.jpg,properties/559341505.jpg,properties/559341508.jpg,properties/559341512.jpg', 
          '12:00', 
          'https://maps.app.goo.gl/JWT9vJztQ7aujJLu9', 
          (SELECT location_id FROM properties_schema.location WHERE location_name = 'Vilages Road')
  ), 
  (
          'Tawila Island Resort features an outdoor swimming pool, fitness centre, a garden and terrace in Hurghada. Among the various facilities are a bar and a private beach area. The accommodation offers a 24-hour front desk, airport transfers, a kids'' club and free WiFi throughout the property. At the resort all rooms come with air conditioning, a seating area, a flat-screen TV with satellite channels, a safety deposit box and a private bathroom with a bidet, free toiletries and a hairdryer. At Tawila Island Resort each room comes with bed linen and towels. The daily breakfast offers à la carte, continental or American options. At the accommodation you will find a restaurant serving international cuisine. Vegetarian, dairy-free and halal options can also be requested.', 
          'false', 
          (SELECT property_type_id FROM properties_schema.property_type WHERE property_type_name = 'hotel'), 
          '14:00', 
          '12:00', 
          '14:00', 
          'Tawila Island Resort', 
          '4KM from Hurghada', 
          '5', 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'ABC Hotels'), 
          'properties/548116096.jpg', 
          'properties/501590320.jpg,properties/501590349.jpg,properties/501590382.jpg,properties/501590386.jpg,properties/503898209.jpg,properties/503898398.jpg,properties/503898563.jpg,properties/503898582.jpg,properties/503899122.jpg,properties/503899869.jpg,properties/503899984.jpg,properties/503899986.jpg,properties/503899996.jpg,properties/503900041.jpg,properties/503900594.jpg', 
          '12:00', 
          'https://maps.app.goo.gl/Zpv9E46iNfpbvS6p7', 
          (SELECT location_id FROM properties_schema.location WHERE location_name = 'Al Mamsha El Seyahi')
  ), 
  (
          'A very clean family friendly well organized chalet', 
          'false', 
          (SELECT property_type_id FROM properties_schema.property_type WHERE property_type_name = 'chalet'), 
          '10:00:00', 
          '06:11:00', 
          '10:00:00', 
          'Marina Hills', 
          'Marina hills block 75', 
          '5', 
          NULL, 
          (SELECT compound_id FROM properties_schema.compound WHERE compound_name = 'Marina'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'Tech Innovators'), 
          'properties/469602831.jpg', 
          'properties/469602831.jpg,properties/470127527.jpg,properties/470127571.jpg,properties/470127762.jpg,properties/470127786.jpg,properties/470127832.jpg,properties/470127872.jpg,properties/470127958.jpg,properties/470127966.jpg,properties/470127972.jpg,properties/470127990.jpg,properties/470128143.jpg,properties/470128175.jpg,properties/487927693.jpg,properties/487927744.jpg', 
          '05:00:00', 
          'http://localhost:5173/properties', 
          (SELECT location_id FROM properties_schema.location WHERE location_name = 'El Alamein')
  ), 
  (
          '5 stars hotel in new alamein with a water view', 
          'true', 
          (SELECT property_type_id FROM properties_schema.property_type WHERE property_type_name = 'hotel'), 
          '11:00:00', 
          '04:00:00', 
          '08:00:00', 
          'Rhactus Hotel', 
          'New Alamein', 
          '5', 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'Tech Innovators'), 
          'properties/307187926.jpg', 
          'properties/307187926.jpg,properties/307228874.jpg,properties/307228896.jpg,properties/375109488.jpg,properties/375113537.jpg,properties/375132129.jpg,properties/375341520.jpg,properties/375349121.jpg,properties/375349277.jpg,properties/397150902.jpg', 
          '05:00:00', 
          'https://www.google.com/maps/dir/30.0450331,31.388456/marina+north+coast+location/@30.3890578,27.5267996,7z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x145fedf0f6120207:0x390b26abcc8c518f!2m2!1d28.966375!2d30.851088?entry=ttu', 
          (SELECT location_id FROM properties_schema.location WHERE location_name = 'New Alamein')
  ), 
  (
          'Porto Sokhna is a 4-star hotel offering spacious, self-catering and serviced accommodations, personalized service, and resort-style facilities in Ain Sokhna. It is just steps away from beaches along the Red Sea. Apartments, up to a floor space of 500 m², are fully furnished and include private balconies, separate seating areas, LCD TVs, and luxury bathrooms. Porto Sokhna Beach Resort, on-site restaurant offers a rich breakfast buffet and traditional regional meals are prepared for dinner. Free parking is offered to all guests.', 
          'false', 
          (SELECT property_type_id FROM properties_schema.property_type WHERE property_type_name = 'apartment'), 
          '14:00', 
          '12:00', 
          '14:00', 
          'Apartment In Porto El Sokhna', 
          'Ein El Sokhna, Atakka', 
          '0', 
          NULL, 
          NULL, 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'Tech Innovators'), 
          'properties/355307852.jpg', 
          'properties/355307852.jpg,properties/355307853.jpg,properties/355307856.jpg,properties/355307867.jpg,properties/355307871.jpg,properties/355307873.jpg,properties/355307879.jpg,properties/355307884.jpg,properties/355307886.jpg,properties/355307889.jpg,properties/449011381.jpg,properties/449011392.jpg,properties/449011394.jpg', 
          '12:00', 
          'https://maps.app.goo.gl/xgVxpJeYm7ypMYDk8', 
          (SELECT location_id FROM properties_schema.location WHERE location_name = 'Porto Sokhna')
  ), 
  (
          '3 bedroom villa.', 
          'false', 
          (SELECT property_type_id FROM properties_schema.property_type WHERE property_type_name = 'villa'), 
          '14:00', 
          '12:00', 
          '12:00', 
          'Lagoon View @ NAC', 
          'NAC', 
          '4', 
          NULL, 
          (SELECT compound_id FROM properties_schema.compound WHERE compound_name = 'NAC Lagoons'), 
          (SELECT tenant_id FROM tenants_schema.tenant WHERE tenant_name = 'Tech Innovators'), 
          'properties/lagoon-main.webp', 
          'properties/lagoon-01.webp,properties/lagoon-02.webp,properties/lagoon-03.webp,properties/lagoon-04.webp,properties/lagoon-05.webp', 
          '14:00', 
          'https://maps.app.goo.gl/14qz2NbhbhPGpcjp9', 
          (SELECT location_id FROM properties_schema.location WHERE location_name = 'New Alamein')
  );
	


INSERT INTO properties_schema.reservable_unit ( 
  reservable_unit_name,  
  reservable_unit_type_id,  
  unit_area,  
  reservable_unit_image,  
  minimum_guests_number,  
  maximum_guests_number,  
  property_id,  
  bathrooms_count,  
  is_closed,  
  base_price,  
  reservable_unit_images
) VALUES
  (
          'Rhactus Deluxe Family', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Deluxe Family'), 
          '100', 
          'rooms/307187993.jpg', 
          '1', 
          '1', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Rhactus Hotel'), 
          '2', 
          'false', 
          '7649', 
          'rooms/307187993.jpg,rooms/307228874.jpg,rooms/397149691.jpg'
  ), 
  (
          'Rhactus Deluxe King', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Deluxe King'), 
          '100', 
          'rooms/307187791.jpg', 
          '1', 
          '1', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Rhactus Hotel'), 
          '1', 
          'false', 
          '10560', 
          'rooms/307187791.jpg,rooms/307187967.jpg,rooms/307188019.jpg,rooms/307228804.jpg,rooms/307228874.jpg,rooms/307228896.jpg'
  ), 
  (
          'Rhactus Premium King', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Premium King'), 
          '100', 
          'rooms/307187791.jpg', 
          '1', 
          '1', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Rhactus Hotel'), 
          '1', 
          'false', 
          '11320', 
          'rooms/307187791.jpg,rooms/307187967.jpg,rooms/307188019.jpg,rooms/307228804.jpg,rooms/307228874.jpg'
  ), 
  (
          'Rhactus Deluxe Triple', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Deluxe Triple'), 
          '100', 
          'rooms/307228874.jpg', 
          '1', 
          '3', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Rhactus Hotel'), 
          '2', 
          'false', 
          '10500', 
          'rooms/307228874.jpg,rooms/397149144.jpg'
  ), 
  (
          'Rhactus Deluxe Twin', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Deluxe Twin'), 
          '100', 
          'rooms/307187791.jpg', 
          '1', 
          '2', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Rhactus Hotel'), 
          '1', 
          'false', 
          '9200', 
          'rooms/307187791.jpg,rooms/307187967.jpg,rooms/307188019.jpg,rooms/307228829.jpg,rooms/307228874.jpg'
  ), 
  (
          'Marina Hills one bedroom apartment', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'one bedroom apartment'), 
          '100', 
          'rooms/470127571.jpg', 
          '1', 
          '4', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Marina Hills'), 
          '1', 
          'false', 
          '9200', 
          'rooms/470127571.jpg,rooms/470127762.jpg,rooms/470127786.jpg,rooms/470127832.jpg,rooms/470127864.jpg,rooms/470127872.jpg,rooms/470127958.jpg,rooms/470127966.jpg,rooms/470127972.jpg,rooms/470127990.jpg,rooms/470128018.jpg,rooms/470128143.jpg,rooms/470128153.jpg,rooms/470128175.jpg,rooms/470128189.jpg,rooms/Photo_1715957595657.jpeg'
  ), 
  (
          'Vida Deluxe - Garden View', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Deluxe Family'), 
          '100', 
          'rooms/558805311.jpg', 
          '1', 
          '4', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Vida Marina Resort Marassi'), 
          '1', 
          'false', 
          '6500', 
          'rooms/558805311.jpg, rooms/559324005.jpg,rooms/559324022.jpg,rooms/563378910.jpg'
  ), 
  (
          'Vida Executive - Garden View', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Deluxe Family'), 
          '100', 
          'rooms/558805311.jpg', 
          '1', 
          '4', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Vida Marina Resort Marassi'), 
          '1', 
          'false', 
          '9890', 
          'rooms/558805311.jpg,rooms/559324022.jpg,rooms/563378910.jpg'
  ), 
  (
          'Marassi boutique - Double Room', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Deluxe Family'), 
          '100', 
          'rooms/548066614.jpg', 
          '1', 
          '2', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Marassi Boutique Hotel'), 
          '1', 
          'false', 
          '4760', 
          'rooms/548066614.jpg'
  ), 
  (
          'Marassi boutique - Royal Suite', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Royal Suite'), 
          '100', 
          'rooms/548066625.jpg', 
          '1', 
          '3', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Marassi Boutique Hotel'), 
          '1', 
          'false', 
          '15430', 
          'rooms/548066625.jpg'
  ), 
  (
          'Tawila - Standard Bungalow', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Deluxe Family'), 
          '100', 
          'rooms/501590406.jpg', 
          '1', 
          '4', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Tawila Island Resort'), 
          '1', 
          'false', 
          '34570', 
          'rooms/501590406.jpg,rooms/501590440.jpg,rooms/503898334.jpg,rooms/503898397.jpg,rooms/503898398.jpg,rooms/503898497.jpg,rooms/503898563.jpg,rooms/503898573.jpg'
  ), 
  (
          'Tawila - Deluxe Bungalow', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Deluxe Family'), 
          '100', 
          'rooms/501590382.jpg', 
          '1', 
          '4', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Tawila Island Resort'), 
          '1', 
          'false', 
          '45390', 
          'rooms/501590382.jpg,rooms/501590440.jpg,rooms/503898474.jpg,rooms/503898497.jpg,rooms/503898582.jpg,rooms/503899752.jpg,rooms/503899834.jpg,rooms/503899932.jpg,rooms/503900594.jpg'
  ), 
  (
          'Tawila - Superior Bungalow', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Deluxe Family'), 
          '100', 
          'rooms/501590386.jpg', 
          '1', 
          '4', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Tawila Island Resort'), 
          '2', 
          'false', 
          '75610', 
          'rooms/501590386.jpg,rooms/501590418.jpg,rooms/501590440.jpg,rooms/501590455.jpg,rooms/503898474.jpg,rooms/503899122.jpg,rooms/503899850.jpg,rooms/503899932.jpg,rooms/503900550.jpg,rooms/503900594.jpg'
  ), 
  (
          'Porto El Sokhna - Two Bedroom Apartment', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'two-bedroom apartment'), 
          '100', 
          'rooms/472447068.jpg', 
          '1', 
          '2', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Apartment In Porto El Sokhna'), 
          '2', 
          'false', 
          '3570', 
          'rooms/472447068.jpg'
  ), 
  (
          'Telal El Sokhna Villa', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'Villa'), 
          '200', 
          'rooms/510290082.jpg', 
          '1', 
          '5', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Telal sokhna Villa'), 
          '4', 
          'false', 
          '8790', 
          'rooms/510290082.jpg,rooms/510290136.jpg,rooms/510290147.jpg'
  ), 
  (
          'Lagoon View @ NAC', 
          (SELECT reservable_unit_type_id FROM properties_schema.reservable_unit_type WHERE reservable_unit_type_name = 'three-bedroom apartment'), 
          '200', 
          'rooms/lagoon-01.webp', 
          '1', 
          '5', 
          (SELECT property_id FROM properties_schema.property WHERE property_name = 'Lagoon View @ NAC'), 
          '4', 
          'false', 
          '2000', 
          'rooms/lagoon-02.webp,rooms/lagoon-03.webp'
  );
	


INSERT INTO properties_schema.reservable_unit_room ( 
  reservable_unit_id,  
  reservable_unit_room_name
) VALUES
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Rhactus Deluxe Family'), 
          'RH-DEL-F-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Rhactus Deluxe King'), 
          'RH-DEL-K-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Rhactus Premium King'), 
          'RH-PER-K-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Rhactus Deluxe Triple'), 
          'RH-DEL-TR-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Rhactus Deluxe Twin'), 
          'RH-DEL-TW-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Marina Hills one bedroom apartment'), 
          'MAR-OBA-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Vida Deluxe - Garden View'), 
          'VID-DEK-GV-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Vida Executive - Garden View'), 
          'VID-EXEC-GV-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Marassi boutique - Double Room'), 
          'MAR-DBL-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Marassi boutique - Royal Suite'), 
          'MAR-RS-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Tawila - Standard Bungalow'), 
          'TA-ST-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Tawila - Deluxe Bungalow'), 
          'TA-DEL-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Tawila - Superior Bungalow'), 
          'TA-SP-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Porto El Sokhna - Two Bedroom Apartment'), 
          'POR-TBA-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Porto El Sokhna - Two Bedroom Apartment'), 
          'POR-TBA-2'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Telal El Sokhna Villa'), 
          'TEL-VI-1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Telal El Sokhna Villa'), 
          'TEL-VI-2'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Telal El Sokhna Villa'), 
          'TEL-VI-3'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Telal El Sokhna Villa'), 
          'TEL-VI-4'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Telal El Sokhna Villa'), 
          'TEL-VI-5'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Lagoon View @ NAC'), 
          'Lagoon View @ NAC ROOM NO: 1'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Lagoon View @ NAC'), 
          'Lagoon View @ NAC ROOM NO: 2'
  ), 
  (
          (SELECT reservable_unit_id FROM properties_schema.reservable_unit WHERE reservable_unit_name = 'Lagoon View @ NAC'), 
          'Lagoon View @ NAC ROOM NO: 3'
  );
	


INSERT INTO properties_schema.reservable_unit_room_bed ( 
  reservable_unit_room_id,  
  bed_type_id,  
  bed_count
) VALUES
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'Lagoon View @ NAC ROOM NO: 1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'MAR-DBL-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'MAR-OBA-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'MAR-OBA-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'single bed'), 
          '2'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'MAR-RS-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'POR-TBA-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'RH-DEL-F-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'RH-DEL-F-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'single bed'), 
          '2'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'RH-DEL-K-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'RH-DEL-K-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'single bed'), 
          '2'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'RH-DEL-TR-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'RH-DEL-TR-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'single bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'RH-DEL-TW-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'single bed'), 
          '2'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'RH-DEL-TW-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'RH-PER-K-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'RH-PER-K-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'single bed'), 
          '2'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'TA-DEL-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'TA-SP-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'TA-ST-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'TEL-VI-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'VID-DEK-GV-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'VID-DEK-GV-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'single bed'), 
          '2'
  ), 
  (
          (SELECT reservable_unit_room_id FROM properties_schema.reservable_unit_room WHERE reservable_unit_room_name = 'VID-EXEC-GV-1'), 
          (SELECT bed_type_id FROM properties_schema.bed_type WHERE bed_type = 'extra-large double bed'), 
          '1'
  );
	
