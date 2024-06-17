CREATE OR REPLACE PROCEDURE insert_parent_categories_sport_outdoor()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (6, 'Fitness Equipment', NULL, NULL),
    (6, 'Outdoor Recreation', NULL, NULL),
    (6, 'Team Sports', NULL, NULL),
    (6, 'Water Sports', NULL, NULL),
    (6, 'Winter Sports', NULL, NULL),
    (6, 'Hunting & Shooting', NULL, NULL),
    (6, 'Tennis', NULL, NULL),
    (6, 'Golf', NULL, NULL),
    (6, 'Yoga', NULL, NULL);
END;
$$ LANGUAGE plpgsql; 

CREATE OR REPLACE PROCEDURE insert_parent_categories_sport_s_fitness()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (117, 'Cardio Training', NULL, NULL),
    (117, 'Strength Training', NULL, NULL);
END;
$$ LANGUAGE plpgsql;  

CREATE OR REPLACE PROCEDURE insert_parent_categories_sport_s_fitness_s_cardio()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (126, 'Treadmills', NULL, NULL),
    (126, 'Bikes', NULL, NULL),
    (126, 'Ellipticals', NULL, NULL),
    (126, 'Rowing Machines', NULL, NULL);
END;
$$ LANGUAGE plpgsql; 

CREATE OR REPLACE PROCEDURE insert_parent_categories_sport_s_fitness_s_strength()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (127, 'Dumbbells', NULL, NULL),
    (127, 'Kettlebells', NULL, NULL),
    (127, 'Weight Benches', NULL, NULL),
    (127, 'Home Gyms', NULL, NULL);
END;
$$ LANGUAGE plpgsql; 

CREATE OR REPLACE PROCEDURE insert_parent_categories_sport_s_fitness_s_outdoor()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (118, 'Camping & Hiking', NULL, NULL),
    (118, 'Cycling', NULL, NULL),
    (118, 'Fishing', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_sport_s_fitness_s_camping()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (140, 'Tents', NULL, NULL),
    (140, 'Sleeping Bags', NULL, NULL),
    (140, 'Backpacks', NULL, NULL),
    (140, 'Hiking Boots', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_sport_s_fitness_s_cycling()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (141, 'Bicycles', NULL, NULL),
    (141, 'Helmets', NULL, NULL),
    (141, 'Bike Accessories', NULL, NULL),
    (141, 'Cycling Apparel', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_sport_s_fitness_s_fishing()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (142, 'Fishing Rods', NULL, NULL),
    (142, 'Fishing Reels', NULL, NULL),
    (142, 'Tackle Boxes', NULL, NULL),
    (142, 'Fishing Apparel', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_sport_s_team_sports()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (119, 'Soccer', NULL, NULL),
    (119, 'Basketball', NULL, NULL),
    (119, 'Baseball & Softbal', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_sport_s_team_sport_s_soccer()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (155, 'Soccer Balls', NULL, NULL),
    (155, 'Soccer Cleats', NULL, NULL),
    (155, 'Goals & Nets', NULL, NULL),
    (155, 'Shin Guards', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_sport_s_team_sport_s_basketball()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (156, 'basketballs', NULL, NULL),
    (156, 'hoops', NULL, NULL),
    (156, 'shoes', NULL, NULL),
    (156, 'apparel', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_sport_s_team_sport_s_baseball()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (157, 'bats', NULL, NULL),
    (157, 'Gloves & Mitts', NULL, NULL),
    (157, 'Balls', NULL, NULL),
    (157, 'Protective Gear', NULL, NULL);
END;
$$ LANGUAGE plpgsql;




