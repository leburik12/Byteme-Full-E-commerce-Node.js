CREATE OR REPLACE PROCEDURE insert_parent_categories_vehicle()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (8, 'Passenger Vehicles', NULL, NULL),
    (8, 'Trucks', NULL, NULL),
    (8, 'Buses', NULL, NULL),
    (8, 'Vans', NULL, NULL),
    (8, 'Two-Wheelers', NULL, NULL),
    (8, 'Electric Vehicles', NULL, NULL),
    (8, 'Parts and Components', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_vehicle_s_passenger()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (182, 'Sedans', NULL, NULL),
    (182, 'Hatchbacks', NULL, NULL),
    (182, 'SUVs', NULL, NULL),
    (182, 'Coupes', NULL, NULL),
    (182, 'Convertibles', NULL, NULL),
    (182, 'Station Wagons', NULL, NULL),
    (182, 'Crossovers', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_vehicle_s_truck()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (183, 'Light Trucks', NULL, NULL),
    (183, 'Medium Trucks', NULL, NULL),
    (183, 'Heavy Trucks', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_vehicle_s_buses()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (184, 'City Buses', NULL, NULL),
    (184, 'Coaches', NULL, NULL),
    (184, 'School Buses', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_vehicle_s_vans()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (185, 'Cargo Vans', NULL, NULL),
    (185, 'Passenger Vans', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_vehicle_s_parts()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (188, 'Engine Components', NULL, NULL),
    (188, 'Electrical & Electronic Systems', NULL, NULL),
    (188, 'Chassis and Suspension', NULL, NULL),
    (188, 'Transmission Systems', NULL, NULL),
    (188, 'Braking Systems', NULL, NULL),
    (185, 'Exhaust Systems', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_vehicle_s_engine()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (206, 'Cylinders', NULL, NULL),
    (206, 'Pistons', NULL, NULL),
    (206, 'Crankshafts', NULL, NULL),
    (206, 'Camshafts', NULL, NULL),
    (206, 'Turbochargers', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_vehicle_s_electrical()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (207, 'Batteries', NULL, NULL),
    (207, 'Alternators', NULL, NULL),
    (207, 'Starters', NULL, NULL),
    (207, 'Electronic Control Units (ECUs)', NULL, NULL),
    (207, 'Infotainment Systems', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_vehicle_s_chasis()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (208, 'Shock Absorbers', NULL, NULL),
    (208, 'Struts', NULL, NULL),
    (208, 'Springs', NULL, NULL),
    (208, 'Control Arms', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_vehicle_s_transmission()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (209, 'Gearboxes', NULL, NULL),
    (209, 'Clutches', NULL, NULL),
    (209, 'Differentials', NULL, NULL),
    (209, 'Driveshafts', NULL, NULL);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE insert_parent_categories_vehicle_s_breaking()
AS $$
BEGIN 
    INSERT INTO lukup_category (id_parent_category, name, type, media_url) VALUES 
    (210, 'Braking Systems', NULL, NULL),
    (210, 'Brake Pads', NULL, NULL),
    (210, 'Brake Discs', NULL, NULL),
    (210, 'Anti-lock Braking Systems (ABS)', NULL, NULL);
END;
$$ LANGUAGE plpgsql;






