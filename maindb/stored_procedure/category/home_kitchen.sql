CREATE OR REPLACE PROCEDURE insert_subcategories_home_kitchen()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (3, 'Furniture', NULL, NULL),
    (3, 'Home Decor', NULL, NULL),
    (3, 'Kitchen & Dining', NULL, NULL),
    (3, 'Appliances', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_home_kitchen_s_furniture()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (27, 'Living Room Furniture  ', NULL, NULL),
    (27, 'Bedroom Furniture', NULL, NULL),
    (27, 'Office Furniture', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_home_kitchen_s_home_decor()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (28, 'Wall Art  ', NULL, NULL),
    (28, 'Clocks', NULL, NULL),
    (28, 'Rugs', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_home_kitchen_s_Kitchen_Dining()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (29, 'Cookware', NULL, NULL),
    (29, 'Tableware', NULL, NULL),
    (29, 'Kitchen Storage', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_home_kitchen_s_appliances()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (30, 'Refrigerators', NULL, NULL),
    (30, 'Ovens', NULL, NULL),
    (30, 'Dishwashers', NULL, NULL);
END;
$$ LANGUAGE plpgsql;