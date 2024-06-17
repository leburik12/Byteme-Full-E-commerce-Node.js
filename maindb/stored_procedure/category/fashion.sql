CREATE OR REPLACE PROCEDURE insert_subcategories_Home_fashion()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (2, 'Men''s Clothing', NULL, NULL),
    (2, 'Women''s Clothing', NULL, NULL),
    (2, 'Footwear', NULL, NULL),
    (2, 'Accessories', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_fashion_s_men_cloth()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (31, 'Shirts', NULL, NULL),
    (31, 'T-Shirts', NULL, NULL),
    (31, 'Jeans', NULL, NULL),
    (31, 'Jackets', NULL, NULL),
    (31, 'Suits', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_fashion_s_women_cloth()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (32, 'Dresses', NULL, NULL),
    (32, 'Tops', NULL, NULL),
    (32, 'Skirts', NULL, NULL),
    (32, 'Jeans', NULL, NULL),
    (32, 'Jackets', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_fashion_s_footwear()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (33, 'Men''s Footwear', NULL, NULL),
    (33, 'Women''s Footwear', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_fashion_s_accessories()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (34, 'Bags', NULL, NULL),
    (34, 'Watches', NULL, NULL),
    (34, 'Jewelry', NULL, NULL);
END;
$$ LANGUAGE plpgsql;