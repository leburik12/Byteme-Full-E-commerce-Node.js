CREATE OR REPLACE PROCEDURE insert_main_subcategories_groceries()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (10, 'Fresh Produce', NULL, NULL),
    (10, 'Dairy & Eggs', NULL, NULL),
    (10, 'Meat & Seafood', NULL, NULL),
    (10, 'Bakery', NULL, NULL),
    (10, 'Beverages', NULL, NULL),
    (10, 'Pantry Staples', NULL, NULL),
    (10, 'Snacks & Confectionery', NULL, NULL),
    (10, 'Frozen Foods', NULL, NULL),
    (10, 'Condiments & Sauces', NULL, NULL),
    (10, 'Health Foods', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_main_subcategories_groceries_fresh()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (319, 'Fruits', NULL, NULL),
    (319, 'Vegetables', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_fruit_subcategories_groceries_s_fresh_s_fruits()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (329, 'Citrus (Oranges, Lemons, Limes)', NULL, NULL),
    (329, 'Berries (Strawberries, Blueberries, Raspberries)', NULL, NULL),
    (329, 'Tropical (Bananas, Pineapples, Mangoes)', NULL, NULL),
    (329, 'Stone Fruits (Peaches, Plums, Cherries)', NULL, NULL),
    (329, 'Melons (Watermelon, Cantaloupe, Honeydew)', NULL, NULL),
    (329, 'Apples & Pears', NULL, NULL),
    (329, 'Grapes', NULL, NULL),
    (329, 'Avocados', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_vegetable_subcategories_groceries_s_fresh_vegetables()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (330, 'Leafy Greens (Spinach, Kale, Lettuce)', NULL, NULL),
    (330, 'Root Vegetables (Carrots, Potatoes, Beets)', NULL, NULL),
    (330, 'Cruciferous (Broccoli, Cauliflower, Cabbage)', NULL, NULL),
    (330, 'Alliums (Onions, Garlic, Leeks)', NULL, NULL),
    (330, 'Peppers (Bell Peppers, Hot Peppers)', NULL, NULL),
    (330, 'Squash & Zucchini', NULL, NULL),
    (330, 'Mushrooms', NULL, NULL),
    (330, 'Tomatoes', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_main_subcategories_groceries_s_dairy()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (320, 'Milk & Cream', NULL, NULL),
    (320, 'Yogurt', NULL, NULL),
    (320, 'Butter & Margarine', NULL, NULL),
    (320, 'Eggs', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_main_subcategories_groceries_s_meat()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (321, 'Beef', NULL, NULL),
    (321, 'Pork', NULL, NULL),
    (321, 'Poultry', NULL, NULL),
    (321, 'Deli Meats', NULL, NULL),
    (321, 'Seafood', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_main_subcategories_groceries_s_bakery()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (322, 'Bread', NULL, NULL),
    (322, 'Pastries', NULL, NULL),
    (322, 'Cakes & Pies', NULL, NULL),
    (322, 'Cookies & Biscuits', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_bread_subcategories_groceries_s_bread()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (364, 'White Bread', NULL, NULL),
    (364, 'Whole Wheat Bread', NULL, NULL),
    (364, 'Sourdough', NULL, NULL),
    (364, 'Baguettes', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_pastry_subcategories_groceries_s_pastries()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (365, 'Croissants', NULL, NULL),
    (365, 'Muffins', NULL, NULL),
    (365, 'Donuts', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_cake_pie_subcategories_groceries_s_cakes()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (366, 'Birthday Cakes', NULL, NULL),
    (366, 'Cheesecakes', NULL, NULL),
    (366, 'Fruit Pies', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_cookie_cracker_subcategories_groceries_s_cookies()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (367, 'Chocolate Chip Cookies', NULL, NULL),
    (367, 'Shortbread', NULL, NULL),
    (367, 'Crackers', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_cookie_cracker_subcategories_groceries_s_beverages()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (323, 'Water', NULL, NULL),
    (323, 'Juices', NULL, NULL),
    (323, 'Soft Drinks', NULL, NULL),
    (323, 'Alcoholic Beverages', NULL, NULL),
    (323, 'Tea & Coffee', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_water_subcategories_groceries_s_beverages_water()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (381, 'Spring Water', NULL, NULL),
    (381, 'Sparkling Water', NULL, NULL),
    (381, 'Flavored Water', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_juice_subcategories_beverages_juices()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (382, 'Orange Juice', NULL, NULL),
    (382, 'Apple Juice', NULL, NULL),
    (382, 'Vegetable Juice', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_soda_subcategories_beverages_soft()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (383, 'Cola', NULL, NULL),
    (383, 'Lemon-Lime Soda', NULL, NULL),
    (383, 'Ginger Ale', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_tea_coffee_subcategories_beverages_tea()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (385, 'Black Tea', NULL, NULL),
    (385, 'Green Tea', NULL, NULL),
    (385, 'Coffee Beans', NULL, NULL),
    (385, 'Ground Coffee', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_alcoholic_beverage_subcategories_beverages_alcoholic()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (384, 'Beer', NULL, NULL),
    (384, 'Wine', NULL, NULL),
    (384, '(Whiskey, Vodka, Rum)', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_food_subcategories_pantry() AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url)
    VALUES 
        (324, 'Grains & Rice', NULL, NULL),
        (324, 'Pasta & Noodles', NULL, NULL),
        (324, 'Canned Goods', NULL, NULL),
        (324, 'Baking Supplies', NULL, NULL),
        (324, 'Spices & Seasonings', NULL, NULL),
        (324, 'Oils & Vinegars', NULL, NULL);
END;
$$ LANGUAGE plpgsql;










