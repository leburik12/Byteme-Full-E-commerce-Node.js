CREATE TABLE IF NOT EXISTS product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    ptype VARCHAR(50) NOT NULL CHECK (ptype IN ('food', 'drink', 'event', 'meal')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS product (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY ,
    name VARCHAR(255) NOT NULL UNIQUE,
    ptype SMALLINT, /* food, drink,event,meal */ 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS country (
    id VARCHAR(5) PRIMARY KEY NOT NULL,
    country_name VARCHAR(30) NOT NULL UNIQUE,
    country_image_url VARCHAR(255),
    country_phone_code VARCHAR(5)
);
ALTER TABLE event ALTER COLUMN event_code SET NOT NULL;
ALTER TABLE event ADD COLUMN event_code uuid DEFAULT gen_random_uuid();


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
ALTER TABLE event ADD COLUMN is_multiple_session BOOLEAN DEFAULT 'f'; 

CREATE TABLE IF NOT EXISTS ticket (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    --ticket_uuid UUID DEFAULT gen_random_uuid(),
    id_event INTEGER,
    ticket_name VARCHAR(255) NOT NULL,
    description TEXT,
    --price DECIMAL(10, 2) NOT NULL,
    --quantity_available INTEGER,
    sale_start_date TIMESTAMP NOT NULL,
    sale_end_date TIMESTAMP NOT NULL,
    is_active BOOLEAN DEFAULT true,
    store_choices SMALLINT, /*('Free Tickets','Donation Tickets','Passes','Virtual Pass','mini-market','restaurants','bar') */
    -- Additional entities
    max_tickets_per_order INTEGER,
    min_tickets_per_order INTEGER DEFAULT 1,
    is_free BOOLEAN DEFAULT 'f',
    currency VARCHAR(3) DEFAULT 'USD',
    --ticket_promotion_amount DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    -- Foreign keys
    CONSTRAINT tickets_valid CHECK (sale_start_date <= sale_end_date),
    FOREIGN KEY (id_event) REFERENCES "event"(id) ON DELETE CASCADE
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

CREATE TABLE IF NOT EXISTS ticket_transfer (
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

CREATE TABLE IF NOT EXISTS registered_user_for_event (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_event INTEGER,
    registered_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_event) REFERENCES event(id) ON DELETE CASCADE ON UPDATE CASCADE
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
  date_added TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
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
    
    renewal_period INTERVAL NOT NULL, -- Interval for renewal (e.g., '1 month', '1 year')
    trial_period INTERVAL, -- Interval for trial period (optional)
    payment_method VARCHAR(50) NOT NULL,
    billing_address TEXT NOT NULL,
    CONSTRAINT subscription_date_valid CHECK (start_date <= end_date),
    FOREIGN KEY (id_user) REFERENCES "user"(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS subscription_duration (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_subscription INTEGER,
    price NUMERIC(10, 2) NOT NULL,
    description TEXT,
    FOREIGN KEY (id_subscription) REFERENCES subscription(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS registered_subscribers (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_subscription INTEGER,
  id_subscriber INTEGER,
  registration_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_subscription) REFERENCES subscription(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_subscriber  ) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE
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
CREATE INDEX idx_geom_location_goda ON group_order_delivery_address USING GIST (geom_location);

CREATE TABLE IF NOT EXISTS notification_type (
    id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS notification (
    id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    notification_type VARCHAR(50) NOT NULL,  -- e.g. 'invitation', 'eminder', 'update'
    notification_message TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS lukup_permission (
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
    FOREIGN KEY (id_permission) REFERENCES lukup_permission(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_role) REFERENCES roles(id) ON DELETE CASCADE ON UPDATE CASCADE
);


Seller selects the option to delete the product listing, typically indicated by a "Delete" button or similar action.
ALTER TABLE "event" ADD COLUMN is_recurring BOOLEAN ;
ALTER TABLE "event" ALTER COLUMN is_reccuring SET DEFAULT NULL:
drop table subscription_fee;

/*
DO $$
DECLARE
    table_record RECORD;
BEGIN
    FOR table_record IN 
        SELECT table_schema, table_name 
        FROM information_schema.tables 
        WHERE table_schema NOT IN ('information_schema', 'pg_catalog')  -- Exclude system schemas
    LOOP
        EXECUTE 'GRANT ALL PRIVILEGES ON TABLE ' || quote_ident(table_record.table_schema) || '.' || quote_ident(table_record.table_name) || ' TO your_username';
    END LOOP;
END $$;

*/