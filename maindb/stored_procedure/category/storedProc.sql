create or replace function insert_country (name VARCHAR(30),phone_code VARCHAR(5))
returns void as $$ 
BEGIN
   INSERT INTO country (id, country_name, country_phone_code)
   VALUES (name,phone_code);
END;
$$ LANGUAGE plpgsql;

create or replace PROCEDURE insert_country(name VARCHAR(30),phone_code VARCHAR(5))
LANGUAGE plpgsql
as $$
BEGIN
    INSERT INTO country (country_name, country_phone_code)
    VALUES (name,phone_code);
end;
$$;
   