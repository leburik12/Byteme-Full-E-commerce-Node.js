CREATE OR REPLACE PROCEDURE insert_subcategories_beauty()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (4, 'Skincare', NULL, NULL),
    (4, 'Haircare', NULL, NULL),
    (4, 'Makeup', NULL, NULL),
    (4, 'Fragrances', NULL, NULL),
    (4, 'Personal Care Appliances', NULL, NULL);
END;
$$ LANGUAGE plpgsql;
