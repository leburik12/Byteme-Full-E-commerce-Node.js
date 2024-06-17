CREATE OR REPLACE PROCEDURE insert_random_products (counter INTEGER)
LANGUAGE plpgsql 
AS $$
DECLARE 
    i INTEGER := 1;
    random_name VARCHAR(255);
    first_chars VARCHAR(32);
    second_chars VARCHAR(32);
    random_int INTEGER;
BEGIN 
   WHILE i <= counter LOOP
       first_chars := MD5(random()::TEXT);
       second_chars := MD5(random()::TEXT);
       random_name = first_chars || ' ' || second_chars;

       random_int = floor(random() * 10) + 1;

       INSERT INTO product (name, ptype) VALUES (random_name, random_int);
    i := i + 1;
    END LOOP;
END;
$$;

