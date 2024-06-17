CREATE OR REPLACE PROCEDURE inventory_random_inserts (count INTEGER)
LANGUAGE plpgsql
AS $$
  DECLARE 
     i INTEGER := 1; 
     title VARCHAR(255);
     description TEXT;
     details TEXT;
     id_brand INTEGER := 1;
     id_product INTEGER;
     id_store INTEGER;
     is_auctioned BOOLEAN;
     brand varchar(255);
     manufacturer varchar(255);
     stock_status SMALLINT;
     sku VARCHAR(100);
     batch_number VARCHAR(100);
     restock_threshold INTEGER;
     quantity INTEGER;
     random_days INTEGER;
     expiration_date TIMESTAMPTZ;
     is_approved BOOLEAN;
     
    BEGIN
        WHILE i <= count LOOP
            title := MD5(random()::TEXT);
            description := MD5(random()::TEXT) || ' ' ||  MD5(random()::TEXT) || ' '  || MD5(random()::TEXT);
            details := MD5(random()::TEXT) || ' ' ||  MD5(random()::TEXT) || ' '  || MD5(random()::TEXT);
            id_brand :=  floor(random() * 8 + 1); -- select from id 1 upto 8 since the brand table got 8 elements with id from 1- 8
            id_product := floor(random() * 100 + 1); -- id from 1 upto 100 from product table
            id_store := floor(random() * 29 + 33); -- id from 33 - 62 from store table
            is_auctioned := FLOOR(random() * 2)::INT;  -- true of false 0 or 1
            brand := MD5(random()::TEXT);
            manufacturer := MD5(random()::TEXT);
            stock_status := FLOOR(random() * 3)::INT; 
            sku := MD5(random()::TEXT);
            batch_number := MD5(random()::TEXT);
            quantity := floor(random() * 100 + 1);
            restock_threshold := quantity/2;
            random_days := floor(random() * 30) + 1;
            expiration_date := NOW() + random_days * INTERVAL '1 DAY';
            is_approved := FLOOR(random() * 2)::INT;  -- true of false 0 or 1

            INSERT INTO inventory (title,description,details,id_brand,id_product,id_store,is_auctioned,brand,manufacturer,stock_status,sku,batch_number,quantity,restock_threshold,expiration_date,is_approved)
            VALUES (title,description,details,id_brand,id_product,id_store,is_auctioned,brand,manufacturer,stock_status,sku,batch_number,quantity,restock_threshold,expiration_date,is_approved);
            i := i + 1;
        END LOOP;
   END;
$$;



