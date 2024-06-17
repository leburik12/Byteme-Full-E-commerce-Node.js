SET client_encoding = 'UTF8';
SET standard_conforming_strings = ON;
SET statement_timeout = 0;
/*   Load the extension  */
CREATE EXTENSION postgis; -- for using spatial data types (geometry, point)
CREATE EXTENSION pgcrypto; -- for using crpto function (uuid, gen_random_uuid)

CREATE DOMAIN unsigned_integer INTEGER CHECK (unsigned_column >= 0);
CREATE TYPE enum_id_type AS ENUM('passport', 'international_id','driving licence');
CREATE TYPE enum_mode_type AS ENUM('products', 'user', 'inventory', 'chat', 'advertise');
CREATE TYPE enum_ambiance AS ENUM('casual','fine_dining','formal','lively','romantic','family_friendly','trendy','rustic','industrial','sports_bar','quiet');
CREATE TYPE enum_michelin_stars AS ENUM('none', 'one', 'two', 'three');
CREATE TYPE enum_order_priority AS ENUM('regular', 'high', 'rush');
CREATE TYPE enum_order_creation_channel AS ENUM('website', 'mobile app', 'third-party');
CREATE TYPE enum_shipping_method AS ENUM('standard', 'expedited', 'express');
CREATE TYPE enum_completion_reason AS ENUM('bid_accepted', 'bid_withdrawn', 'reserve_not_met', 'item_withdrawn', 'expired', '');
CREATE TYPE enum_control_mechanism AS ENUM('Direct Ownership', 'Contractual Arrangements', 'Legal Structures', 'Personal Influence');
CREATE TYPE enum_subscription_status AS ENUM('active', 'inactive');
CREATE TYPE enum_subscription_type AS ENUM('monthly', 'yearly', 'lifetime');
CREATE TYPE enum_discount_type AS ENUM('percentage', 'flat_rate');

CREATE TABLE IF NOT EXISTS roles (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    role_name VARCHAR(30) NOT NULL,
    description VARCHAR(255),
    isactive BOOLEAN DEFAULT 't'
);  

CREATE TABLE IF NOT EXISTS product (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY ,
    name VARCHAR(255) NOT NULL,
    ptype SMALLINT, /* food, drink,event,meal category id */ 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS lukup_category ( 
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_parent_category INTEGER,
  name VARCHAR(30) NOT NULL,
  type SMALLINT, /* Food, groceries,book,event */ 
  media_url VARCHAR(200),
  upload_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  update_date TIMESTAMPTZ,
  FOREIGN KEY (id_parent_category) REFERENCES lukup_category(id) ON UPDATE CASCADE
);
CREATE INDEX idx_categories_name_lukup ON lukup_category(name);

CREATE TABLE IF NOT EXISTS status (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY ,
    status_name VARCHAR(8) NOT NULL   
);

CREATE TABLE IF NOT EXISTS country (
    id VARCHAR(5) PRIMARY KEY NOT NULL,
    country_name VARCHAR(30) NOT NULL UNIQUE,
    country_image_url VARCHAR(255),
    country_phone_code VARCHAR(5)
);

CREATE TABLE IF NOT EXISTS states (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    state_name VARCHAR(30) NOT NULL,
    id_country VARCHAR(5),
    --geom_location GEOMETRY(Point, 4326),
    FOREIGN KEY (id_country) REFERENCES country(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_state_name ON states(state_name);
CREATE INDEX idx_geom_location_states ON states USING GIST (geom_location);

CREATE TABLE IF NOT EXISTS city (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    city_name VARCHAR(30) NOT NULL,
    --id_country VARCHAR(5),
    id_state INTEGER, 
    is_shipping_available BOOLEAN NOT NULL,
    FOREIGN KEY (id_country) REFERENCES country(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_state) REFERENCES states(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_city_name ON city(city_name);

CREATE TABLE IF NOT EXISTS districts (
       id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
       district_name VARCHAR(30) NOT NULL,
       id_city INTEGER,
       is_shipping_available BOOLEAN NOT NULL,
       --geom_location GEOMETRY(Point, 4326),
       FOREIGN KEY (id_city) REFERENCES city(id) ON DELETE SET NULL ON UPDATE CASCADE 
);
CREATE INDEX idx_district_name ON districts(district_name);
CREATE INDEX idx_district_geom ON districts USING GIST (geom_location);

CREATE TABLE IF NOT EXISTS "user" (
       id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
       id_district INTEGER, 
       id_role INTEGER,
       user_uuid UUID DEFAULT uuid_generate_v4(),
       first_name VARCHAR(30) NOT NULL,
       last_name VARCHAR(30) NOT NULL,
       phone VARCHAR(12) NOT NULL,
       gender BOOLEAN NOT NULL,
       id_type SMALLINT,
       email VARCHAR(100) UNIQUE NOT NULL,
       password_hash VARCHAR(60) NOT NULL,
       is_active BOOLEAN NOT NULL DEFAULT 't', 
       is_id_verified BOOLEAN NOT NULL DEFAULT 'f',
       --rating DECIMAL(3,1) NOT NULL,
       --geom_location GEOMETRY(Point, 4326),
       FOREIGN KEY (id_role) REFERENCES roles(id) ON DELETE SET NULL ON UPDATE CASCADE ,
       FOREIGN KEY (id_district) REFERENCES districts(id) ON DELETE SET NULL ON UPDATE CASCADE 
);

  CREATE TABLE user_permission_entity (
      id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
      --id_user INTEGER,
      id_table_list INTEGER,
      operation SMALLINT, /* add,change,delete,view */
      created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
      --FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY (id_table_list) REFERENCES table_list(id) ON DELETE CASCADE ON UPDATE CASCADE
  );
/*
CREATE TABLE IF NOT EXISTS lukup_permission ( -- delete
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    privilege_level SMALLINT DEFAULT 2, -- high-1,medium-2,low-3
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS permission_role (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_permission INTEGER,
    id_role INTEGER,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    FOREIGN KEY (id_permission) REFERENCuser_permission_entityES lukup_permission(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_role) REFERENCES roles(id) ON DELETE CASCADE ON UPDATE CASCADE
);
*/
CREATE TABLE IF NOT EXISTS grouprole -- group permission
(
   id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY ,
   name groupname,
   --id_role INT,
   --id_user INT,
   created TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (id_role) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE CASCADE,
   FOREIGN KEY (id_user) REFERENCES "user"(id)
);

/*
CREATE TABLE IF NOT EXISTS request_throttle (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY ,
    amount INTEGER,
    severity SMALLINT NOT NULL DEFAULT 3 /*('high', 'medium', 'low')*/ 
);
CREATE TABLE IF NOT EXISTS authtoken_token
(
   id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY ,
   authkey VARCHAR(40) NOT NULL UNIQUE,
   refersh_token VARCHAR(40) NOT NULL UNIQUE,
   id_user INTEGER,
   remaining_requests INTEGER NOT NULL DEFAULT 0,
   created TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
   expires_at TIMESTAMPTZ(6) NOT NULL,
   FOREIGN KEY (id_user) REFERENCES "user"(id)
);
*/

CREATE TABLE IF NOT EXISTS brand (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  category_id INTEGER,
  --verified BOOLEAN DEFAULT FALSE,
  --description VARCHAR(255),
  logo_url VARCHAR(255),
  --website_url VARCHAR(255),
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ
);
CREATE INDEX idx_brand_name ON brand(id);

CREATE TABLE IF NOT EXISTS store (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_user INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    brands_name VARCHAR(255) NOT NULL,
    website_url VARCHAR(255),
    branchs INTEGER DEFAULT '1',
    approved BOOLEAN DEFAULT FALSE,
    postal_code VARCHAR(6),
    store_choice SMALLINT, /* ('liquior','coffee shop','cafe','supermarket','mini-market','restaurants','bar')  */
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ
);
CREATE INDEX idx_store_name ON store(id);

CREATE TABLE  IF NOT EXISTS store_location (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  id_city INTEGER,
  id_store INTEGER,
  contact_phone VARCHAR(20),
  contact_email VARCHAR(100),
  floor INTEGER,  -- optional
  --postal_code VARCHAR(10) NOT NULL,
  opening_hour TIME NOT NULL,
  closing_hour TIME NOT NULL,
  geom_location GEOMETRY(Point, 4326),
  
  FOREIGN KEY (id_city) REFERENCES city(id) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (id_store) REFERENCES store(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX idx_store_loct_geom ON store_location USING GIST (geom_location);

CREATE INDEX idx_user_first_name ON "user"(first_name);
CREATE INDEX idx_user_phone ON "user"(phone);
CREATE INDEX idx_user_geom ON "user" USING GIST (geom_location);

CREATE TABLE IF NOT EXISTS user_role (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_user INTEGER,
    id_role INTEGER,
    FOREIGN KEY (id_role) REFERENCES roles(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS m_language (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    code VARCHAR(10) NOT NULL UNIQUE,
    m_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
);
CREATE INDEX idx_m_name ON m_language(m_name);

CREATE TABLE IF NOT EXISTS payment_method (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    method_description TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ
);
CREATE INDEX idx_m_name ON payment_method(method_name);

CREATE TABLE IF NOT EXISTS inventory (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_brand INTEGER,
    id_product INTEGER,
    id_storelocation INTEGER,
    is_auctioned BOOLEAN NOT NULL DEFAULT 'f',
    brand varchar(255),
    manufacturer varchar(255),
    stock_status SMALLINT NOT NULL /*('In Stock', 'Out of Stock', 'Low Stock')*/ ,
    sku VARCHAR(100) NOT NULL,
    batch_number VARCHAR(100) NOT NULL UNIQUE,
    restock_threshold INTEGER NOT NULL,
    quantity INTEGER DEFAULT 1 NOT NULL CHECK (quantity >= 1),
    expiration_date TIMESTAMPTZ NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    details TEXT NOT NULL,
    is_approved BOOLEAN DEFAULT 'f',
    upload_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    update_date TIMESTAMPTZ,
    FOREIGN KEY (id_brand) REFERENCES brand(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_product) REFERENCES product(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_storelocation) REFERENCES store_location(id) ON DELETE SET NULL ON UPDATE CASCADE
); 
CREATE TABLE IF NOT EXISTS search_key_inventory (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  key_name VARCHAR(100),
  id_inventory INTEGER,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id)
);
CREATE INDEX idx_key_name ON search_key_inventory(key_name);

CREATE TABLE IF NOT EXISTS inventory_bulletlist (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_inventory INTEGER,
    note TEXT NOT NULL,
    FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS upc (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    upc_code VARCHAR(12) NOT NULL UNIQUE,
    id_inventory INTEGER,
    FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_upc_code ON upc(upc_code);

CREATE TABLE IF NOT EXISTS common_specification (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  id_inventory INTEGER,
  id_color INTEGER,
  height DECIMAL(4,2),
  weight DECIMAL(7,2),
  width DECIMAL(7,2),
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS lukup_specification (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS lukup_product_specification (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_product INT,
    id_spec INTEGER,
    ps_name VARCHAR(255),
    FOREIGN KEY (id_spec) REFERENCES lukup_specification(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_product) REFERENCES product(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS lukup_category_specification  (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  id_category INTEGER,
  id_spec INTEGER,
  cp_name VARCHAR(255),
  FOREIGN KEY (id_category) REFERENCES lukup_category(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_spec) REFERENCES lukup_specification(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS store_detail (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_store_location INTEGER,
    id_store INTEGER,
    addr VARCHAR(255) NOT NULL,
    is_main_branch BOOLEAN DEFAULT true,
    open_time TIMESTAMPTZ NOT NULL,
    close_time TIMESTAMPTZ NOT NULL,
    is_delivery_available BOOLEAN DEFAULT true,
    website_url VARCHAR(255),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    FOREIGN KEY (id_store) REFERENCES store(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_store_location) REFERENCES store_location(id) ON DELETE SET NULL ON UPDATE CASCADE
);
/* TO DO - CHECK CONSTRAINT ON OPEN TIME AND CLOSE TIME */


CREATE TABLE IF NOT EXISTS store_accessiblity (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  id_store_location INTEGER,
  is_parking_accessible BOOLEAN DEFAULT FALSE NOT NULL,
  is_restroom_accessible BOOLEAN DEFAULT FALSE NOT NULL,
  is_wheelchair_accessible BOOLEAN DEFAULT FALSE NOT NULL,
  FOREIGN KEY (id_store_location) REFERENCES store_location(id)
);

CREATE TABLE IF NOT EXISTS Clerks (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_role INTEGER ,
    id_inventory INTEGER,
    id_user INTEGER ,
    id_storelocation INTEGER,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    FOREIGN KEY (id_role) REFERENCES roles(id),
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_storelocation) REFERENCES store_location(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS media_url (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_user INTEGER,
  media_content_url TEXT NOT NULL,
  media_type enum_mode_type,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS media_user (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_user INTEGER,
  id_media INTEGER,
  title VARCHAR(255), 
  description TEXT, 
  FOREIGN KEY (id_user) REFERENCES media_url(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_media) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS fullfillment_type (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    fname VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS delivery_status (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    dsname VARCHAR(50) NOT NULL,
    status_desc TEXT
);
CREATE INDEX idx_deli_status_name ON delivery_status(dsname);

CREATE TABLE IF NOT EXISTS order_status (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    osname VARCHAR(50) NOT NULL, 
    descr VARCHAR(100) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ
); 

CREATE TABLE IF NOT EXISTS store_fullfillment (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_fullfillment INTEGER,
    id_inventory INTEGER,
    FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_fullfillment) REFERENCES fullfillment_type(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS return_reason (
   id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
   return_reason VARCHAR(255) NOT NULL,
   created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);  

CREATE TABLE IF NOT EXISTS "order" (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  id_customer INTEGER,
  id_status INTEGER,
  --id_payment_method INTEGER ,
  id_delivery_method INTEGER ,
  --id_delivery_zone INTEGER,
  id_fullfillment INTEGER,
  id_order_cancel_reason INTEGER,
  --order_total DECIMAL(10,2) NOT NULL CHECK (order_total >= 0.00),
  --shipping_address_id TEXT NOT NULL,
  shipping_method enum_shipping_method,
  promotion_code VARCHAR(255),
  internal_notes TEXT,
  order_creation_channel enum_order_creation_channel,
  order_priority enum_order_priority DEFAULT 'regular',
  discount_amount DECIMAL(8,2) CHECK (discount_amount >= 0.00),
  shipping_cost DECIMAL(8, 2) NOT NULL CHECK (shipping_cost >= 0.00),
  paid BOOLEAN DEFAULT 'f',
  order_confirmation_email_sent_date TIMESTAMPTZ,
  order_date TIMESTAMPTZ NOT NULL,
  --order_refund_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (id_payment_method) REFERENCES payment_method(id) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (id_status) REFERENCES order_status(id) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (id_customer) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_fullfillment) REFERENCES fullfillment_type(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS order_item (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_order INTEGER,
    id_inventory INTEGER,
    quantity INTEGER,
    unit_price DECIMAL(10, 2) NOT NULL,

    FOREIGN KEY (id_order) REFERENCES "order"(id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
/* TO DO.  ADD COUPON CODE  */

CREATE TABLE IF NOT EXISTS cart (
   id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
   id_customer INTEGER,
   added_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
   checked_out BOOLEAN DEFAULT FALSE,
   FOREIGN KEY (id_customer) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS order_delivery_address (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  id_order INTEGER,
  addressline VARCHAR(30),
  phone VARCHAR(12),
  email VARCHAR(255) NOT NULL,
  geom_location GEOMETRY(Point, 4326),
  FOREIGN KEY (id_order) REFERENCES "order"(id)
);
CREATE INDEX idx_geom_location_oda ON order_delivery_address USING GIST (geom_location);

CREATE TABLE IF NOT EXISTS refund ( 
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  id_approver INTEGER,
  id_order INTEGER,
  id_refund INTEGER,
  refund_amount DECIMAL(10,2) CHECK (refund_amount >= 0.00),
  return_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  return_shipment_tracking_number uuid DEFAULT gen_random_uuid(),
  returnreason_id INTEGER,
  comment TEXT,
  FOREIGN KEY (id_order) REFERENCES "order"(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_refund) REFERENCES return_reason(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX idx_return_shipment_track_num ON refund(return_shipment_tracking_number);

CREATE TABLE IF NOT EXISTS caching_setting (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_user INTEGER,
    setting_description TEXT,
    setting_date TIMESTAMPTZ,
    setting_is_default BOOLEAN,
    setting_is_custom BOOLEAN,
    setting_is_global BOOLEAN,
    setting_is_local BOOLEAN,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS caching_type (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    caching_type_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS caching_feature (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    caching_feature_name VARCHAR(255) NOT NULL
);
/* TO DO more implementation detail */
CREATE TABLE IF NOT EXISTS caching_settings_detail (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_caching_setting INTEGER,
    id_caching_type INTEGER,
    id_caching_feature INTEGER,
    is_enabled BOOLEAN,
    FOREIGN KEY (id_caching_setting) REFERENCES caching_setting(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_caching_type) REFERENCES caching_type(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_caching_feature) REFERENCES caching_feature(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS caching_expiry_setting (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_caching_settings INTEGER,
    id_caching_type INTEGER,
    expiry_duration INTEGER, -- Duration in minutes
    FOREIGN KEY (id_caching_settings) REFERENCES caching_setting(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_caching_type) REFERENCES caching_type(id) ON UPDATE CASCADE ON DELETE CASCADE
);
/* Specification table */
/* TO DO Check the indexs (single index, double index or compound index ) EXPLAIN ANALYZE*/
CREATE TABLE IF NOT EXISTS color_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  color_name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS power_source_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  power_source_name VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS power_source_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_power_source INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_power_source) REFERENCES power_source_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_power_source ON power_source_spec_product(id_power_source);

CREATE TABLE IF NOT EXISTS material_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  material_name VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS material_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_material INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_material) REFERENCES material_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_materialid ON material_spec_product(id_material);

CREATE TABLE IF NOT EXISTS features_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  features_name VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS features_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_features INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_features) REFERENCES features_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_featuresid ON features_spec_product(id_features);

CREATE TABLE IF NOT EXISTS components_included_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  components_included_name VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS components_included_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_components_included INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_components_included) REFERENCES components_included_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_components_includedid ON components_included_spec_product(id_components_included);

CREATE TABLE IF NOT EXISTS finish_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  finish_name VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS finish_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_finish INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_finish) REFERENCES finish_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_finishid ON finish_spec_product(id_finish);

CREATE TABLE IF NOT EXISTS voltage_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  voltage_name VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS voltage_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_voltage INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_voltage) REFERENCES voltage_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_voltageid ON voltage_spec_product(id_voltage);

CREATE TABLE IF NOT EXISTS food_compatibility_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  food_compatibility VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS food_compatibility_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_food_compatibility INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_food_compatibility) REFERENCES food_compatibility_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_food_compatibilityid ON food_compatibility_spec_product(id_food_compatibility);

CREATE TABLE IF NOT EXISTS capacity_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  capacity DECIMAL(10, 2) NOT NULL UNIQUE CHECK (capacity >= 0.00)
);
CREATE TABLE IF NOT EXISTS capacity_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_capacity INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_capacity) REFERENCES capacity_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_capacityid ON capacity_spec_product(id_capacity);

CREATE TABLE IF NOT EXISTS num_of_door_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  data SMALLINT NOT NULL
);
CREATE TABLE IF NOT EXISTS num_of_door_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_num_of_door INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_num_of_door) REFERENCES num_of_door_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_num_of_doorid ON num_of_door_spec_product(id_num_of_door);

CREATE TABLE IF NOT EXISTS num_of_shelve_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  data SMALLINT NOT NULL
);
CREATE TABLE IF NOT EXISTS num_of_shelve_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_num_of_shelve INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_num_of_shelve) REFERENCES num_of_shelve_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_num_of_shelveid ON num_of_shelve_spec_product(id_num_of_shelve);

CREATE TABLE IF NOT EXISTS num_of_drawer_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  data SMALLINT NOT NULL
);
CREATE TABLE IF NOT EXISTS num_of_drawer_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_num_of_drawer INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_num_of_drawer) REFERENCES num_of_drawer_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_num_of_drawerid ON num_of_drawer_spec_product(id_num_of_drawer);

CREATE TABLE IF NOT EXISTS smart_home_protocol_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  smart_home_protocol_name VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS smart_home_protocol_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_smart_home_protocol INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_smart_home_protocol) REFERENCES smart_home_protocol_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_smart_home_protocolid ON smart_home_protocol_spec_product(id_smart_home_protocol);

CREATE TABLE IF NOT EXISTS style_spec (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  style_name VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS style_spec_product (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_style INTEGER,
  id_inventory INTEGER,
  FOREIGN KEY (id_style) REFERENCES style_spec(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_styleid ON style_spec_product(id_style);

CREATE TABLE IF NOT EXISTS saved_store (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_user INTEGER,
  id_store INTEGER,
  FOREIGN KEY (id_store) REFERENCES store(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS offer (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_user INTEGER, 
  id_inventory INTEGER,
  offer_price DECIMAL(10, 2) NOT NULL CHECK (offer_price >= 0.00),
  offer_time TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  offer_accepted BOOLEAN NOT NULL DEFAULT FALSE,
  status VARCHAR(255) NOT NULL DEFAULT 'pending',
  FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS buy_now_price (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    buy_now_price DECIMAL(10, 2) NOT NULL UNIQUE CHECK (buy_now_price >= 0.00),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS auction (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_inventory INTEGER, 
  id_user_winner INTEGER,
  id_user_seller INTEGER,
  title VARCHAR(150) NOT NULL,
  description TEXT NOT NULL,
  starting_price DECIMAL(10, 2) NOT NULL CHECK (starting_price >= 0.00),
  reserve_price DECIMAL(10, 2) CHECK (reserve_price >= 0.00),
  auction_start_time TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  auction_end_time TIMESTAMPTZ NOT NULL,
  status VARCHAR(10) NOT NULL DEFAULT 'pending',
  is_completed_flg BOOLEAN NOT NULL DEFAULT 't',
  completion_reason enum_completion_reason DEFAULT '',
  CONSTRAINT auction_date_valid CHECK (auction_start_time <= auction_end_time),

  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (id_user_seller) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_user_winner) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS bid (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_auction INTEGER,
  id_user_bidder INTEGER,
  bid_amount DECIMAL(10, 2) NOT NULL CHECK (bid_amount >= 0.00),
  bid_time TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (id_auction) REFERENCES auction(id) ON UPDATE CASCADE ,
  FOREIGN KEY (id_user_bidder) REFERENCES "user"(id) ON UPDATE CASCADE 
);

CREATE TABLE IF NOT EXISTS auto_bid (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_user INTEGER,
  id_auction INTEGER,
  max_bid DECIMAL(10, 2) NOT NULL CHECK (max_bid >= 0.00),
  increment_bid DECIMAL(10, 2) NOT NULL CHECK (increment_bid >= 0.00),

  FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_auction) REFERENCES auction(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS delivery_option (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  is_avail_ecommerce BOOLEAN NOT NULL DEFAULT '1',
  is_avail_food_delivery BOOLEAN NOT NULL DEFAULT '1',
  cost DECIMAL(10,2) CHECK (cost >= 0.00),
  estimated_delivery_time TIMESTAMPTZ NOT NULL
);

CREATE TABLE IF NOT EXISTS add_to_watchlist (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_user INTEGER,
  id_inventory INTEGER,
  /*item_type SMALLINT NOT NULL DEFAULT 1,*/
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE ,
  FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE SET NULL ON UPDATE CASCADE
);

/* used in fintech purpose but need ajustement */
CREATE TABLE IF NOT EXISTS ubo_verification_document (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  id_user INTEGER,
  id_verifier INTEGER,
  document_type VARCHAR(20) NOT NULL,
  document_number VARCHAR(15) NOT NULL UNIQUE,
  document_issuer VARCHAR(100) NOT NULL,
  document_issue_date TIMESTAMPTZ NOT NULL,
  document_expiry_date TIMESTAMPTZ NOT NULL,
  ownership_percentage DECIMAL(5, 2) NOT NULL CHECK (ownership_percentage >= 0.00),
  document_file_path VARCHAR(255) NOT NULL,
  document_id VARCHAR(255) NOT NULL,
  document_verification_status VARCHAR(20) NOT NULL,
  tax_identification_number VARCHAR(20) NOT NULL UNIQUE,
  verification_comments VARCHAR(100) NOT NULL,
  verification_date TIMESTAMPTZ NOT NULL,
  
  FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_verifier) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ubo_business_affiliation (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_ubo UUID,
  id_verifier INTEGER,
  affiliation_type VARCHAR(20),
  affiliation_name VARCHAR(255) NOT NULL,
  affiliation_description VARCHAR(255) NOT NULL,
  verification_status VARCHAR(20),
  verification_comment VARCHAR(255),
  verification_date TIMESTAMPTZ NOT NULL,
  FOREIGN KEY (id_ubo) REFERENCES ubo_verification_document(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_verifier) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS regulatory_sanction (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_sanctioning_authority INTEGER,
    sanctioned_entity VARCHAR(20) NOT NULL, /* "INDIVIDUAL", "COMPANY" */
    entity_name VARCHAR(100) NOT NULL,  /* full name of the sanctioned entity */
    reason TEXT NOT NULL,
    sanction_type SMALLINT NOT NULL, /* Order Ban,Payment Block,Delivery Restriction,Account Suspension,
                                       Account Termination,Product Listing Block,Product Removal,Seller Account Restriction,
                                       Driver Account Restriction,Promotional Block,Review Restriction */
    is_sanction_active BOOLEAN NOT NULL,
    sanction_outcome VARCHAR(20) NOT NULL,
    start_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    end_date TIMESTAMPTZ NOT NULL,
    sanctions_list VARCHAR(255) NOT NULL,
    additional_information TEXT,
    last_updated TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT regulatory_sanctions_date_valid CHECK (start_date <= end_date),
    FOREIGN KEY (id_sanctioning_authority) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS product_sanction (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_inventory INTEGER,
    id_sanction INTEGER,
    FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_sanction) REFERENCES regulatory_sanction(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS store_sanction (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_store INTEGER,
    id_sanction INTEGER,
    FOREIGN KEY (id_store) REFERENCES store(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (id_sanction) REFERENCES regulatory_sanction(id) ON UPDATE CASCADE ON DELETE CASCADE
);
/* TO DO WHat is the use of it ?  
CREATE TABLE IF NOT EXISTS store_report (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);
*/ 
/* user complaint */
/*lukup number - 3.25*/
CREATE TABLE IF NOT EXISTS lukup_complaint_category (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL
);
/*lukup number - 3.26*/
CREATE TABLE IF NOT EXISTS lukup_complaint_reason (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_category INTEGER,
  reason_text VARCHAR(255) NOT NULL,
  FOREIGN KEY (id_category) REFERENCES lukup_complaint_category(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS complaint (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_customer INTEGER,
    id_complaint_reason INTEGER,
    complaint_text TEXT,
    complaint_status SMALLINT DEFAULT 1, /*(Open, In Progress, Resolved)*/
    complaint_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_customer) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_complaint_reason) REFERENCES lukup_complaint_reason(id) ON UPDATE CASCADE ON DELETE NO ACTION
);
CREATE TABLE IF NOT EXISTS store_complaint (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_complaint INT NOT NULL,
    id_store INT NOT NULL,
    FOREIGN KEY (id_complaint) REFERENCES complaint(id) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (id_store) REFERENCES store(id) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS vehicle (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_color INTEGER,
    id_owner INTEGER,
    license_plate VARCHAR(50) UNIQUE NOT NULL,
    vehicle_type SMALLINT, /*('bycycle','e-motocycle','motorcycle','bajaj'),*/
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    FOREIGN KEY (id_color) REFERENCES color_spec(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_owner) REFERENCES "user"(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS delivery_person (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_user INTEGER,
    bmdeliverer VARCHAR(12) UNIQUE NOT NULL,
    id_vehicle INTEGER,
    is_available BOOLEAN NOT NULL DEFAULT TRUE,
    total_rating DECIMAL(2,1) DEFAULT 0.00 CHECK (total_rating >= 0.00),
    total_delivery INTEGER DEFAULT 0,
    current_location POINT,
    last_delivery_time TIMESTAMPTZ,
    is_verified BOOLEAN NOT NULL DEFAULT 'f',
    geom_location GEOMETRY(Point, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (id_vehicle) REFERENCES vehicle(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_geom_location_person ON delivery_person USING GIST (geom_location);

CREATE TABLE IF NOT EXISTS driver_complaint (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_complaint INT NOT NULL,
    id_driver INT NOT NULL,
    FOREIGN KEY (id_complaint) REFERENCES complaint(id) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (id_driver) REFERENCES delivery_person(id) ON UPDATE CASCADE ON DELETE NO ACTION
);
CREATE TABLE IF NOT EXISTS product_complaint (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_complaint INT NOT NULL,
    id_product INT NOT NULL,
    FOREIGN KEY (id_complaint) REFERENCES complaint(id) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (id_product) REFERENCES inventory(id) ON UPDATE CASCADE ON DELETE NO ACTION
);
CREATE TABLE IF NOT EXISTS other_complaint (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_complaint INT NOT NULL,
    complaint_name TEXT NOT NULL,
    FOREIGN KEY (id_complaint) REFERENCES complaint(id) ON UPDATE CASCADE ON DELETE NO ACTION
);
CREATE TABLE IF NOT EXISTS billing_addresses (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_customer INTEGER,
  id_city INTEGER,
  id_district INTEGER,
  address VARCHAR(255),
  phone_num VARCHAR(15),
  is_default_billing_method BOOLEAN DEFAULT '1',
  email VARCHAR(255),
  FOREIGN KEY (id_customer) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_city) REFERENCES city(id) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (id_district) REFERENCES districts(id) ON UPDATE CASCADE 
);
/* lukup number - 3.27 */
CREATE TABLE IF NOT EXISTS lukup_return_reason (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reason_description VARCHAR(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS customer_return_request (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_order INTEGER,
    id_customer INTEGER,
    id_inventory INTEGER,
    id_return_reason INTEGER,
    return_status SMALLINT DEFAULT 1, /*ENUM('Pending', 'Approved', 'Processing', 'Completed') NOT NULL */
    return_date TIMESTAMPTZ,
    return_method VARCHAR(255) NOT NULL,
    return_tracking_number UUID DEFAULT gen_random_uuid(),
    refund_amount DECIMAL(10, 2) CHECK (refund_amount >= 0.00),
    additional_notes TEXT,
    request_timestamp TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_customer) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_order) REFERENCES "order"(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_return_reason) REFERENCES lukup_return_reason(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX idx_return_tracking_number ON customer_return_request(return_tracking_number);
/* lukup number - 3.28 */
CREATE TABLE IF NOT EXISTS lukup_service_type (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    service_type VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
/* customer support */
CREATE TABLE IF NOT EXISTS support_agent (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_user INTEGER,
    assigned_skills TEXT,
    id_authtoken INTEGER,
    last_login_timestamp TIMESTAMPTZ,
    last_logout_timestamp TIMESTAMPTZ,
    login_attempts INTEGER DEFAULT 0,
    suspension_timestamp TIMESTAMP,
    suspension_reason TEXT,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE,
    FOREIGN KEY (id_authtoken) REFERENCES authtoken_token(id) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS service_request (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_customer INTEGER,
    id_order INTEGER ,
    service_status SMALLINT DEFAULT 1,  /*('Open', 'Closed')*/
    descr TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMPTZ,
    assigned_to INTEGER,
    priority SMALLINT DEFAULT 2,   /*'Low', 'High', 'Moderate'*/
    notes TEXT,
    is_resolved BOOLEAN DEFAULT 'f',
    resolution_details TEXT,
    FOREIGN KEY (id_customer) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_order) REFERENCES "order"(id) ON UPDATE CASCADE ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS customer_service_request (
   id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   id_service_request INTEGER,
   id_service_type INTEGER,
   rating_count INTEGER,
   feedback_rating DECIMAL(3,1),
   feedback_comment TEXT,

   FOREIGN KEY (id_service_type) REFERENCES lukup_service_type(id) ON UPDATE CASCADE ON DELETE SET NULL,
   FOREIGN KEY (id_service_request) REFERENCES service_request(id) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS SecuritySettings (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_user INTEGER,
    setting_is_two_factor_authentication_enabled BOOLEAN NOT NULL,
    setting_is_multi_factor_authentication_enabled BOOLEAN NOT NULL,
    setting_is_strong_password_required BOOLEAN NOT NULL,
    setting_is_email_verification_required BOOLEAN NOT NULL,
    setting_is_phone_verification_required BOOLEAN NOT NULL,
    setting_is_captcha_required BOOLEAN NOT NULL,
    setting_is_data_backup_enabled BOOLEAN NOT NULL,
    setting_is_login_attempt_limitation_enabled BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS report (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_created_by INTEGER,
    report_name VARCHAR(255),
    report_description TEXT,
    created_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_created_by) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE
);
/* lukup number - 3.29 */
CREATE TABLE IF NOT EXISTS lukup_report_metric (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rmname VARCHAR(255) NOT NULL,
    metric_description TEXT
);

CREATE TABLE IF NOT EXISTS message_text (
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_user INTEGER,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP ,
  FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE 
);

CREATE TABLE IF NOT EXISTS chat_media_store (
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 id_sender INTEGER,
 id_media_url INTEGER,
 message TEXT,
 is_media_deleted BOOLEAN NOT NULL,
 is_media_reported BOOLEAN ,
 url_part TEXT,
 media_like SMALLINT ,/* Like/Thumbs Up,Love/Heart,Haha/Laugh,Wow,Sad,Angry,Care,Confused,Thankful/Grateful,Support  */
 FOREIGN KEY (id_sender) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE SET NULL,
 FOREIGN KEY (id_media_url) REFERENCES media_url(id) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS chat_room (
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 id_creator INTEGER ,
 chatuuid UUID DEFAULT gen_random_uuid(),
 link_expiry_duration TIMESTAMPTZ NOT NULL,
 is_link_private BOOLEAN DEFAULT 'f',
 title VARCHAR(100) NOT NULL,
 chat_type SMALLINT DEFAULT  1, /*('private', 'group')*/
 chat_is_muted BOOLEAN NOT NULL,
 chat_is_hidden BOOLEAN NOT NULL,
 FOREIGN KEY (id_creator) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE SET NULL
);
CREATE TABLE  IF NOT EXISTS chat_room_media (
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 id_chat_room INTEGER,
 id_chat_media_store INTEGER,
 FOREIGN KEY (id_chat_room) REFERENCES chat_room(id) ON UPDATE CASCADE ,
 FOREIGN KEY (id_chat_media_store) REFERENCES chat_media_store(id) ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS chat_single (
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 id_receiver INTEGER ,
 id_sender INTEGER,
 id_chat_media_store INTEGER,
 FOREIGN KEY (id_chat_media_store) REFERENCES chat_media_store(id) ON UPDATE CASCADE,
 FOREIGN KEY (id_receiver) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE SET NULL,
 FOREIGN KEY (id_sender) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE
);
/* Events */
/* lukup number - 3.30 */
CREATE TABLE IF NOT EXISTS lukup_event_category ( 
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_parent_category INTEGER DEFAULT NULL,
 /* image_url TEXT, dropped column */
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255) /* dropped column */,
  FOREIGN KEY (id_parent_category) REFERENCES lukup_event_category(id) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE organizer (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    organizer_uuid VARCHAR(10) UNIQUE NOT NULL,
    id_city INTEGER,
    id_state INTEGER,
    organizer_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number JSONB NOT NULL,
    website_url VARCHAR(255),
    description TEXT,
    logo_url VARCHAR(255),
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    postal_code VARCHAR(20),
    is_verified BOOLEAN DEFAULT 'f',
    -- Additional fields based on your requirement
    social_media_links JSONB,

    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    FOREIGN KEY (id_city) REFERENCES city(id) ON UPDATE CASCADE,
    FOREIGN KEY (id_state) REFERENCES states(id) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS "event" (
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 id_organizer INTEGER,
 id_event_category INTEGER,
 event_name VARCHAR(255) NOT NULL,
 event_description TEXT,
 event_code UUID DEFAULT gen_random_uuid(),
 start_date TIMESTAMPTZ NOT NULL,
 end_date TIMESTAMPTZ NOT NULL,
 capacity INTEGER,
 dress_code VARCHAR(255),
 age_restriction INTEGER,
 duration INTEGER,
 estatus SMALLINT,
 geom_location GEOMETRY(Point, 4326),
 created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMPTZ,
 CONSTRAINT event_date_valid CHECK (start_date <= end_date),
 FOREIGN KEY (id_organizer) REFERENCES organizer(id) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY (id_event_category) REFERENCES lukup_event_category(id) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE INDEX idx_event_geom_location ON "event" USING GIST (geom_location);
CREATE INDEX idx_event_name ON "event"(event_name);

CREATE TABLE IF NOT EXISTS event_staff (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_staff INTEGER,
    id_event INTEGER,
    id_roles INTEGER,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT NULL,
    FOREIGN KEY (id_staff) REFERENCES event(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_roles) REFERENCES roles(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS organizer_follower (
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 id_organizer INTEGER,
 id_user INTEGER,
 start_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
 end_date TIMESTAMPTZ,
 FOREIGN KEY (id_organizer) REFERENCES "event"(id) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS event_media (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_event INTEGER,
    id_media_url INTEGER,
    FOREIGN KEY (id_event) REFERENCES "event"(id) ON UPDATE CASCADE ,
    FOREIGN KEY (id_media_url) REFERENCES media_url(id) ON UPDATE CASCADE
);

create table IF NOT EXISTS ticket_discount_code (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  ticket_discount_code_num VARCHAR(13) UNIQUE,
  ticketid INT NOT NULL
);

CREATE TABLE IF NOT EXISTS ticket (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ticket_uuid UUID DEFAULT gen_random_uuid(),
    id_event INTEGER,
    ticket_name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    quantity_available INTEGER,
    sale_start_date TIMESTAMP NOT NULL,
    sale_end_date TIMESTAMP NOT NULL,
    is_active BOOLEAN DEFAULT true,
    store_choices SMALLINT, /*('Free Tickets','Donation Tickets','Passes','Virtual Pass','mini-market','restaurants','bar') */
    -- Additional entities
    max_tickets_per_order INTEGER,
    min_tickets_per_order INTEGER DEFAULT 1,
    is_free BOOLEAN DEFAULT 'f',
    currency VARCHAR(3) DEFAULT 'USD',
    ticket_discount_amount DECIMAL(10, 2),
    ticket_promotion_code VARCHAR(255),
    ticket_promotion_amount DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    -- Foreign keys
    CONSTRAINT tickets_valid CHECK (sale_start_date <= sale_end_date),
    FOREIGN KEY (id_event) REFERENCES "event"(id) ON DELETE CASCADE
);
CREATE INDEX idx_ticke_uuid ON ticket(ticket_uuid);

CREATE TABLE IF NOT EXISTS event_tags (
   id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   id_event INTEGER,
   name VARCHAR(30),
   FOREIGN KEY (id_event) REFERENCES "event"(id) ON UPDATE CASCADE
);
/* lukup number - 3.31 */
CREATE TABLE IF NOT EXISTS lukup_event_activity_type (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  activity_name VARCHAR(30) NOT NULL
  );
CREATE TABLE IF NOT EXISTS event_activity_type (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_event INTEGER,
  id_lukup_event_act_type INTEGER,
  FOREIGN KEY (id_event) REFERENCES "event"(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_lukup_event_act_type) REFERENCES event_activity_type(id) ON UPDATE CASCADE ON DELETE CASCADE
  );

CREATE TABLE IF NOT EXISTS user_event_category_like (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_event INTEGER,
  id_user INTEGER,
  FOREIGN KEY (id_event) REFERENCES "event"(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE IF NOT EXISTS venue (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_event INTEGER,
    venue_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    id_city INTEGER,
    id_state INTEGER,
    capacity INTEGER,
    venue_type VARCHAR(50),
    geom_location GEOMETRY(POINT,4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
);
CREATE INDEX idx_geom_location ON venue USING GIST (geom_location);

CREATE TABLE IF NOT EXISTS event_follower (
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 id_event INTEGER NOT NULL,
 id_user INTEGER NOT NULL,
 start_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
 end_date TIMESTAMPTZ,
 FOREIGN KEY (id_event) REFERENCES "event"(id) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS prime_service (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(30),
  id_service_type INTEGER,
  description TEXT,
  stype VARCHAR(30) NOT NULL,
  benefits TEXT,
  price DECIMAL(10,2) NOT NULL CHECK (price >= 0.00),
  start_date TIMESTAMP,
  FOREIGN KEY (id_service_type) REFERENCES lukup_service_type(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS prime_service_user (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_user INT NOT NULL,
  id_prime_service INT NOT NULL,
  registered_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE ,
  FOREIGN KEY (id_prime_service) REFERENCES prime_service(id) ON UPDATE CASCADE 
);

CREATE TABLE IF NOT EXISTS latest_deal (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_user INTEGER,
    latest_deals_code VARCHAR(15) UNIQUE NOT NULL,
    id_inventory INTEGER, 
    description VARCHAR(255) NOT NULL,
    startdate TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ NOT NULL,
    dealprice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS media_store (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_store INTEGER,
  id_media_url INTEGER,
  FOREIGN KEY (id_store) REFERENCES store(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_media_url) REFERENCES media_url(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS seller (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_user INTEGER, 
  bmsname VARCHAR(30) UNIQUE NOT NULL,
  count INTEGER,
  rating DECIMAL(3,1) NOT NULL,
  is_certified BOOLEAN DEFAULT 'f',
  is_active BOOLEAN DEFAULT '1',

  upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  update_date TIMESTAMP,
  FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE 
);
CREATE INDEX idx_seller_bmsname ON seller(bmsname);

CREATE TABLE IF NOT EXISTS favorite_store (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_store INTEGER, 
  id_user INTEGER,
  upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  update_date TIMESTAMP,
  FOREIGN KEY (id_store) REFERENCES store(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_user) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE
);


/* lukup number - 3.32 
CREATE TABLE IF NOT EXISTS lukup_dietary_tag (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS cuisine_type (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    ctname VARCHAR(255) NOT NULL
);
 
CREATE TABLE restaurant_cafe 
(
   id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   id_store INTEGER,
   id_cuisine_type INTEGER,
   seating_capacity INTEGER,
   michelin_stars SMALLINT,  
   ambiance SMALLINT,/*('casual','fine_dining','formal','lively','romantic','family_friendly','trendy','rustic','industrial','sports_bar','quiet') */                              
  FOREIGN KEY (id_cuisine_type) REFERENCES cuisine_type(id) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (id_store) REFERENCES store(id) ON DELETE CASCADE ON UPDATE CASCADE
); 

/* lukup number - 3.33 */
CREATE TABLE IF NOT EXISTS lukup_topping (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  calories DECIMAL(4,1),
  image_url VARCHAR(255),
  notes VARCHAR(100)
);
/* lukup number - 3.34 */
CREATE TABLE IF NOT EXISTS lukup_sauce (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  calories DECIMAL(4,1),
  image_url VARCHAR(255),
  notes VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS sauce_price (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_restaurant INTEGER,
  id_sauce INTEGER,
  price DECIMAL(4,1) NOT NULL,
  FOREIGN KEY (id_restaurant) REFERENCES restaurant_cafe(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_sauce) REFERENCES lukup_sauce(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS topping_price (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_restaurant INTEGER,
  id_topping INTEGER,
  price DECIMAL(4,1) NOT NULL,
  FOREIGN KEY (id_restaurant) REFERENCES restaurant_cafe(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_topping) REFERENCES lukup_topping(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS lukup_restauranct_cafe_category (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_parent_category INTEGER,
  type SMALLINT, /* drink, meal */
  image_url VARCHAR(255),
  visited INTEGER,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  FOREIGN KEY (id_parent_category) REFERENCES lukup_restauranct_cafe_category(id)
);

CREATE TABLE IF NOT EXISTS dish_drink_and_extra (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_restaurant INTEGER,
  id_category INTEGER,
  id_product INTEGER,
  price DECIMAL(4,1) NOT NULL,
  FOREIGN KEY (id_restaurant) REFERENCES restaurant_cafe(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_product) REFERENCES product(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_category) REFERENCES lukup_restauranct_cafe_category(id)
);

CREATE TABLE IF NOT EXISTS dish_meal (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_restaurant INTEGER,
    id_category INTEGER,
    name VARCHAR(255) NOT NULL,
    dish_type SMALLINT ,/* burgers, pizzas, */
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    calorie DECIMAL(5,2) NOT NULL,
    ingredient TEXT,
    allergen TEXT,
    nutrition_fact TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    FOREIGN KEY (id_category) REFERENCES lukup_restauranct_cafe_category(id),
    FOREIGN KEY (id_restaurant) REFERENCES restaurant_cafe(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS dish_rating (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_dish INTEGER,
    rate_count INTEGER,
    rating DECIMAL (2,1),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_dish) REFERENCES dish_meal(id) ON DELETE SET NULL ON UPDATE CASCADE
);
*/
CREATE TABLE IF NOT EXISTS offer (
      id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
      id_user INTEGER,
      id_seller INTEGER,
      id_product INTEGER,
      offer_price DECIMAL(10, 2) NOT NULL CHECK (offer_price >= 0.00),
      discount_percentage DECIMAL(5, 2) CHECK (discount_percentage >= 0.00),
      start_date TIMESTAMPTZ NOT NULL,
      end_date TIMESTAMPTZ NOT NULL,
      quantity_available INT NOT NULL,
      is_active BOOLEAN DEFAULT 't',
      is_recursive BOOLEAN DEFAULT 'f',
      created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMPTZ ,
      -- Foreign keys
      FOREIGN KEY (id_product) REFERENCES inventory(id) ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY (seller_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shipping_address (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer_id INTEGER , 
  address_line1 VARCHAR(255),
  address_line2 VARCHAR(255),
  id_city INTEGER, 
  id_state INTEGER , 
  postal_code VARCHAR(255),
  FOREIGN KEY (customer_id) REFERENCES "user"(id) ON UPDATE CASCADE  ON DELETE CASCADE,
  FOREIGN KEY (id_city) REFERENCES city(id) ON UPDATE CASCADE  ON DELETE NO ACTION,
  FOREIGN KEY (id_state) REFERENCES states(id) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS sales_header (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_customer INTEGER,
  id_ship_to_address INTEGER,
  id_sale_user INTEGER ,
  sales_order_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
  revision_number INTEGER DEFAULT 1 CHECK(revision_number >= 1),
  status SMALLINT,/*Pending,Processing,Confirmed,In Transit,Out for Delivery,Delivered,Cancelled,On Hold,Returned*/
  online_order_flag BOOLEAN DEFAULT '1',
  ship_method_id INT NOT NULL , 
  subtotal DECIMAL(12,2) NOT NULL,
  taxamt DECIMAL(12,2) NOT NULL,
  freight DECIMAL(12,2) NOT NULL,
  total_due DECIMAL(12,2) NOT NULL,
  order_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  due_date TIMESTAMPTZ NOT NULL,
  shipdate TIMESTAMPTZ NOT NULL,
  FOREIGN KEY (id_ship_to_address) REFERENCES shipping_address(id) ON UPDATE CASCADE,
  FOREIGN KEY (id_customer) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_sale_user) REFERENCES "user"(id) ON UPDATE CASCADE
);
CREATE INDEX idx_sales_header_uuid ON sales_header(sales_order_uuid);

CREATE TABLE IF NOT EXISTS delivery_person_review (  
   id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   id_delivery_person INTEGER,
   id_parent_comment INTEGER,
   id_commenter INTEGER,
   review VARCHAR(255) NOT NULL,
   rate_count INTEGER CHECK (rate_count > 0),
   rating DECIMAL(2,1) NOT NULL,
   upload_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
   update_date TIMESTAMPTZ,
   CONSTRAINT parent_comment_userid_check CHECK (id_parent_comment <> id),
   FOREIGN KEY (id_delivery_person) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE NO ACTION,
   FOREIGN KEY (id_parent_comment) REFERENCES delivery_person_review(id) ON UPDATE CASCADE ON DELETE NO ACTION,
   FOREIGN KEY (id_commenter) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS store_review (
   id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   id_store INTEGER,
   id_parent_comment INTEGER,
   id_commenter INTEGER,
   review VARCHAR(255) NOT NULL,
   rate_count INTEGER CHECK (rate_count > 0),
   rating DECIMAL(2,1) NOT NULL,
   upload_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
   update_date TIMESTAMPTZ,
   CONSTRAINT parent_comment_userid_check CHECK (id_parent_comment <> id),
   FOREIGN KEY (id_store) REFERENCES store(id) ON UPDATE CASCADE ON DELETE NO ACTION,
   FOREIGN KEY (id_parent_comment) REFERENCES store_review(id) ON UPDATE CASCADE ON DELETE NO ACTION,
   FOREIGN KEY (id_commenter) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS table_list (
   id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name VARCHAR(30) NOT NULL,  /* Event, Menu Item, Store, Restaurant, Product ... (tables) */
   created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

/* may 14 */ 
 CREATE TABLE IF NOT EXISTS audit_action (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    action_name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS audit_log (
        id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        table_name VARCHAR(40) NOT NULL,  -- Name of the table being audited
        id_action INTEGER,
        id_user INTEGER,
        id_row INTEGER,     -- ID of the row in the original table
        operation SMALLINT NOT NULL/*('INSERT', 'UPDATE', 'DELETE')*/,
        old_values JSONB,
        created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        FOREIGN KEY (id_action) REFERENCES audit_action(id) ON DELETE SET NULL ON UPDATE CASCADE,
        FOREIGN KEY (id_user) REFERENCES user(id) ON DELETE NO ACTION
    );

CREATE TABLE IF NOT EXISTS "session" (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_event INTEGER,
    capacity INTEGER CHECK (capacity > 0),
    session_description TEXT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ NOT NULL,
    location GEOMETRY(POINT,4326),
    location_description TEXT,
    FOREIGN KEY (id_event) REFERENCES event(id) ON DELETE CASCADE ON UPDATE CASCADE
);

create table IF NOT EXISTS ticket_promo_code (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  ticket_promo_code_num VARCHAR(13) UNIQUE,
  id_ticket INTEGER,
  discount_percent INTEGER CHECK ( discount_percent > 0 ),
  FOREIGN KEY(id_ticket) REFERENCES ticket(id) ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE IF NOT EXISTS ticket_type (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_event INTEGER,
    barcode_image BYTEA UNIQUE,
    name SMALLINT , -- 'Early Bird','Regular','VIP','Student','Group'
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    capacity INT NOT NULL,
    privileges TEXT,
    FOREIGN KEY (id_event) REFERENCES event(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS author (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    website_url TEXT,
    biography TEXT,
    social_media_links TEXT,
    genre_specification VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS book_inventory (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_store INTEGER,
    id_author INTEGER,
    title VARCHAR(255) NOT NULL,
    website TEXT,
    description TEXT,
    category INTEGER,
    published_date TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    rating DECIMAL(3,1) DEFAULT 0.00,
    rater_count INTEGER CHECK (rate_count > 0),
    synopsis TEXT NOT NULL,
    FOREIGN KEY (id_store) REFERENCES store(id) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (id_author) REFERENCES author(id) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS book_detail (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_book_inventory INTEGER,
  book_format SMALLINT NOT NULL DEFAULT 1, -- hardcover, paperback, eBook
  price DECIMAL(10,2) NOT NULL CHECK (price > 0),
  quantity INTEGER CHECK (quantity > 0),
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_book_inventory) REFERENCES book_inventory(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS book_media (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_book_inventory INTEGER,
  media_content_url TEXT,
  media_type enum_mode_type,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_book_inventory) REFERENCES book_inventory(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS book_review (
   id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   id_book INTEGER,
   id_parent_comment INTEGER,
   id_commenter INTEGER,
   review VARCHAR(255) NOT NULL,
   rate_count INTEGER CHECK (rate_count > 0),
   rating DECIMAL(2,1) NOT NULL,
   upload_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
   update_date TIMESTAMPTZ,
   CONSTRAINT parent_comment_userid_check CHECK (id_parent_comment <> id),
   FOREIGN KEY (id_book) REFERENCES book_inventory(id) ON UPDATE CASCADE ON DELETE NO ACTION,
   FOREIGN KEY (id_parent_comment) REFERENCES book_review(id) ON UPDATE CASCADE ON DELETE NO ACTION,
   FOREIGN KEY (id_commenter) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE NO ACTION
);

create table IF NOT EXISTS book_promo_code (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  book_promo_code_num VARCHAR(13) UNIQUE,
  id_book_inventory INTEGER,
  discount_percent INTEGER CHECK ( discount_percent > 0 ),
  FOREIGN KEY(id_book_inventory) REFERENCES book_inventory(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS bought_ticket (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_user INTEGER,
    id_ticket INTEGER,
    total_ticket INTEGER CHECK (total_ticket > 0),
    created TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    on_update TIMESTAMPTZ,
    FOREIGN KEY (id_ticket) REFERENCES ticket_type(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS registered_user_for_event (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_event INTEGER,
    registered_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_event) REFERENCES event(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ticket_transfer (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_event INTEGER,
    barcode_image BYTEA UNIQUE,
    name SMALLINT , -- 'Early Bird','Regular','VIP','Student','Group'
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    capacity INT NOT NULL,  
    privileges TEXT,
    approved BOOLEAN DEFAULT 'f',
    FOREIGN KEY (id_event) REFERENCES "event"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS bundle_deal (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_store INTEGER,
  start_time TIMESTAMPTZ NOT NULL,
  end_time TIMESTAMPTZ NOT NULL,
  is_recurring BOOLEAN DEFAULT 'f' NOT NULL,
  media_url TEXT,
  date_added TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  update_date TIMESTAMPTZ,
  price DECIMAL(14,2),
  FOREIGN KEY (id_store) REFERENCES store(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS bundle_deal_item (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_bundle_deal INTEGER,
  id_product INTEGER,
  quantity INTEGER,
  date_added TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT check_qunatity_magnitude CHECK (quantity > 0),
  FOREIGN KEY (id_bundle_deal) REFERENCES bundle_deal(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_product) REFERENCES inventory(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS wishlist (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_user INTEGER,
  name VARCHAR(255) NOT NULL,
  date_added TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS wishlist_item (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_wishlist INTEGER,
  id_product INTEGER,
  date_added TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_wishlist) REFERENCES wishlist(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_product) REFERENCES inventory(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS wishlist_notification (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_wishlist_item INTEGER,
  notification_type SMALLINT NOT NULL, -- price_drop,Stock_available,New_offer,Price_increase,Review_available,Similar_product_recommendation
  date_added TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_wishlist_item) REFERENCES wishlist_item(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS gift (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_order INTEGER,  -- Foreign key referencing the order
  id_recipient INTEGER,
  recipient_name VARCHAR(255) NOT NULL,
  recipient_address JSONB NOT NULL,  -- Can include street, city, zip etc.
  gift_message TEXT,
  instructions TEXT,  -- Special delivery instructions
  date_added TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  is_delivered BOOLEAN DEFAULT 'f',
  FOREIGN KEY (id_order) REFERENCES "order"(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_recipient) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS lukup_refund_reason (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  reason VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS lukup_refund_type (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  refund_type SMALLINT NOT NULL -- get similar items, refund to byteme_wallet
);

CREATE TABLE IF NOT EXISTS product_refund_request (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_order INTEGER,  -- Foreign key referencing the order
  id_refund_checker INTEGER,
  id_refund_reason INTEGER,
  id_refund_type INTEGER,
  refund_receipt_picture_url TEXT,
  additional_comments TEXT,  
  is_approved BOOLEAN NOT NULL DEFAULT 'f',
  date_requested TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  data_updated TIMESTAMPTZ ,
  is_delivered BOOLEAN DEFAULT 'f',
  FOREIGN KEY (id_order) REFERENCES "order"(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_refund_reason) REFERENCES lukup_refund_reason(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_refund_type) REFERENCES lukup_refund_type(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_refund_checker) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS subscription (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_user INTEGER,
    subscription_name VARCHAR(255) NOT NULL,
    subscription_description TEXT,
    start_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    end_date TIMESTAMPTZ,
    status SMALLINT DEFAULT '1', -- Status can be 'Active', 'Paused', 'Cancelled', etc.
    price NUMERIC(10, 2) NOT NULL,
    renewal_period INTERVAL NOT NULL, -- Interval for renewal (e.g., '1 month', '1 year')
    trial_period INTERVAL, -- Interval for trial period (optional)
    payment_method VARCHAR(50) NOT NULL,
    billing_address TEXT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS chat_room_member (
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 id_chat_room INTEGER,
 id_member INTEGER,
 is_active BOOLEAN DEFAULT 't',
 date_added TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (id_chat_room) REFERENCES chat_room(id) ON UPDATE CASCADE ON DELETE SET NULL,
 FOREIGN KEY (id_member) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS group_order (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_organizer INTEGER,
    group_order_uuid UUID DEFAULT gen_random_uuid(),
    description TEXT NOT NULL,
    order_status BOOLEAN DEFAULT 't', -- true for open 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_organizer) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS  grouporder_order (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_order INTEGER,
    id_group_order INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS group_order_delivery_address (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  id_group_order INTEGER,
  addressline JSONB NOT NULL,
  phone JSONB NOT NULL,
  email JSONB NOT NULL,
  geom_location GEOMETRY(Point, 4326),
  FOREIGN KEY (id_group_order) REFERENCES "group_order"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS browsing_history (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_user INTEGER,
    id_product INTEGER,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_size_pref (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_user INTEGER,
    product_type SMALLINT NOT NULL, -- shoe,cloth,
    size_value DECIMAL(3,1) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS saved_seller (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_user INTEGER,
    id_store INTEGER, 
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_store) REFERENCES store(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS saved_seller (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_user INTEGER,
    id_store INTEGER, 
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_store) REFERENCES store(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS saved_search (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_user INTEGER,
    search_word TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS saved_search_filter_preference (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_user INTEGER,
    search_word JSONB NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX idx_geom_location_goda ON group_order_delivery_address USING GIST (geom_location);






