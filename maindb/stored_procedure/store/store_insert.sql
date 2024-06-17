CREATE OR REPLACE PROCEDURE store_dummy_data_generator(count INTEGER)
LANGUAGE plpgsql
AS $$ 
  DECLARE
      i INTEGER := 1;
      id_user INTEGER;
      store_choice INTEGER;
      store_name VARCHAR(255);
      store_description TEXT;

BEGIN 
    WHILE i <= count LOOP

        store_choice := FLOOR (random() * 5) + 1;
        --id_user := random() * 17 + 3;
        store_name = SUBSTRING(MD5(random()::TEXT) FROM 1 FOR 16);
        store_description = MD5(random()::TEXT) || ' ' || MD5(random()::TEXT)
                            || MD5(random()::TEXT) || MD5(random()::TEXT);
        INSERT INTO store (id_user,name,description,store_type) VALUES(3,store_name,store_description,store_choice);
        i := i + 1;
    END LOOP; 
END;
$$;
