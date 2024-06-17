CREATE OR REPLACE PROCEDURE insert_subcategories_health()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (9, 'Physical Health', NULL, NULL),
    (9, 'Mental Health', NULL, NULL),
    (9, 'Emotional Wellness', NULL, NULL),
    (9, 'Holistic Health', NULL, NULL),
    (9, 'Reproductive Health', NULL, NULL),
    (9, 'Environmental Health', NULL, NULL),
    (9, 'Senior Health', NULL, NULL),
    (9, 'Pediatric Health', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_physical()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (234, 'Fitness', NULL, NULL),
    (234, 'Nutrition', NULL, NULL),
    (234, 'Weight Management', NULL, NULL),
    (234, 'Preventive Health', NULL, NULL),
    (234, 'Chronic Disease Management', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_physical_s_fitness()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (242, 'Exercise Programs', NULL, NULL),
    (242, 'Personal Training', NULL, NULL),
    (242, 'Group Fitness Classes', NULL, NULL),
    (242, 'Home Workouts', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_physical_s_nutrition()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (243, 'Diet Plans', NULL, NULL),
    (243, 'Supplements', NULL, NULL),
    (243, 'Healthy Recipes', NULL, NULL),
    (243, 'Nutrition Counseling', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_physical_s_weight()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (244, 'Weight Loss Programs', NULL, NULL),
    (244, 'Weight Gain Strategies', NULL, NULL),
    (244, 'Bariatric Surgery', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_physical_s_preventive()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (245, 'Vaccinations', NULL, NULL),
    (245, 'Regular Check-ups', NULL, NULL),
    (245, 'Screenings and Tests', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_physical_s_chronic()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (246, 'Diabetes Management', NULL, NULL),
    (246, 'Hypertension Management', NULL, NULL),
    (246, 'Heart Disease Care', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_mental()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (235, 'Therapy and Counseling', NULL, NULL),
    (235, 'Mental Health Disorders', NULL, NULL),
    (235, 'Substance Abuse', NULL, NULL),
    (235, 'Stress Management', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_mental_s_therapy()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (267, 'Individual Therapy', NULL, NULL),
    (267, 'Group Therapy', NULL, NULL),
    (267, 'Family Counseling', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_mental_s_mental()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (268, 'Depression', NULL, NULL),
    (268, 'Anxiety', NULL, NULL),
    (268, 'Bipolar Disorder', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_mental_s_substance()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (269, 'Addiction Treatment', NULL, NULL),
    (269, 'Rehabilitation Programs', NULL, NULL),
    (269, 'Support Groups', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_mental_s_stress()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (270, 'Meditation', NULL, NULL),
    (270, 'Mindfulness', NULL, NULL),
    (270, 'Relaxation Techniques', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_emotional()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (236, 'Self-Care', NULL, NULL),
    (236, 'Relationship Health', NULL, NULL),
    (236, 'Life Coaching', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_emotional_s_self()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (283, 'Journaling', NULL, NULL),
    (283, 'Hobbies and Interests', NULL, NULL),
    (283, 'Personal Development', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_emotional_s_relation()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (284, 'Couples Counseling', NULL, NULL),
    (284, 'Communication Skills', NULL, NULL),
    (284, 'Conflict Resolution', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_emotional_s_life()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (285, 'Goal Setting', NULL, NULL),
    (285, 'Motivation Techniques', NULL, NULL),
    (285, 'Career Counseling', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_emotional_s_holistic()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (237, 'Alternative Medicine', NULL, NULL),
    (237, 'Complementary Therapies', NULL, NULL),
    (237, 'Natural Remedies', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_emotional_s_alternative()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (295, 'Acupuncture', NULL, NULL),
    (295, 'Chiropractic Care', NULL, NULL),
    (295, 'Herbal Medicine', NULL, NULL);
END;
$$ LANGUAGE plpgsql;   

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_emotional_s_complementary()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (296, 'Massage Therapy', NULL, NULL),
    (296, 'Aromatherapy', NULL, NULL),
    (296, 'Reiki', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_emotional_s_natural()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (297, 'Homeopathy', NULL, NULL),
    (297, 'Naturopathy', NULL, NULL),
    (297, 'Natural herbs', NULL, NULL);
END;
$$ LANGUAGE plpgsql; 

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_reproductive()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (238, 'Women’s Health', NULL, NULL),
    (238, 'Men’s Health', NULL, NULL),
    (238, 'Sexual Health', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_occupational()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (239, 'Workplace Wellness Programs', NULL, NULL),
    (239, 'Occupational Therapy', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_public()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (240, 'Community Health', NULL, NULL),
    (240, 'Global Health', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_subcategories_health_s_enviroment()
AS $$
BEGIN
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (241, 'Healthy Living Environments', NULL, NULL),
    (241, 'Sustainable Living', NULL, NULL);
END;
$$ LANGUAGE plpgsql;
