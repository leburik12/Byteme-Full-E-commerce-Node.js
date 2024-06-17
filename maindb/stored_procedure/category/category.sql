CREATE OR REPLACE PROCEDURE insert_parent_categories()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (NULL, 'Electronics', NULL, NULL),
    (NULL, 'Fashion', NULL, NULL),
    (NULL, 'Home & Kitchen', NULL, NULL),
    (NULL, 'Beauty & Personal Care', NULL, NULL),
    (NULL, 'Books', NULL, NULL),
    (NULL, 'Sports & Outdoors', NULL, NULL),
    (NULL, 'Toys & Games', NULL, NULL),
    (NULL, 'Automotive', NULL, NULL),
    (NULL, 'Health & Wellness', NULL, NULL),
    (NULL, 'Groceries', NULL, NULL),
    (NULL, 'Baby Products', NULL, NULL),
    (NULL, 'Office Supplies', NULL, NULL),
    (NULL, 'Pet Supplies', NULL, NULL),
    (NULL, 'Garden & Outdoor', NULL, NULL),
    (NULL, 'Jewelry', NULL, NULL),
    (NULL, 'Musical Instruments', NULL, NULL),
    (NULL, 'Arts & Crafts', NULL, NULL),
    (NULL, 'Industrial & Scientific', NULL, NULL);
END;
$$ LANGUAGE plpgsql; 

CREATE OR REPLACE PROCEDURE insert_subcategories_electronics()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (1, 'Mobile Phones', NULL, NULL),
    (1, 'Laptops', NULL, NULL),
    (1, 'Tablets', NULL, NULL),
    (1, 'Cameras', NULL, NULL),
    (1, 'Audio & Headphones', NULL, NULL),
    (1, 'Wearable Technology', NULL, NULL),
    (1, 'Smart Home Devices', NULL, NULL),
    (1, 'Accessories', NULL, NULL);
END;
$$ LANGUAGE plpgsql;


