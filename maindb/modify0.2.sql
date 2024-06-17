CREATE TABLE permission_entity (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    --id_user INTEGER,
    id_table_list INTEGER,
    operation SMALLINT, /* add,change,delete,view */
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    -FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_table_list) REFERENCES table_list(id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE groups_auth (
      id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
      --id_user INTEGER,
      name VARCHAR(255),
      created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE groups_auth_permission (
      id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
      id_permission_entity INTEGER,
      id_groups_auth INTEGER,
      name VARCHAR(255),
      created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (id_permission_entity) REFERENCES "permission_entity"(id) ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY (id_groups_auth) REFERENCES "groups_auth"(id) ON DELETE CASCADE ON UPDATE CASCADE
);


  -- delete group role           *done
  -- delete lukup_permission     *done
  -- add user_id to store        *done
  -- change store_choice to store_type in store table  *done
  -- floor to INTEGER in store_location  *done
  -- city to distrcit in store_location  *done
  -- get rid of postal code in store_location  *done
  -- add opening and closing hour in store_location *done
  -- drop group_role table *done
  -- add user_roles table *done
  -- create a table for delivery_constant in km 
change name of user_permission_entity 
-- add is_approved to the inventory table
-- Create inventory detail table 
-- chat room for the store
-- see a little about habesha tender


description   qty   PRICE     amount 
inventory_id

subtotal (derived_column)

tax
total 
cash 
item

CREATE TABLE IF NOT EXISTS inventory_specification (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_inventory INTEGER NOT NULL,
    id_category INTEGER NOT NULL,
    key_values JSONB NOT NULL,
    FOREIGN KEY (id_category) REFERENCES lukup_category(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS lukup_specification (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    field_values TEXT[] NOT NULL
);

CREATE TABLE IF NOT EXISTS lukup_specification_category (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_lukup_specification INTEGER NOT NULL,
    id_applicable_category INTEGER NOT NULL,
    FOREIGN KEY (id_lukup_specification) REFERENCES lukup_specification(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_applicable_category) REFERENCES lukup_category(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS inventory_specification (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_inventory INTEGER NOT NULL,
    id_category INTEGER NOT NULL,
    key_values JSONB NOT NULL,
    FOREIGN KEY (id_category) REFERENCES lukup_category(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_inventory) REFERENCES inventory(id) ON DELETE CASCADE ON UPDATE CASCADE
);

