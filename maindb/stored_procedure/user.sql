CREATE OR REPLACE PROCEDURE insert_random_user (count INTEGER)
LANGUAGE plpgsql
AS $$
    DECLARE 
       i INTEGER := 1;
       id_role INTEGER;
       first_name VARCHAR(255) := '';
       last_name VARCHAR(255) := '';
       phone VARCHAR(12) := '';
       gender VARCHAR(1);
       email VARCHAR(100);
       email_domain VARCHAR(10) := 'byteme.com';
       user_uuid UUID;
       password_hash VARCHAR(60);
BEGIN
     
    WHILE i <= count LOOP
        id_role := FLOOR(RANDOM() * 2) + 5; -- data inserted already in the roles table with id from 1 upto 6 then fetching random role id
        gender := CASE FLOOR(random() * 2)::INT 
                  WHEN 0 THEN 'm' 
                  ELSE 'f'
                  END;
        SELECT uuid_generate_v4() INTO user_uuid;
        FOR i IN 1..12 LOOP
                first_name := first_name || CHR(97 + FLOOR(random() * 26)::INT);
                last_name  := last_name || CHR(97 + FLOOR(random() * 26)::INT);
                phone := phone || (FLOOR(random() * 10)::INT)::TEXT;
                email := email || CHR(97 + FLOOR(random() * 26)::INT);
        END LOOP; 
        email := email || '@' || email_domain;

        
        password_hash := MD5(random()::TEXT) || SUBSTRING(MD5(random()::TEXT) FROM 1 FOR 28);

        INSERT INTO "user" (id_role,user_uuid,first_name,last_name,phone,gender,password_hash)
        VALUES (id_role, user_uuid,first_name,last_name,phone,gender,password_hash);
        first_name := '';
        last_name := '';
        phone := '';
        email := ''; 
        i := i + 1;
    END LOOP;
END;
$$;


      
