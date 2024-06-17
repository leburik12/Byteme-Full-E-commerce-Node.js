
CREATE OR REPLACE PROCEDURE insert_subcategories_toys_games()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (7, 'Action Figures & Playsets', NULL, NULL),
    (7, 'Building Toys', NULL, NULL),
    (7, 'Dolls & Accessories', NULL, NULL),
    (7, 'Educational Toys', NULL, NULL),
    (7, 'Outdoor Play', NULL, NULL),
    (7, 'Games & Puzzles', NULL, NULL),
    (7, 'Stuffed Animals & Plush Toys', NULL, NULL),
    (7, 'Arts & Crafts', NULL, NULL),
    (7, 'Vehicles & Remote Control', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_toys_games_s_action()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (170, 'Superheroes', NULL, NULL),
    (170, 'TV & Movie Characters', NULL, NULL),
    (170, 'Playsets', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_toys_games_s_building()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (171, 'Building Sets', NULL, NULL),
    (171, 'Stacking Blocks', NULL, NULL),
    (171, 'Model Kits', NULL, NULL);
END;
$$ LANGUAGE plpgsql;
Dolls & Accessories

CREATE OR REPLACE PROCEDURE insert_subcategories_toys_games_s_dolls()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (172, 'Fashion Dolls', NULL, NULL),
    (172, 'Baby Dolls', NULL, NULL),
    (172, 'Dollhouses', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_toys_games_s_educational()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (173, 'educational toys', NULL, NULL),
    (173, 'STEM Toys', NULL, NULL),
    (173, 'Musical Toys', NULL, NULL),
    (173, 'Learning Games', NULL, NULL);
END;Toys
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_toys_games_s_Outdoor()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (173, 'Swing Sets', NULL, NULL),
    (173, 'Slides', NULL, NULL),
    (173, 'Trampolines', NULL, NULL),
    (173, 'Water Toys', NULL, NULL);
END;Toys
$$ LANGUAGE plpgsql;
