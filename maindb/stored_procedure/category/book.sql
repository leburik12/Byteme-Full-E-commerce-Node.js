CREATE OR REPLACE PROCEDURE insert_subcategories_book()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (5, 'Romance', NULL, NULL),
    (5, 'Mystery, Thriller & Suspense', NULL, NULL),
    (5, 'Science Fiction & Fantasy', NULL, NULL),
    (5, 'Horror', NULL, NULL),
    (5, 'Literary Fiction', NULL, NULL),
    (5, 'Biographies & Memoirs', NULL, NULL),
    (5, 'Self-Help', NULL, NULL),
    (5, 'History', NULL, NULL),
    (5, 'Science & Math', NULL, NULL),
    (5, 'Health, Fitness & Dieting', NULL, NULL),
    (5, 'Children''s Books', NULL, NULL),
    (5, 'Cookbooks, Food & Wine', NULL, NULL),
    (5, 'Arts, Music & Photography', NULL, NULL),
    (5, 'Business & Investing', NULL, NULL),
    (5, 'Computers & Technology', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_book_s_mystery()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (68, 'Mystery', NULL, NULL),
    (68, 'Thriller', NULL, NULL),
    (68, 'Suspense', NULL, NULL),
    (68, 'Crime Fiction', NULL, NULL),
    (68, 'Detective Fiction', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_book_s_biographies()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (72, 'Biographies', NULL, NULL),
    (72, 'Memoirs', NULL, NULL),
    (72, 'Autobiographies', NULL, NULL),
    (72, 'Historical Biographies', NULL, NULL),
    (72, 'Celebrity Biographies', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_book_s_science()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (75, 'Science', NULL, NULL),
    (75, 'Math', NULL, NULL),
    (75, 'Physics', NULL, NULL),
    (75, 'Biology', NULL, NULL),
    (75, 'Chemistry', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_book_s_health_fitness ()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (76, 'Health', NULL, NULL),
    (76, 'Fitness', NULL, NULL),
    (76, 'Dieting', NULL, NULL),
    (76, 'Nutrition', NULL, NULL),
    (76, 'Wellness', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_book_s_business ()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (80, 'Business', NULL, NULL),
    (80, 'Investing', NULL, NULL),
    (80, 'Entrepreneurship', NULL, NULL),
    (80, 'Management', NULL, NULL),
    (80, 'Marketing', NULL, NULL);
END;
$$ LANGUAGE plpgsql;  

CREATE OR REPLACE PROCEDURE insert_subcategories_book_s_computers ()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES
    (81, 'Computers', NULL, NULL),
    (81, 'Technology', NULL, NULL),
    (81, 'Programming', NULL, NULL),
    (81, 'Web Development', NULL, NULL),
    (81, 'Databases', NULL, NULL);
END;
$$ LANGUAGE plpgsql; 