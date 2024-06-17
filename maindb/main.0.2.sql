--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: enum_ambiance; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_ambiance AS ENUM (
    'casual',
    'fine_dining',
    'formal',
    'lively',
    'romantic',
    'family_friendly',
    'trendy',
    'rustic',
    'industrial',
    'sports_bar',
    'quiet'
);


ALTER TYPE public.enum_ambiance OWNER TO postgres;

--
-- Name: enum_completion_reason; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_completion_reason AS ENUM (
    'bid_accepted',
    'bid_withdrawn',
    'reserve_not_met',
    'item_withdrawn',
    'expired',
    ''
);


ALTER TYPE public.enum_completion_reason OWNER TO postgres;

--
-- Name: enum_control_mechanism; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_control_mechanism AS ENUM (
    'Direct Ownership',
    'Contractual Arrangements',
    'Legal Structures',
    'Personal Influence'
);


ALTER TYPE public.enum_control_mechanism OWNER TO postgres;

--
-- Name: enum_discount_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_discount_type AS ENUM (
    'percentage',
    'flat_rate'
);


ALTER TYPE public.enum_discount_type OWNER TO postgres;

--
-- Name: enum_id_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_id_type AS ENUM (
    'passport',
    'international_id',
    'driving licence'
);


ALTER TYPE public.enum_id_type OWNER TO postgres;

--
-- Name: enum_michelin_stars; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_michelin_stars AS ENUM (
    'none',
    'one',
    'two',
    'three'
);


ALTER TYPE public.enum_michelin_stars OWNER TO postgres;

--
-- Name: enum_mode_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_mode_type AS ENUM (
    'products',
    'user',
    'inventory',
    'chat',
    'advertise'
);


ALTER TYPE public.enum_mode_type OWNER TO postgres;

--
-- Name: enum_order_creation_channel; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_order_creation_channel AS ENUM (
    'website',
    'mobile app',
    'third-party'
);


ALTER TYPE public.enum_order_creation_channel OWNER TO postgres;

--
-- Name: enum_order_priority; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_order_priority AS ENUM (
    'regular',
    'high',
    'rush'
);


ALTER TYPE public.enum_order_priority OWNER TO postgres;

--
-- Name: enum_shipping_method; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_shipping_method AS ENUM (
    'standard',
    'expedited',
    'express'
);


ALTER TYPE public.enum_shipping_method OWNER TO postgres;

--
-- Name: enum_subscription_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_subscription_status AS ENUM (
    'active',
    'inactive'
);


ALTER TYPE public.enum_subscription_status OWNER TO postgres;

--
-- Name: enum_subscription_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_subscription_type AS ENUM (
    'monthly',
    'yearly',
    'lifetime'
);


ALTER TYPE public.enum_subscription_type OWNER TO postgres;

--
-- Name: get_country_list(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_country_list() RETURNS character varying[]
    LANGUAGE plpgsql
    AS $$
DECLARE 
   country_list VARCHAR(255)[];
BEGIN
    country_list := ARRAY['Afghanistan|93|https://example.com/afghanistan.jpg','Albania|355|https://example.com/albania.jpg','Algeria|213|https://example.com/algeria.jpg','Andorra|376|https://example.com/andorra.jpg','Angola|244|https://example.com/angola.jpg','Antigua and Barbuda|1268|https://example.com/antigua-barbuda.jpg','Argentina|54|https://example.com/argentina.jpg','Armenia|374|https://example.com/armenia.jpg','Australia|61|https://example.com/australia.jpg','Austria|43|https://example.com/austria.jpg','Azerbaijan|994|https://example.com/azerbaijan.jpg','Bahamas|1242|https://example.com/bahamas.jpg','Bahrain|973|https://example.com/bahrain.jpg','Bangladesh|880|https://example.com/bangladesh.jpg','Barbados|1246|https://example.com/barbados.jpg','Belarus|375|https://example.com/belarus.jpg','Belgium|32|https://example.com/belgium.jpg','Belize|501|https://example.com/belize.jpg','Benin|229|https://example.com/benin.jpg','Bhutan|975|https://example.com/bhutan.jpg','Bolivia|591|https://example.com/bolivia.jpg','Bosnia and Herzegovina|387|https://example.com/bosnia-herzegovina.jpg','Botswana|267|https://example.com/botswana.jpg','Brazil|55|https://example.com/brazil.jpg','Brunei|673|https://example.com/brunei.jpg','Bulgaria|359|https://example.com/bulgaria.jpg','Burkina Faso|226|https://example.com/burkina-faso.jpg','Burundi|257|https://example.com/burundi.jpg','Cabo Verde|238|https://example.com/cabo-verde.jpg','Cambodia|855|https://example.com/cambodia.jpg','Cameroon|237|https://example.com/cameroon.jpg','Canada|1|https://example.com/canada.jpg','Central African Republic|236|https://example.com/central-african-republic.jpg','Chad|235|https://example.com/chad.jpg','Chile|56|https://example.com/chile.jpg','China|86|https://example.com/china.jpg','Colombia|57|https://example.com/colombia.jpg','Comoros|269|https://example.com/comoros.jpg','Congo (Congo-Brazzaville)|242|https://example.com/congo-brazzaville.jpg','Costa Rica|506|https://example.com/costa-rica.jpg','Côte d''Ivoire|225|https://example.com/cote-divoire.jpg','Croatia|385|https://example.com/croatia.jpg','Cuba|53|https://example.com/cuba.jpg','Cyprus|357|https://example.com/cyprus.jpg','Czechia|420|https://example.com/czechia.jpg','Democratic Republic of the Congo|243|https://example.com/democratic-republic-of-the-congo.jpg','Denmark|45|https://example.com/denmark.jpg','Djibouti|253|https://example.com/djibouti.jpg','Dominica|1767|https://example.com/dominica.jpg','Dominican Republic|1809|https://example.com/dominican-republic.jpg','Ecuador|593|https://example.com/ecuador.jpg','Egypt|20|https://example.com/egypt.jpg','El Salvador|503|https://example.com/el-salvador.jpg','Equatorial Guinea|240|https://example.com/equatorial-guinea.jpg','Eritrea|291|https://example.com/eritrea.jpg','Estonia|372|https://example.com/estonia.jpg','Eswatini|268|https://example.com/eswatini.jpg','Ethiopia|251|https://example.com/ethiopia.jpg','Fiji|679|https://example.com/fiji.jpg','Finland|358|https://example.com/finland.jpg','France|33|https://example.com/france.jpg','Gabon|241|https://example.com/gabon.jpg','Gambia|220|https://example.com/gambia.jpg','Georgia|995|https://example.com/georgia.jpg','Germany|49|https://example.com/germany.jpg','Ghana|233|https://example.com/ghana.jpg','Greece|30|https://example.com/greece.jpg','Grenada|1473|https://example.com/grenada.jpg','Guatemala|502|https://example.com/guatemala.jpg','Guinea|224|https://example.com/guinea.jpg','Guinea-Bissau|245|https://example.com/guinea-bissau.jpg','Guyana|592|https://example.com/guyana.jpg','Haiti|509|https://example.com/haiti.jpg','Honduras|504|https://example.com/honduras.jpg','Hungary|36|https://example.com/hungary.jpg','Iceland|354|https://example.com/iceland.jpg','India|91|https://example.com/india'];
    RETURN country_list;
END;
$$;


ALTER FUNCTION public.get_country_list() OWNER TO postgres;

--
-- Name: get_event_category_parent_list(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_event_category_parent_list() RETURNS character varying[]
    LANGUAGE plpgsql
    AS $$
DECLARE 
   event_parent_category_list VARCHAR(255)[];
BEGIN
   event_parent_category_list := ARRAY['Business','Food & Drink','Health Music','Charity & Causes Community','Family','Education','Fashion','Film & Media','Home & Lifestyle','Performing & Visual Arts','Government','School Activities','Science & Tech','Holidays','Sports & Fitness','Travel & Outdoor'];   
    RETURN event_parent_category_list;
END;
$$;


ALTER FUNCTION public.get_event_category_parent_list() OWNER TO postgres;

--
-- Name: proc_category_event_parent(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.proc_category_event_parent()
    LANGUAGE plpgsql
    AS $$
DECLARE 
   event_parent_categ VARCHAR(255)[] := get_event_category_parent_list();
   category_name VARCHAR(255);

BEGIN
  FOR i in 1..array_length(event_parent_categ,1) LOOP
     SELECT event_parent_categ[i] INTO category_name;
     EXECUTE format('INSERT INTO lukup_event_category(name)
                     VALUES (%L)',category_name);
  END LOOP;
END;
$$;


ALTER PROCEDURE public.proc_category_event_parent() OWNER TO postgres;

--
-- Name: proc_insert_country_list(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.proc_insert_country_list()
    LANGUAGE plpgsql
    AS $$
DECLARE
  country_list VARCHAR(255)[] := get_country_list();
  country_name VARCHAR(50);
  country_image_url VARCHAR(150);
  country_phone_code VARCHAR(5);

  BEGIN

  FOR i in 1..array_length(country_list,1) LOOP
     SELECT 
        split_part(country_list[i],'|',1),
        split_part(country_list[i],'|',2),
        split_part(country_list[i],'|',3)
     INTO country_name,country_phone_code,country_image_url;

     EXECUTE format('
      INSERT INTO country(id,country_name,country_phone_code,country_image_url) 
      VALUES (%s,%L,%L,%L)',i,country_name,country_phone_code,country_image_url);

  END LOOP;
END;
$$;


ALTER PROCEDURE public.proc_insert_country_list() OWNER TO postgres;

--
-- Name: proc_insert_product(character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.proc_insert_product(IN product_name character varying, IN product_type character varying)
    LANGUAGE plpgsql
    AS $_$
   DECLARE
      sanitized_product_name VARCHAR(30);
      existing_product_count INTEGER;

BEGIN 
   IF product_type NOT IN ('food', 'drink', 'event', 'meal','product') THEN 
     RAISE EXCEPTION 'Invalid product type. Please provide one of the following options: food, drink, event, meal';
    END IF;

   --SELECT regexp_replace(product_name,E'^[a-zA-Z0-9\s\-\.\_]{1,255}$','','g') INTO sanitized_product_name;
   SELECT regexp_replace(product_name, E'^[a-zA-Z0-9\\s\\-\\._]{1,255}$', '', 'g') INTO sanitized_product_name;

    -- Check if product name already exists in the database
    SELECT COUNT(*) INTO existing_product_count FROM product WHERE name=sanitized_product_name;

IF existing_product_count = 0 THEN 
   INSERT INTO product(name,ptype) 
    VALUES (LOWER(sanitized_product_name),
       CASE
         WHEN product_type = 'food' THEN 1
         WHEN product_type = 'drink' THEN 2
         WHEN product_type = 'event' THEN 3
         WHEN product_type = 'meal'  THEN 4
         WHEN product_type = 'product' THEN 5
       END);
 ELSE 
   RAISE EXCEPTION 'Product with the same name already exists.';
 END IF;
END;
$_$;


ALTER PROCEDURE public.proc_insert_product(IN product_name character varying, IN product_type character varying) OWNER TO postgres;

--
-- Name: proc_insert_role(character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.proc_insert_role(IN role_name_param character varying)
    LANGUAGE plpgsql
    AS $$
  DECLARE 
       non_alpha_count INTEGER;
BEGIN 
   -- check for non alpha numeric characters
   SELECT COUNT(*) INTO non_alpha_count FROM regexp_matches(role_name_param,'[^a-zA-Z]','g');

   IF non_alpha_count > 0 THEN
        RAISE EXCEPTION 'Role name should contain only alphabetic characters.';
   END IF; 

   INSERT INTO roles(role_name) VALUES(role_name_param);

   RAISE NOTICE 'Role "%", added successfully.', role_name_param;

   COMMIT;
END;
$$;


ALTER PROCEDURE public.proc_insert_role(IN role_name_param character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: add_to_watchlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.add_to_watchlist (
    id integer NOT NULL,
    id_user integer,
    id_inventory integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.add_to_watchlist OWNER TO postgres;

--
-- Name: add_to_watchlist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.add_to_watchlist ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.add_to_watchlist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auction (
    id integer NOT NULL,
    id_inventory integer,
    id_user_winner integer,
    id_user_seller integer,
    title character varying(150) NOT NULL,
    description text NOT NULL,
    starting_price numeric(10,2) NOT NULL,
    reserve_price numeric(10,2),
    auction_start_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    auction_end_time timestamp with time zone NOT NULL,
    status character varying(10) DEFAULT 'pending'::character varying NOT NULL,
    is_completed_flg boolean DEFAULT true NOT NULL,
    completion_reason public.enum_completion_reason DEFAULT ''::public.enum_completion_reason,
    CONSTRAINT auction_date_valid CHECK ((auction_start_time <= auction_end_time)),
    CONSTRAINT auction_reserve_price_check CHECK ((reserve_price >= 0.00)),
    CONSTRAINT auction_starting_price_check CHECK ((starting_price >= 0.00))
);


ALTER TABLE public.auction OWNER TO postgres;

--
-- Name: auction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auction ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.auction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author (
    id integer NOT NULL,
    website_url text,
    biography text,
    social_media_links text,
    genre_specification character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.author OWNER TO postgres;

--
-- Name: author_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.author ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authtoken_token (
    id integer NOT NULL,
    authkey character varying(40) NOT NULL,
    refersh_token character varying(40) NOT NULL,
    id_user integer,
    remaining_requests integer DEFAULT 0 NOT NULL,
    created timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expires_at timestamp(6) with time zone NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO postgres;

--
-- Name: authtoken_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.authtoken_token ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.authtoken_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auto_bid; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auto_bid (
    id integer NOT NULL,
    id_user integer,
    id_auction integer,
    max_bid numeric(10,2) NOT NULL,
    increment_bid numeric(10,2) NOT NULL,
    CONSTRAINT auto_bid_increment_bid_check CHECK ((increment_bid >= 0.00)),
    CONSTRAINT auto_bid_max_bid_check CHECK ((max_bid >= 0.00))
);


ALTER TABLE public.auto_bid OWNER TO postgres;

--
-- Name: auto_bid_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auto_bid ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.auto_bid_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: bid; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bid (
    id integer NOT NULL,
    id_auction integer,
    id_user_bidder integer,
    bid_amount numeric(10,2) NOT NULL,
    bid_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT bid_bid_amount_check CHECK ((bid_amount >= 0.00))
);


ALTER TABLE public.bid OWNER TO postgres;

--
-- Name: bid_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.bid ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: billing_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.billing_addresses (
    id integer NOT NULL,
    id_customer integer,
    id_city integer,
    id_district integer,
    address character varying(255),
    phone_num character varying(15),
    is_default_billing_method boolean DEFAULT true,
    email character varying(255)
);


ALTER TABLE public.billing_addresses OWNER TO postgres;

--
-- Name: billing_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.billing_addresses ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.billing_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: book_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_detail (
    id integer NOT NULL,
    id_book_inventory integer,
    book_format smallint DEFAULT 1 NOT NULL,
    price numeric(10,2) NOT NULL,
    quantity integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT book_detail_price_check CHECK ((price > (0)::numeric)),
    CONSTRAINT book_detail_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.book_detail OWNER TO postgres;

--
-- Name: book_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.book_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.book_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: book_inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_inventory (
    id integer NOT NULL,
    id_store integer,
    id_author integer,
    title character varying(255) NOT NULL,
    website text,
    description text,
    category integer,
    published_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    rating numeric(3,1) DEFAULT 0.00,
    rater_count integer,
    synopsis text NOT NULL,
    CONSTRAINT is_rate_count_positive CHECK ((rater_count > 0))
);


ALTER TABLE public.book_inventory OWNER TO postgres;

--
-- Name: book_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.book_inventory ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.book_inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: book_media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_media (
    id integer NOT NULL,
    id_book_inventory integer,
    media_content_url text,
    media_type public.enum_mode_type,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.book_media OWNER TO postgres;

--
-- Name: book_media_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.book_media ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.book_media_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: book_promo_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_promo_code (
    id integer NOT NULL,
    book_promo_code_num character varying(13),
    id_book_inventory integer,
    discount_percent integer,
    CONSTRAINT book_promo_code_discount_percent_check CHECK ((discount_percent > 0))
);


ALTER TABLE public.book_promo_code OWNER TO postgres;

--
-- Name: book_promo_code_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.book_promo_code ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.book_promo_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: book_review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_review (
    id integer NOT NULL,
    id_book integer,
    id_parent_comment integer,
    id_commenter integer,
    review character varying(255) NOT NULL,
    rate_count integer,
    rating numeric(2,1) NOT NULL,
    upload_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone,
    CONSTRAINT book_review_rate_count_check CHECK ((rate_count > 0)),
    CONSTRAINT parent_comment_userid_check CHECK ((id_parent_comment <> id))
);


ALTER TABLE public.book_review OWNER TO postgres;

--
-- Name: book_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.book_review ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.book_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brand (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    category_id integer,
    verified boolean DEFAULT false,
    description character varying(255),
    logo_url character varying(255),
    website_url character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone
);


ALTER TABLE public.brand OWNER TO postgres;

--
-- Name: brand_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.brand ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.brand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buy_now_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buy_now_price (
    id integer NOT NULL,
    buy_now_price numeric(10,2) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    CONSTRAINT buy_now_price_buy_now_price_check CHECK ((buy_now_price >= 0.00))
);


ALTER TABLE public.buy_now_price OWNER TO postgres;

--
-- Name: buy_now_price_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.buy_now_price ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.buy_now_price_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: caching_expiry_setting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caching_expiry_setting (
    id integer NOT NULL,
    id_caching_settings integer,
    id_caching_type integer,
    expiry_duration integer
);


ALTER TABLE public.caching_expiry_setting OWNER TO postgres;

--
-- Name: caching_expiry_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.caching_expiry_setting ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.caching_expiry_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: caching_feature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caching_feature (
    id integer NOT NULL,
    caching_feature_name character varying(255) NOT NULL
);


ALTER TABLE public.caching_feature OWNER TO postgres;

--
-- Name: caching_feature_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.caching_feature ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.caching_feature_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: caching_setting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caching_setting (
    id integer NOT NULL,
    id_user integer,
    setting_description text,
    setting_date timestamp with time zone,
    setting_is_default boolean,
    setting_is_custom boolean,
    setting_is_global boolean,
    setting_is_local boolean
);


ALTER TABLE public.caching_setting OWNER TO postgres;

--
-- Name: caching_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.caching_setting ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.caching_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: caching_settings_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caching_settings_detail (
    id integer NOT NULL,
    id_caching_setting integer,
    id_caching_type integer,
    id_caching_feature integer,
    is_enabled boolean
);


ALTER TABLE public.caching_settings_detail OWNER TO postgres;

--
-- Name: caching_settings_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.caching_settings_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.caching_settings_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: caching_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caching_type (
    id integer NOT NULL,
    caching_type_name character varying(255) NOT NULL
);


ALTER TABLE public.caching_type OWNER TO postgres;

--
-- Name: caching_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.caching_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.caching_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: capacity_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.capacity_spec (
    id integer NOT NULL,
    capacity numeric(10,2) NOT NULL,
    CONSTRAINT capacity_spec_capacity_check CHECK ((capacity >= 0.00))
);


ALTER TABLE public.capacity_spec OWNER TO postgres;

--
-- Name: capacity_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.capacity_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.capacity_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: capacity_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.capacity_spec_product (
    id integer NOT NULL,
    id_capacity integer,
    id_inventory integer
);


ALTER TABLE public.capacity_spec_product OWNER TO postgres;

--
-- Name: capacity_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.capacity_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.capacity_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    id integer NOT NULL,
    id_customer integer,
    added_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    checked_out boolean DEFAULT false
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cart ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: chat_media_store; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_media_store (
    id integer NOT NULL,
    id_sender integer,
    id_media_url integer,
    message text,
    is_media_deleted boolean NOT NULL,
    is_media_reported boolean,
    url_part text,
    media_like smallint
);


ALTER TABLE public.chat_media_store OWNER TO postgres;

--
-- Name: chat_media_store_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.chat_media_store ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.chat_media_store_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: chat_room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_room (
    id integer NOT NULL,
    id_creator integer,
    title character varying(100) NOT NULL,
    chat_type smallint DEFAULT 1,
    chat_is_muted boolean NOT NULL,
    chat_is_hidden boolean NOT NULL
);


ALTER TABLE public.chat_room OWNER TO postgres;

--
-- Name: chat_room_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.chat_room ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.chat_room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: chat_room_media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_room_media (
    id integer NOT NULL,
    id_chat_room integer,
    id_chat_media_store integer
);


ALTER TABLE public.chat_room_media OWNER TO postgres;

--
-- Name: chat_room_media_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.chat_room_media ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.chat_room_media_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: chat_single; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_single (
    id integer NOT NULL,
    id_receiver integer,
    id_chat_media_store integer
);


ALTER TABLE public.chat_single OWNER TO postgres;

--
-- Name: chat_single_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.chat_single ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.chat_single_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    id integer NOT NULL,
    city_name character varying(30) NOT NULL,
    id_country character varying(5),
    id_state integer,
    is_shipping_available boolean NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.city ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: clerks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clerks (
    id integer NOT NULL,
    id_role integer,
    id_inventory integer,
    id_user integer,
    id_storelocation integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone
);


ALTER TABLE public.clerks OWNER TO postgres;

--
-- Name: clerks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.clerks ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.clerks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: color_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.color_spec (
    id integer NOT NULL,
    color_name character varying(30) NOT NULL
);


ALTER TABLE public.color_spec OWNER TO postgres;

--
-- Name: color_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.color_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.color_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: common_specification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.common_specification (
    id integer NOT NULL,
    id_inventory integer,
    id_color integer,
    height numeric(4,2),
    weight numeric(7,2),
    width numeric(7,2)
);


ALTER TABLE public.common_specification OWNER TO postgres;

--
-- Name: common_specification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.common_specification ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.common_specification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: complaint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.complaint (
    id integer NOT NULL,
    id_customer integer,
    id_complaint_reason integer,
    complaint_text text,
    complaint_status smallint DEFAULT 1,
    complaint_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.complaint OWNER TO postgres;

--
-- Name: complaint_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.complaint ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.complaint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: components_included_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.components_included_spec (
    id integer NOT NULL,
    components_included_name character varying(30) NOT NULL
);


ALTER TABLE public.components_included_spec OWNER TO postgres;

--
-- Name: components_included_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.components_included_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.components_included_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: components_included_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.components_included_spec_product (
    id integer NOT NULL,
    id_components_included integer,
    id_inventory integer
);


ALTER TABLE public.components_included_spec_product OWNER TO postgres;

--
-- Name: components_included_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.components_included_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.components_included_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    id character varying(5) NOT NULL,
    country_name character varying(50) NOT NULL,
    country_image_url character varying(255),
    country_phone_code character varying(5)
);


ALTER TABLE public.country OWNER TO postgres;

--
-- Name: cuisine_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuisine_type (
    id integer NOT NULL,
    ctname character varying(255) NOT NULL
);


ALTER TABLE public.cuisine_type OWNER TO postgres;

--
-- Name: cuisine_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cuisine_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cuisine_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: customer_return_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_return_request (
    id integer NOT NULL,
    id_order integer,
    id_customer integer,
    id_inventory integer,
    id_return_reason integer,
    return_status smallint DEFAULT 1,
    return_date timestamp with time zone,
    return_method character varying(255) NOT NULL,
    return_tracking_number uuid DEFAULT gen_random_uuid(),
    refund_amount numeric(10,2),
    additional_notes text,
    request_timestamp timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT customer_return_request_refund_amount_check CHECK ((refund_amount >= 0.00))
);


ALTER TABLE public.customer_return_request OWNER TO postgres;

--
-- Name: customer_return_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.customer_return_request ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_return_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: customer_service_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_service_request (
    id integer NOT NULL,
    id_service_request integer,
    id_service_type integer,
    rating_count integer,
    feedback_rating numeric(3,1),
    feedback_comment text
);


ALTER TABLE public.customer_service_request OWNER TO postgres;

--
-- Name: customer_service_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.customer_service_request ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_service_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: delivery_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_option (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    is_avail_ecommerce boolean DEFAULT true NOT NULL,
    is_avail_food_delivery boolean DEFAULT true NOT NULL,
    cost numeric(10,2),
    estimated_delivery_time timestamp with time zone NOT NULL,
    CONSTRAINT delivery_option_cost_check CHECK ((cost >= 0.00))
);


ALTER TABLE public.delivery_option OWNER TO postgres;

--
-- Name: delivery_option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.delivery_option ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.delivery_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: delivery_person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_person (
    id integer NOT NULL,
    id_user integer,
    bmdeliverer character varying(12) NOT NULL,
    id_vehicle integer,
    is_available boolean DEFAULT true NOT NULL,
    total_rating numeric(2,1) DEFAULT 0.00,
    total_delivery integer DEFAULT 0,
    current_location point,
    last_delivery_time timestamp with time zone,
    is_verified boolean DEFAULT false NOT NULL,
    geom_location public.geometry(Point,4326),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone,
    CONSTRAINT delivery_person_total_rating_check CHECK ((total_rating >= 0.00))
);


ALTER TABLE public.delivery_person OWNER TO postgres;

--
-- Name: delivery_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.delivery_person ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.delivery_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: delivery_person_review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_person_review (
    id integer NOT NULL,
    id_delivery_person integer,
    id_parent_comment integer,
    id_commenter integer,
    review character varying(255) NOT NULL,
    rate_count integer,
    rating numeric(2,1) NOT NULL,
    upload_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone,
    CONSTRAINT delivery_person_review_rate_count_check CHECK ((rate_count > 0)),
    CONSTRAINT parent_comment_userid_check CHECK ((id_parent_comment <> id))
);


ALTER TABLE public.delivery_person_review OWNER TO postgres;

--
-- Name: delivery_person_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.delivery_person_review ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.delivery_person_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: delivery_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_status (
    id integer NOT NULL,
    dsname character varying(50) NOT NULL,
    status_desc text
);


ALTER TABLE public.delivery_status OWNER TO postgres;

--
-- Name: delivery_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.delivery_status ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.delivery_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: dish_drink_and_extra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dish_drink_and_extra (
    id integer NOT NULL,
    id_restaurant integer,
    id_category integer,
    id_product integer,
    price numeric(4,1) NOT NULL
);


ALTER TABLE public.dish_drink_and_extra OWNER TO postgres;

--
-- Name: dish_drink_and_extra_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.dish_drink_and_extra ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.dish_drink_and_extra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: dish_meal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dish_meal (
    id integer NOT NULL,
    id_restaurant integer,
    id_category integer,
    name character varying(255) NOT NULL,
    dish_type smallint,
    description text,
    price numeric(10,2) NOT NULL,
    calorie numeric(5,2) NOT NULL,
    ingredient text,
    allergen text,
    nutrition_fact text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone
);


ALTER TABLE public.dish_meal OWNER TO postgres;

--
-- Name: dish_meal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.dish_meal ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.dish_meal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: dish_rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dish_rating (
    id integer NOT NULL,
    id_dish integer,
    rate_count integer,
    rating numeric(2,1),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.dish_rating OWNER TO postgres;

--
-- Name: dish_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.dish_rating ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.dish_rating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: districts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.districts (
    id integer NOT NULL,
    district_name character varying(30) NOT NULL,
    id_city integer,
    is_shipping_available boolean NOT NULL,
    geom_location public.geometry(Point,4326)
);


ALTER TABLE public.districts OWNER TO postgres;

--
-- Name: districts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.districts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.districts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: driver_complaint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver_complaint (
    id integer NOT NULL,
    id_complaint integer NOT NULL,
    id_driver integer NOT NULL
);


ALTER TABLE public.driver_complaint OWNER TO postgres;

--
-- Name: driver_complaint_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.driver_complaint ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.driver_complaint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event (
    id integer NOT NULL,
    id_organizer integer,
    id_event_category integer,
    event_name character varying(255) NOT NULL,
    event_description text,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone NOT NULL,
    capacity integer,
    dress_code character varying(255),
    age_restriction integer,
    duration integer,
    estatus smallint,
    geom_location public.geometry(Point,4326),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    event_code uuid DEFAULT gen_random_uuid() NOT NULL,
    is_multiple_session boolean DEFAULT false,
    CONSTRAINT event_date_valid CHECK ((start_date <= end_date))
);


ALTER TABLE public.event OWNER TO postgres;

--
-- Name: event_activity_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_activity_type (
    id integer NOT NULL,
    id_event integer,
    id_lukup_event_act_type integer
);


ALTER TABLE public.event_activity_type OWNER TO postgres;

--
-- Name: event_activity_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.event_activity_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.event_activity_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: event_follower; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_follower (
    id integer NOT NULL,
    id_event integer NOT NULL,
    id_user integer NOT NULL,
    start_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    end_date timestamp with time zone
);


ALTER TABLE public.event_follower OWNER TO postgres;

--
-- Name: event_follower_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.event_follower ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.event_follower_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.event ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: event_media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_media (
    id integer NOT NULL,
    id_event integer,
    id_media_url integer
);


ALTER TABLE public.event_media OWNER TO postgres;

--
-- Name: event_media_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.event_media ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.event_media_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: event_staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_staff (
    id integer NOT NULL,
    id_staff integer,
    id_event integer,
    id_roles integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.event_staff OWNER TO postgres;

--
-- Name: event_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.event_staff ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.event_staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: event_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_tags (
    id integer NOT NULL,
    id_event integer,
    name character varying(30)
);


ALTER TABLE public.event_tags OWNER TO postgres;

--
-- Name: event_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.event_tags ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.event_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: favorite_store; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorite_store (
    id integer NOT NULL,
    id_store integer,
    id_user integer,
    upload_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone
);


ALTER TABLE public.favorite_store OWNER TO postgres;

--
-- Name: favorite_store_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.favorite_store ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.favorite_store_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: features_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.features_spec (
    id integer NOT NULL,
    features_name character varying(30) NOT NULL
);


ALTER TABLE public.features_spec OWNER TO postgres;

--
-- Name: features_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.features_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.features_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: features_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.features_spec_product (
    id integer NOT NULL,
    id_features integer,
    id_inventory integer
);


ALTER TABLE public.features_spec_product OWNER TO postgres;

--
-- Name: features_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.features_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.features_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: finish_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.finish_spec (
    id integer NOT NULL,
    finish_name character varying(30) NOT NULL
);


ALTER TABLE public.finish_spec OWNER TO postgres;

--
-- Name: finish_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.finish_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.finish_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: finish_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.finish_spec_product (
    id integer NOT NULL,
    id_finish integer,
    id_inventory integer
);


ALTER TABLE public.finish_spec_product OWNER TO postgres;

--
-- Name: finish_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.finish_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.finish_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: food_compatibility_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.food_compatibility_spec (
    id integer NOT NULL,
    food_compatibility character varying(30) NOT NULL
);


ALTER TABLE public.food_compatibility_spec OWNER TO postgres;

--
-- Name: food_compatibility_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.food_compatibility_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.food_compatibility_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: food_compatibility_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.food_compatibility_spec_product (
    id integer NOT NULL,
    id_food_compatibility integer,
    id_inventory integer
);


ALTER TABLE public.food_compatibility_spec_product OWNER TO postgres;

--
-- Name: food_compatibility_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.food_compatibility_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.food_compatibility_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: fullfillment_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fullfillment_type (
    id integer NOT NULL,
    fname character varying(50) NOT NULL
);


ALTER TABLE public.fullfillment_type OWNER TO postgres;

--
-- Name: fullfillment_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.fullfillment_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.fullfillment_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: grouprole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grouprole (
    id integer NOT NULL,
    id_role integer,
    id_user integer,
    created timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.grouprole OWNER TO postgres;

--
-- Name: grouprole_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.grouprole ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.grouprole_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    id integer NOT NULL,
    id_brand integer,
    id_product integer,
    id_storelocation integer,
    is_auctioned boolean DEFAULT false NOT NULL,
    brand character varying(255),
    manufacturer character varying(255),
    stock_status smallint NOT NULL,
    sku character varying(100) NOT NULL,
    batch_number character varying(100) NOT NULL,
    restock_threshold integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    expiration_date timestamp with time zone NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    details text NOT NULL,
    upload_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone,
    CONSTRAINT inventory_quantity_check CHECK ((quantity >= 1))
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- Name: inventory_bulletlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_bulletlist (
    id integer NOT NULL,
    id_inventory integer,
    note text NOT NULL
);


ALTER TABLE public.inventory_bulletlist OWNER TO postgres;

--
-- Name: inventory_bulletlist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_bulletlist ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.inventory_bulletlist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: latest_deal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.latest_deal (
    id integer NOT NULL,
    id_user integer,
    latest_deals_code character varying(15) NOT NULL,
    id_inventory integer,
    description character varying(255) NOT NULL,
    startdate timestamp with time zone NOT NULL,
    end_date timestamp with time zone NOT NULL,
    dealprice numeric(10,2) NOT NULL
);


ALTER TABLE public.latest_deal OWNER TO postgres;

--
-- Name: latest_deal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.latest_deal ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.latest_deal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_category (
    id integer NOT NULL,
    id_parent_category integer,
    name character varying(30) NOT NULL,
    type smallint,
    media_url character varying(200),
    upload_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone
);


ALTER TABLE public.lukup_category OWNER TO postgres;

--
-- Name: lukup_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_category ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_category_specification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_category_specification (
    id integer NOT NULL,
    id_category integer,
    id_spec integer,
    cp_name character varying(255)
);


ALTER TABLE public.lukup_category_specification OWNER TO postgres;

--
-- Name: lukup_category_specification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_category_specification ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_category_specification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_complaint_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_complaint_category (
    id integer NOT NULL,
    category_name character varying(255) NOT NULL
);


ALTER TABLE public.lukup_complaint_category OWNER TO postgres;

--
-- Name: lukup_complaint_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_complaint_category ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_complaint_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_complaint_reason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_complaint_reason (
    id integer NOT NULL,
    id_category integer,
    reason_text character varying(255) NOT NULL
);


ALTER TABLE public.lukup_complaint_reason OWNER TO postgres;

--
-- Name: lukup_complaint_reason_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_complaint_reason ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_complaint_reason_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_dietary_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_dietary_tag (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE public.lukup_dietary_tag OWNER TO postgres;

--
-- Name: lukup_dietary_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_dietary_tag ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_dietary_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_event_activity_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_event_activity_type (
    id integer NOT NULL,
    activity_name character varying(30) NOT NULL
);


ALTER TABLE public.lukup_event_activity_type OWNER TO postgres;

--
-- Name: lukup_event_activity_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_event_activity_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_event_activity_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_event_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_event_category (
    id integer NOT NULL,
    id_parent_category integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.lukup_event_category OWNER TO postgres;

--
-- Name: lukup_event_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_event_category ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_event_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_product_specification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_product_specification (
    id integer NOT NULL,
    id_product integer,
    id_spec integer,
    ps_name character varying(255)
);


ALTER TABLE public.lukup_product_specification OWNER TO postgres;

--
-- Name: lukup_product_specification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_product_specification ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_product_specification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_report_metric; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_report_metric (
    id integer NOT NULL,
    rmname character varying(255) NOT NULL,
    metric_description text
);


ALTER TABLE public.lukup_report_metric OWNER TO postgres;

--
-- Name: lukup_report_metric_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_report_metric ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_report_metric_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_restauranct_cafe_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_restauranct_cafe_category (
    id integer NOT NULL,
    id_parent_category integer,
    type smallint,
    image_url character varying(255),
    visited integer,
    name character varying(255) NOT NULL,
    description character varying(255)
);


ALTER TABLE public.lukup_restauranct_cafe_category OWNER TO postgres;

--
-- Name: lukup_restauranct_cafe_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_restauranct_cafe_category ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_restauranct_cafe_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_return_reason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_return_reason (
    id integer NOT NULL,
    reason_description character varying(255) NOT NULL
);


ALTER TABLE public.lukup_return_reason OWNER TO postgres;

--
-- Name: lukup_return_reason_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_return_reason ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_return_reason_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_sauce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_sauce (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    calories numeric(4,1),
    image_url character varying(255),
    notes character varying(100)
);


ALTER TABLE public.lukup_sauce OWNER TO postgres;

--
-- Name: lukup_sauce_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_sauce ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_sauce_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_service_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_service_type (
    id integer NOT NULL,
    service_type character varying(50) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.lukup_service_type OWNER TO postgres;

--
-- Name: lukup_service_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_service_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_service_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_specification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_specification (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.lukup_specification OWNER TO postgres;

--
-- Name: lukup_specification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_specification ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_specification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lukup_topping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lukup_topping (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    calories numeric(4,1),
    image_url character varying(255),
    notes character varying(100)
);


ALTER TABLE public.lukup_topping OWNER TO postgres;

--
-- Name: lukup_topping_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lukup_topping ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lukup_topping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: material_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material_spec (
    id integer NOT NULL,
    material_name character varying(30) NOT NULL
);


ALTER TABLE public.material_spec OWNER TO postgres;

--
-- Name: material_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.material_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.material_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: material_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material_spec_product (
    id integer NOT NULL,
    id_material integer,
    id_inventory integer
);


ALTER TABLE public.material_spec_product OWNER TO postgres;

--
-- Name: material_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.material_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.material_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: media_store; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.media_store (
    id integer NOT NULL,
    id_store integer,
    id_media_url integer
);


ALTER TABLE public.media_store OWNER TO postgres;

--
-- Name: media_store_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.media_store ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.media_store_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: media_url; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.media_url (
    id integer NOT NULL,
    id_user integer,
    media_content_url text NOT NULL,
    media_type public.enum_mode_type,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.media_url OWNER TO postgres;

--
-- Name: media_url_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.media_url ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.media_url_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: media_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.media_user (
    id integer NOT NULL,
    id_user integer,
    id_media integer,
    title character varying(255),
    description text
);


ALTER TABLE public.media_user OWNER TO postgres;

--
-- Name: media_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.media_user ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.media_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: message_text; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_text (
    id integer NOT NULL,
    id_user integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.message_text OWNER TO postgres;

--
-- Name: message_text_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.message_text ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.message_text_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: num_of_door_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.num_of_door_spec (
    id integer NOT NULL,
    data smallint NOT NULL
);


ALTER TABLE public.num_of_door_spec OWNER TO postgres;

--
-- Name: num_of_door_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.num_of_door_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.num_of_door_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: num_of_door_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.num_of_door_spec_product (
    id integer NOT NULL,
    id_num_of_door integer,
    id_inventory integer
);


ALTER TABLE public.num_of_door_spec_product OWNER TO postgres;

--
-- Name: num_of_door_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.num_of_door_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.num_of_door_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: num_of_drawer_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.num_of_drawer_spec (
    id integer NOT NULL,
    data smallint NOT NULL
);


ALTER TABLE public.num_of_drawer_spec OWNER TO postgres;

--
-- Name: num_of_drawer_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.num_of_drawer_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.num_of_drawer_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: num_of_drawer_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.num_of_drawer_spec_product (
    id integer NOT NULL,
    id_num_of_drawer integer,
    id_inventory integer
);


ALTER TABLE public.num_of_drawer_spec_product OWNER TO postgres;

--
-- Name: num_of_drawer_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.num_of_drawer_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.num_of_drawer_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: num_of_shelve_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.num_of_shelve_spec (
    id integer NOT NULL,
    data smallint NOT NULL
);


ALTER TABLE public.num_of_shelve_spec OWNER TO postgres;

--
-- Name: num_of_shelve_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.num_of_shelve_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.num_of_shelve_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: num_of_shelve_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.num_of_shelve_spec_product (
    id integer NOT NULL,
    id_num_of_shelve integer,
    id_inventory integer
);


ALTER TABLE public.num_of_shelve_spec_product OWNER TO postgres;

--
-- Name: num_of_shelve_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.num_of_shelve_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.num_of_shelve_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: offer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offer (
    id integer NOT NULL,
    id_user integer,
    id_inventory integer,
    offer_price numeric(10,2) NOT NULL,
    offer_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    offer_accepted boolean DEFAULT false NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    CONSTRAINT offer_offer_price_check CHECK ((offer_price >= 0.00))
);


ALTER TABLE public.offer OWNER TO postgres;

--
-- Name: offer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.offer ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.offer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    id integer NOT NULL,
    id_customer integer,
    id_status integer,
    id_payment_method integer,
    id_delivery_method integer,
    id_delivery_zone integer,
    id_fullfillment integer,
    id_order_cancel_reason integer,
    order_total numeric(10,2) NOT NULL,
    shipping_address_id text NOT NULL,
    shipping_method public.enum_shipping_method,
    promotion_code character varying(255),
    internal_notes text,
    order_creation_channel public.enum_order_creation_channel,
    order_priority public.enum_order_priority DEFAULT 'regular'::public.enum_order_priority,
    discount_amount numeric(8,2),
    shipping_cost numeric(8,2) NOT NULL,
    order_confirmation_email_sent_date timestamp with time zone,
    order_date timestamp with time zone NOT NULL,
    order_refund_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT order_discount_amount_check CHECK ((discount_amount >= 0.00)),
    CONSTRAINT order_order_total_check CHECK ((order_total >= 0.00)),
    CONSTRAINT order_shipping_cost_check CHECK ((shipping_cost >= 0.00))
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- Name: order_delivery_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_delivery_address (
    id integer NOT NULL,
    id_order integer,
    addressline character varying(30),
    phone character varying(12),
    email character varying(255) NOT NULL,
    geom_location public.geometry(Point,4326)
);


ALTER TABLE public.order_delivery_address OWNER TO postgres;

--
-- Name: order_delivery_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.order_delivery_address ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_delivery_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."order" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: order_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item (
    id integer NOT NULL,
    id_order integer,
    id_inventory integer,
    quantity integer,
    unit_price numeric(10,2) NOT NULL
);


ALTER TABLE public.order_item OWNER TO postgres;

--
-- Name: order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.order_item ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: order_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_status (
    id integer NOT NULL,
    osname character varying(50) NOT NULL,
    descr character varying(100) NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone
);


ALTER TABLE public.order_status OWNER TO postgres;

--
-- Name: order_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.order_status ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: organizer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizer (
    id integer NOT NULL,
    organizer_uuid character varying(10) NOT NULL,
    id_city integer,
    id_state integer,
    organizer_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone_number jsonb NOT NULL,
    website_url character varying(255),
    description text,
    logo_url character varying(255),
    address_line1 character varying(255),
    address_line2 character varying(255),
    postal_code character varying(20),
    is_verified boolean DEFAULT false,
    social_media_links jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone
);


ALTER TABLE public.organizer OWNER TO postgres;

--
-- Name: organizer_follower; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizer_follower (
    id integer NOT NULL,
    id_organizer integer,
    id_user integer,
    start_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    end_date timestamp with time zone
);


ALTER TABLE public.organizer_follower OWNER TO postgres;

--
-- Name: organizer_follower_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.organizer_follower ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.organizer_follower_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: organizer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.organizer ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.organizer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: other_complaint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.other_complaint (
    id integer NOT NULL,
    id_complaint integer NOT NULL,
    complaint_name text NOT NULL
);


ALTER TABLE public.other_complaint OWNER TO postgres;

--
-- Name: other_complaint_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.other_complaint ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.other_complaint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: payment_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_method (
    id integer NOT NULL,
    method_name character varying(100) NOT NULL,
    method_description text,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone
);


ALTER TABLE public.payment_method OWNER TO postgres;

--
-- Name: payment_method_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.payment_method ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.payment_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: power_source_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.power_source_spec (
    id integer NOT NULL,
    power_source_name character varying(30) NOT NULL
);


ALTER TABLE public.power_source_spec OWNER TO postgres;

--
-- Name: power_source_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.power_source_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.power_source_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: power_source_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.power_source_spec_product (
    id integer NOT NULL,
    id_power_source integer,
    id_inventory integer
);


ALTER TABLE public.power_source_spec_product OWNER TO postgres;

--
-- Name: power_source_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.power_source_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.power_source_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: prime_service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prime_service (
    id integer NOT NULL,
    name character varying(30),
    id_service_type integer,
    description text,
    stype character varying(30) NOT NULL,
    benefits text,
    price numeric(10,2) NOT NULL,
    start_date timestamp without time zone,
    CONSTRAINT prime_service_price_check CHECK ((price >= 0.00))
);


ALTER TABLE public.prime_service OWNER TO postgres;

--
-- Name: prime_service_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.prime_service ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.prime_service_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: prime_service_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prime_service_user (
    id integer NOT NULL,
    id_user integer NOT NULL,
    id_prime_service integer NOT NULL,
    registered_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.prime_service_user OWNER TO postgres;

--
-- Name: prime_service_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.prime_service_user ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.prime_service_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: proc_lukup_event_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proc_lukup_event_category (
    id integer NOT NULL,
    id_parent_category integer,
    name character varying(255) NOT NULL,
    description character varying(255)
);


ALTER TABLE public.proc_lukup_event_category OWNER TO postgres;

--
-- Name: proc_lukup_event_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.proc_lukup_event_category ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.proc_lukup_event_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    ptype smallint,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_complaint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_complaint (
    id integer NOT NULL,
    id_complaint integer NOT NULL,
    id_product integer NOT NULL
);


ALTER TABLE public.product_complaint OWNER TO postgres;

--
-- Name: product_complaint_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_complaint ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_complaint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product_sanction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_sanction (
    id integer NOT NULL,
    id_inventory integer,
    id_sanction integer
);


ALTER TABLE public.product_sanction OWNER TO postgres;

--
-- Name: product_sanction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_sanction ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_sanction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: refund; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refund (
    id integer NOT NULL,
    id_order integer,
    id_refund integer,
    refund_amount numeric(10,2),
    return_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    return_shipment_tracking_number uuid DEFAULT gen_random_uuid(),
    returnreason_id integer,
    comment text,
    CONSTRAINT refund_refund_amount_check CHECK ((refund_amount >= 0.00))
);


ALTER TABLE public.refund OWNER TO postgres;

--
-- Name: refund_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.refund ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.refund_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: regulatory_sanction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regulatory_sanction (
    id integer NOT NULL,
    id_sanctioning_authority integer,
    sanctioned_entity character varying(20) NOT NULL,
    entity_name character varying(100) NOT NULL,
    reason text NOT NULL,
    sanction_type smallint NOT NULL,
    is_sanction_active boolean NOT NULL,
    sanction_outcome character varying(20) NOT NULL,
    start_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    end_date timestamp with time zone NOT NULL,
    sanctions_list character varying(255) NOT NULL,
    additional_information text,
    last_updated timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT regulatory_sanctions_date_valid CHECK ((start_date <= end_date))
);


ALTER TABLE public.regulatory_sanction OWNER TO postgres;

--
-- Name: regulatory_sanction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.regulatory_sanction ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.regulatory_sanction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: report; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.report (
    id integer NOT NULL,
    id_created_by integer,
    report_name character varying(255),
    report_description text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.report OWNER TO postgres;

--
-- Name: report_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.report ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: request_throttle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.request_throttle (
    id integer NOT NULL,
    amount integer,
    severity smallint DEFAULT 3 NOT NULL
);


ALTER TABLE public.request_throttle OWNER TO postgres;

--
-- Name: request_throttle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.request_throttle ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.request_throttle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: restaurant_cafe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.restaurant_cafe (
    id integer NOT NULL,
    id_store integer,
    id_cuisine_type integer,
    seating_capacity integer,
    michelin_stars smallint,
    ambiance smallint
);


ALTER TABLE public.restaurant_cafe OWNER TO postgres;

--
-- Name: restaurant_cafe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.restaurant_cafe ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.restaurant_cafe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: return_reason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.return_reason (
    id integer NOT NULL,
    return_reason character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.return_reason OWNER TO postgres;

--
-- Name: return_reason_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.return_reason ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.return_reason_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    role_name character varying(30) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.roles ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sales_header; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_header (
    id integer NOT NULL,
    id_customer integer,
    id_ship_to_address integer,
    id_sale_user integer,
    sales_order_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    revision_number integer DEFAULT 1,
    status smallint,
    online_order_flag boolean DEFAULT true,
    ship_method_id integer NOT NULL,
    subtotal numeric(12,2) NOT NULL,
    taxamt numeric(12,2) NOT NULL,
    freight numeric(12,2) NOT NULL,
    total_due numeric(12,2) NOT NULL,
    order_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    due_date timestamp with time zone NOT NULL,
    shipdate timestamp with time zone NOT NULL,
    CONSTRAINT sales_header_revision_number_check CHECK ((revision_number >= 1))
);


ALTER TABLE public.sales_header OWNER TO postgres;

--
-- Name: sales_header_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.sales_header ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sales_header_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sauce_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sauce_price (
    id integer NOT NULL,
    id_restaurant integer,
    id_sauce integer,
    price numeric(4,1) NOT NULL
);


ALTER TABLE public.sauce_price OWNER TO postgres;

--
-- Name: sauce_price_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.sauce_price ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sauce_price_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: saved_store; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saved_store (
    id integer NOT NULL,
    id_user integer,
    id_store integer
);


ALTER TABLE public.saved_store OWNER TO postgres;

--
-- Name: saved_store_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.saved_store ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.saved_store_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: search_key_inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.search_key_inventory (
    id integer NOT NULL,
    key_name character varying(100),
    id_inventory integer
);


ALTER TABLE public.search_key_inventory OWNER TO postgres;

--
-- Name: search_key_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.search_key_inventory ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.search_key_inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: securitysettings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.securitysettings (
    id integer NOT NULL,
    id_user integer,
    setting_is_two_factor_authentication_enabled boolean NOT NULL,
    setting_is_multi_factor_authentication_enabled boolean NOT NULL,
    setting_is_strong_password_required boolean NOT NULL,
    setting_is_email_verification_required boolean NOT NULL,
    setting_is_phone_verification_required boolean NOT NULL,
    setting_is_captcha_required boolean NOT NULL,
    setting_is_data_backup_enabled boolean NOT NULL,
    setting_is_login_attempt_limitation_enabled boolean NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone
);


ALTER TABLE public.securitysettings OWNER TO postgres;

--
-- Name: securitysettings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.securitysettings ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.securitysettings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: seller; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seller (
    id integer NOT NULL,
    id_user integer,
    bmsname character varying(30) NOT NULL,
    count integer,
    rating numeric(3,1) NOT NULL,
    is_certified boolean DEFAULT false,
    is_active boolean DEFAULT true,
    upload_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone
);


ALTER TABLE public.seller OWNER TO postgres;

--
-- Name: seller_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.seller ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.seller_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: service_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_request (
    id integer NOT NULL,
    id_customer integer,
    id_order integer,
    service_status smallint DEFAULT 1,
    descr text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    resolved_at timestamp with time zone,
    assigned_to integer,
    priority smallint DEFAULT 2,
    notes text,
    is_resolved boolean DEFAULT false,
    resolution_details text
);


ALTER TABLE public.service_request OWNER TO postgres;

--
-- Name: service_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.service_request ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.service_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    id integer NOT NULL,
    id_event integer,
    capacity integer,
    session_description text,
    title character varying(200) NOT NULL,
    description text,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    location public.geometry(Point,4326),
    location_description text,
    CONSTRAINT session_capacity_check CHECK ((capacity > 0))
);


ALTER TABLE public.session OWNER TO postgres;

--
-- Name: session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.session ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: shipping_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_address (
    id integer NOT NULL,
    customer_id integer,
    address_line1 character varying(255),
    address_line2 character varying(255),
    id_city integer,
    id_state integer,
    postal_code character varying(255)
);


ALTER TABLE public.shipping_address OWNER TO postgres;

--
-- Name: shipping_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.shipping_address ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipping_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: smart_home_protocol_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.smart_home_protocol_spec (
    id integer NOT NULL,
    smart_home_protocol_name character varying(30) NOT NULL
);


ALTER TABLE public.smart_home_protocol_spec OWNER TO postgres;

--
-- Name: smart_home_protocol_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.smart_home_protocol_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.smart_home_protocol_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: smart_home_protocol_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.smart_home_protocol_spec_product (
    id integer NOT NULL,
    id_smart_home_protocol integer,
    id_inventory integer
);


ALTER TABLE public.smart_home_protocol_spec_product OWNER TO postgres;

--
-- Name: smart_home_protocol_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.smart_home_protocol_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.smart_home_protocol_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: states; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.states (
    id integer NOT NULL,
    state_name character varying(30) NOT NULL,
    id_country character varying(5),
    geom_location public.geometry(Point,4326)
);


ALTER TABLE public.states OWNER TO postgres;

--
-- Name: states_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.states ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    id integer NOT NULL,
    status_name character varying(8) NOT NULL
);


ALTER TABLE public.status OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.status ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: store; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    brands_name character varying(255) NOT NULL,
    website_url character varying(255),
    branchs integer DEFAULT 1,
    approved boolean DEFAULT false,
    postal_code character varying(6),
    store_choice smallint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone
);


ALTER TABLE public.store OWNER TO postgres;

--
-- Name: store_accessiblity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_accessiblity (
    id integer NOT NULL,
    id_store_location integer,
    is_parking_accessible boolean DEFAULT false NOT NULL,
    is_restroom_accessible boolean DEFAULT false NOT NULL,
    is_wheelchair_accessible boolean DEFAULT false NOT NULL
);


ALTER TABLE public.store_accessiblity OWNER TO postgres;

--
-- Name: store_accessiblity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.store_accessiblity ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.store_accessiblity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: store_complaint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_complaint (
    id integer NOT NULL,
    id_complaint integer NOT NULL,
    id_store integer NOT NULL
);


ALTER TABLE public.store_complaint OWNER TO postgres;

--
-- Name: store_complaint_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.store_complaint ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.store_complaint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: store_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_detail (
    id integer NOT NULL,
    id_store_location integer,
    id_store integer,
    addr character varying(255) NOT NULL,
    is_main_branch boolean DEFAULT true,
    open_time timestamp with time zone NOT NULL,
    close_time timestamp with time zone NOT NULL,
    is_delivery_available boolean DEFAULT true,
    website_url character varying(255),
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone
);


ALTER TABLE public.store_detail OWNER TO postgres;

--
-- Name: store_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.store_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.store_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: store_fullfillment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_fullfillment (
    id integer NOT NULL,
    id_fullfillment integer,
    id_inventory integer
);


ALTER TABLE public.store_fullfillment OWNER TO postgres;

--
-- Name: store_fullfillment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.store_fullfillment ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.store_fullfillment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: store_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.store ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.store_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: store_location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_location (
    id integer NOT NULL,
    id_city integer,
    id_store integer,
    contact_phone character varying(20),
    contact_email character varying(100),
    floor integer,
    postal_code character varying(10) NOT NULL,
    geom_location public.geometry(Point,4326)
);


ALTER TABLE public.store_location OWNER TO postgres;

--
-- Name: store_location_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.store_location ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.store_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: store_report; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_report (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.store_report OWNER TO postgres;

--
-- Name: store_report_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.store_report ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.store_report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: store_review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_review (
    id integer NOT NULL,
    id_store integer,
    id_parent_comment integer,
    id_commenter integer,
    review character varying(255) NOT NULL,
    rate_count integer,
    rating numeric(2,1) NOT NULL,
    upload_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone,
    CONSTRAINT parent_comment_userid_check CHECK ((id_parent_comment <> id)),
    CONSTRAINT store_review_rate_count_check CHECK ((rate_count > 0))
);


ALTER TABLE public.store_review OWNER TO postgres;

--
-- Name: store_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.store_review ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.store_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: store_sanction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_sanction (
    id integer NOT NULL,
    id_store integer,
    id_sanction integer
);


ALTER TABLE public.store_sanction OWNER TO postgres;

--
-- Name: store_sanction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.store_sanction ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.store_sanction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: style_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.style_spec (
    id integer NOT NULL,
    style_name character varying(30) NOT NULL
);


ALTER TABLE public.style_spec OWNER TO postgres;

--
-- Name: style_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.style_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.style_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: style_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.style_spec_product (
    id integer NOT NULL,
    id_style integer,
    id_inventory integer
);


ALTER TABLE public.style_spec_product OWNER TO postgres;

--
-- Name: style_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.style_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.style_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: subscription_fee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_fee (
    id integer NOT NULL,
    id_user integer NOT NULL,
    start_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    end_date timestamp with time zone NOT NULL,
    is_subscription_status_active boolean DEFAULT true,
    subscription_type smallint NOT NULL,
    discount_type smallint NOT NULL,
    price numeric(10,2),
    discount numeric(10,2),
    credit_per_month integer,
    credit_per_year integer,
    auto_renew boolean,
    last_renewal_date timestamp with time zone,
    next_renewal_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    CONSTRAINT subscription_fee_date_valid CHECK ((start_date <= end_date)),
    CONSTRAINT subscription_fee_discount_check CHECK ((discount >= 0.00)),
    CONSTRAINT subscription_fee_price_check CHECK ((price >= 0.00))
);


ALTER TABLE public.subscription_fee OWNER TO postgres;

--
-- Name: subscription_fee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.subscription_fee ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.subscription_fee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: support_agent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.support_agent (
    id integer NOT NULL,
    id_user integer,
    assigned_skills text,
    id_authtoken integer,
    last_login_timestamp timestamp with time zone,
    last_logout_timestamp timestamp with time zone,
    login_attempts integer DEFAULT 0,
    suspension_timestamp timestamp without time zone,
    suspension_reason text
);


ALTER TABLE public.support_agent OWNER TO postgres;

--
-- Name: support_agent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.support_agent ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.support_agent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: table_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.table_list (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.table_list OWNER TO postgres;

--
-- Name: table_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.table_list ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.table_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket (
    id integer NOT NULL,
    ticket_uuid uuid DEFAULT gen_random_uuid(),
    id_event integer,
    ticket_name character varying(255) NOT NULL,
    description text,
    sale_start_date timestamp without time zone NOT NULL,
    sale_end_date timestamp without time zone NOT NULL,
    is_active boolean DEFAULT true,
    store_choices smallint,
    max_tickets_per_order integer,
    min_tickets_per_order integer DEFAULT 1,
    is_free boolean DEFAULT false,
    currency character varying(3) DEFAULT 'USD'::character varying,
    ticket_discount_amount numeric(10,2),
    ticket_promotion_code character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone,
    CONSTRAINT tickets_valid CHECK ((sale_start_date <= sale_end_date))
);


ALTER TABLE public.ticket OWNER TO postgres;

--
-- Name: ticket_discount_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket_discount_code (
    id integer NOT NULL,
    ticket_discount_code_num character varying(13),
    ticketid integer NOT NULL
);


ALTER TABLE public.ticket_discount_code OWNER TO postgres;

--
-- Name: ticket_discount_code_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ticket_discount_code ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ticket_discount_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ticket ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ticket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ticket_promo_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket_promo_code (
    id integer NOT NULL,
    ticket_promo_code_num character varying(13),
    id_ticket integer,
    discount_percent integer,
    CONSTRAINT ticket_promo_code_discount_percent_check CHECK ((discount_percent > 0))
);


ALTER TABLE public.ticket_promo_code OWNER TO postgres;

--
-- Name: ticket_promo_code_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ticket_promo_code ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ticket_promo_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ticket_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket_type (
    id integer NOT NULL,
    id_event integer,
    barcode_image bytea,
    name smallint,
    description text,
    price numeric(10,2) NOT NULL,
    capacity integer NOT NULL,
    privileges text
);


ALTER TABLE public.ticket_type OWNER TO postgres;

--
-- Name: ticket_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ticket_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ticket_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: topping_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topping_price (
    id integer NOT NULL,
    id_restaurant integer,
    id_topping integer,
    price numeric(4,1) NOT NULL
);


ALTER TABLE public.topping_price OWNER TO postgres;

--
-- Name: topping_price_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.topping_price ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.topping_price_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ubo_business_affiliation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ubo_business_affiliation (
    id integer NOT NULL,
    id_ubo uuid,
    id_verifier integer,
    affiliation_type character varying(20),
    affiliation_name character varying(255) NOT NULL,
    affiliation_description character varying(255) NOT NULL,
    verification_status character varying(20),
    verification_comment character varying(255),
    verification_date timestamp with time zone NOT NULL
);


ALTER TABLE public.ubo_business_affiliation OWNER TO postgres;

--
-- Name: ubo_business_affiliation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ubo_business_affiliation ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ubo_business_affiliation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ubo_verification_document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ubo_verification_document (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    id_user integer,
    id_verifier integer,
    document_type character varying(20) NOT NULL,
    document_number character varying(15) NOT NULL,
    document_issuer character varying(100) NOT NULL,
    document_issue_date timestamp with time zone NOT NULL,
    document_expiry_date timestamp with time zone NOT NULL,
    ownership_percentage numeric(5,2) NOT NULL,
    document_file_path character varying(255) NOT NULL,
    document_id character varying(255) NOT NULL,
    document_verification_status character varying(20) NOT NULL,
    tax_identification_number character varying(20) NOT NULL,
    verification_comments character varying(100) NOT NULL,
    verification_date timestamp with time zone NOT NULL,
    CONSTRAINT ubo_verification_document_ownership_percentage_check CHECK ((ownership_percentage >= 0.00))
);


ALTER TABLE public.ubo_verification_document OWNER TO postgres;

--
-- Name: upc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.upc (
    id integer NOT NULL,
    upc_code character varying(12) NOT NULL,
    id_inventory integer
);


ALTER TABLE public.upc OWNER TO postgres;

--
-- Name: upc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.upc ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.upc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    id_district integer,
    id_role integer,
    user_uuid uuid DEFAULT public.uuid_generate_v4(),
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    phone character varying(12) NOT NULL,
    gender boolean NOT NULL,
    id_type public.enum_id_type NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(60) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    rating numeric(3,1) NOT NULL,
    geom_location public.geometry(Point,4326)
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_event_category_like; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_event_category_like (
    id integer NOT NULL,
    id_event integer,
    id_user integer
);


ALTER TABLE public.user_event_category_like OWNER TO postgres;

--
-- Name: user_event_category_like_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.user_event_category_like ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_event_category_like_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."user" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_permission_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_permission_entity (
    id integer NOT NULL,
    id_user integer,
    id_table_list integer,
    operation smallint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_permission_entity OWNER TO postgres;

--
-- Name: user_permission_entity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.user_permission_entity ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_permission_entity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vehicle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle (
    id integer NOT NULL,
    id_color integer,
    id_owner integer,
    license_plate character varying(50) NOT NULL,
    vehicle_type smallint,
    make character varying(50) NOT NULL,
    model character varying(50) NOT NULL,
    year integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone
);


ALTER TABLE public.vehicle OWNER TO postgres;

--
-- Name: vehicle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.vehicle ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.vehicle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: venue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venue (
    id integer NOT NULL,
    id_event integer,
    venue_name character varying(100) NOT NULL,
    address character varying(255) NOT NULL,
    id_city integer,
    id_state integer,
    capacity integer,
    venue_type character varying(50),
    geom_location public.geometry(Point,4326),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone
);


ALTER TABLE public.venue OWNER TO postgres;

--
-- Name: venue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.venue ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.venue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: voltage_spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.voltage_spec (
    id integer NOT NULL,
    voltage_name character varying(30) NOT NULL
);


ALTER TABLE public.voltage_spec OWNER TO postgres;

--
-- Name: voltage_spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.voltage_spec ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.voltage_spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: voltage_spec_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.voltage_spec_product (
    id integer NOT NULL,
    id_voltage integer,
    id_inventory integer
);


ALTER TABLE public.voltage_spec_product OWNER TO postgres;

--
-- Name: voltage_spec_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.voltage_spec_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.voltage_spec_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: add_to_watchlist add_to_watchlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.add_to_watchlist
    ADD CONSTRAINT add_to_watchlist_pkey PRIMARY KEY (id);


--
-- Name: auction auction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auction
    ADD CONSTRAINT auction_pkey PRIMARY KEY (id);


--
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_authkey_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_authkey_key UNIQUE (authkey);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_refersh_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_refersh_token_key UNIQUE (refersh_token);


--
-- Name: auto_bid auto_bid_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auto_bid
    ADD CONSTRAINT auto_bid_pkey PRIMARY KEY (id);


--
-- Name: bid bid_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bid
    ADD CONSTRAINT bid_pkey PRIMARY KEY (id);


--
-- Name: billing_addresses billing_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing_addresses
    ADD CONSTRAINT billing_addresses_pkey PRIMARY KEY (id);


--
-- Name: book_detail book_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_detail
    ADD CONSTRAINT book_detail_pkey PRIMARY KEY (id);


--
-- Name: book_inventory book_inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_inventory
    ADD CONSTRAINT book_inventory_pkey PRIMARY KEY (id);


--
-- Name: book_media book_media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_media
    ADD CONSTRAINT book_media_pkey PRIMARY KEY (id);


--
-- Name: book_promo_code book_promo_code_book_promo_code_num_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_promo_code
    ADD CONSTRAINT book_promo_code_book_promo_code_num_key UNIQUE (book_promo_code_num);


--
-- Name: book_promo_code book_promo_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_promo_code
    ADD CONSTRAINT book_promo_code_pkey PRIMARY KEY (id);


--
-- Name: book_review book_review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_review
    ADD CONSTRAINT book_review_pkey PRIMARY KEY (id);


--
-- Name: brand brand_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brand
    ADD CONSTRAINT brand_name_key UNIQUE (name);


--
-- Name: brand brand_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brand
    ADD CONSTRAINT brand_pkey PRIMARY KEY (id);


--
-- Name: buy_now_price buy_now_price_buy_now_price_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_now_price
    ADD CONSTRAINT buy_now_price_buy_now_price_key UNIQUE (buy_now_price);


--
-- Name: buy_now_price buy_now_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_now_price
    ADD CONSTRAINT buy_now_price_pkey PRIMARY KEY (id);


--
-- Name: caching_expiry_setting caching_expiry_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caching_expiry_setting
    ADD CONSTRAINT caching_expiry_setting_pkey PRIMARY KEY (id);


--
-- Name: caching_feature caching_feature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caching_feature
    ADD CONSTRAINT caching_feature_pkey PRIMARY KEY (id);


--
-- Name: caching_setting caching_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caching_setting
    ADD CONSTRAINT caching_setting_pkey PRIMARY KEY (id);


--
-- Name: caching_settings_detail caching_settings_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caching_settings_detail
    ADD CONSTRAINT caching_settings_detail_pkey PRIMARY KEY (id);


--
-- Name: caching_type caching_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caching_type
    ADD CONSTRAINT caching_type_pkey PRIMARY KEY (id);


--
-- Name: capacity_spec capacity_spec_capacity_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capacity_spec
    ADD CONSTRAINT capacity_spec_capacity_key UNIQUE (capacity);


--
-- Name: capacity_spec capacity_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capacity_spec
    ADD CONSTRAINT capacity_spec_pkey PRIMARY KEY (id);


--
-- Name: capacity_spec_product capacity_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capacity_spec_product
    ADD CONSTRAINT capacity_spec_product_pkey PRIMARY KEY (id);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- Name: chat_media_store chat_media_store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_media_store
    ADD CONSTRAINT chat_media_store_pkey PRIMARY KEY (id);


--
-- Name: chat_room_media chat_room_media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_room_media
    ADD CONSTRAINT chat_room_media_pkey PRIMARY KEY (id);


--
-- Name: chat_room chat_room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_room
    ADD CONSTRAINT chat_room_pkey PRIMARY KEY (id);


--
-- Name: chat_single chat_single_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_single
    ADD CONSTRAINT chat_single_pkey PRIMARY KEY (id);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- Name: clerks clerks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clerks
    ADD CONSTRAINT clerks_pkey PRIMARY KEY (id);


--
-- Name: color_spec color_spec_color_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.color_spec
    ADD CONSTRAINT color_spec_color_name_key UNIQUE (color_name);


--
-- Name: color_spec color_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.color_spec
    ADD CONSTRAINT color_spec_pkey PRIMARY KEY (id);


--
-- Name: common_specification common_specification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.common_specification
    ADD CONSTRAINT common_specification_pkey PRIMARY KEY (id);


--
-- Name: complaint complaint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complaint
    ADD CONSTRAINT complaint_pkey PRIMARY KEY (id);


--
-- Name: components_included_spec components_included_spec_components_included_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components_included_spec
    ADD CONSTRAINT components_included_spec_components_included_name_key UNIQUE (components_included_name);


--
-- Name: components_included_spec components_included_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components_included_spec
    ADD CONSTRAINT components_included_spec_pkey PRIMARY KEY (id);


--
-- Name: components_included_spec_product components_included_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components_included_spec_product
    ADD CONSTRAINT components_included_spec_product_pkey PRIMARY KEY (id);


--
-- Name: country country_country_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_country_name_key UNIQUE (country_name);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- Name: cuisine_type cuisine_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuisine_type
    ADD CONSTRAINT cuisine_type_pkey PRIMARY KEY (id);


--
-- Name: customer_return_request customer_return_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_return_request
    ADD CONSTRAINT customer_return_request_pkey PRIMARY KEY (id);


--
-- Name: customer_service_request customer_service_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_service_request
    ADD CONSTRAINT customer_service_request_pkey PRIMARY KEY (id);


--
-- Name: delivery_option delivery_option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_option
    ADD CONSTRAINT delivery_option_pkey PRIMARY KEY (id);


--
-- Name: delivery_person delivery_person_bmdeliverer_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_person
    ADD CONSTRAINT delivery_person_bmdeliverer_key UNIQUE (bmdeliverer);


--
-- Name: delivery_person delivery_person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_person
    ADD CONSTRAINT delivery_person_pkey PRIMARY KEY (id);


--
-- Name: delivery_person_review delivery_person_review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_person_review
    ADD CONSTRAINT delivery_person_review_pkey PRIMARY KEY (id);


--
-- Name: delivery_status delivery_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_status
    ADD CONSTRAINT delivery_status_pkey PRIMARY KEY (id);


--
-- Name: dish_drink_and_extra dish_drink_and_extra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish_drink_and_extra
    ADD CONSTRAINT dish_drink_and_extra_pkey PRIMARY KEY (id);


--
-- Name: dish_meal dish_meal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish_meal
    ADD CONSTRAINT dish_meal_pkey PRIMARY KEY (id);


--
-- Name: dish_rating dish_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish_rating
    ADD CONSTRAINT dish_rating_pkey PRIMARY KEY (id);


--
-- Name: districts districts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_pkey PRIMARY KEY (id);


--
-- Name: driver_complaint driver_complaint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_complaint
    ADD CONSTRAINT driver_complaint_pkey PRIMARY KEY (id);


--
-- Name: event_activity_type event_activity_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_activity_type
    ADD CONSTRAINT event_activity_type_pkey PRIMARY KEY (id);


--
-- Name: event_follower event_follower_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_follower
    ADD CONSTRAINT event_follower_pkey PRIMARY KEY (id);


--
-- Name: event_media event_media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_media
    ADD CONSTRAINT event_media_pkey PRIMARY KEY (id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: event_staff event_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_staff
    ADD CONSTRAINT event_staff_pkey PRIMARY KEY (id);


--
-- Name: event_tags event_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags
    ADD CONSTRAINT event_tags_pkey PRIMARY KEY (id);


--
-- Name: favorite_store favorite_store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorite_store
    ADD CONSTRAINT favorite_store_pkey PRIMARY KEY (id);


--
-- Name: features_spec features_spec_features_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features_spec
    ADD CONSTRAINT features_spec_features_name_key UNIQUE (features_name);


--
-- Name: features_spec features_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features_spec
    ADD CONSTRAINT features_spec_pkey PRIMARY KEY (id);


--
-- Name: features_spec_product features_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features_spec_product
    ADD CONSTRAINT features_spec_product_pkey PRIMARY KEY (id);


--
-- Name: finish_spec finish_spec_finish_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finish_spec
    ADD CONSTRAINT finish_spec_finish_name_key UNIQUE (finish_name);


--
-- Name: finish_spec finish_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finish_spec
    ADD CONSTRAINT finish_spec_pkey PRIMARY KEY (id);


--
-- Name: finish_spec_product finish_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finish_spec_product
    ADD CONSTRAINT finish_spec_product_pkey PRIMARY KEY (id);


--
-- Name: food_compatibility_spec food_compatibility_spec_food_compatibility_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_compatibility_spec
    ADD CONSTRAINT food_compatibility_spec_food_compatibility_key UNIQUE (food_compatibility);


--
-- Name: food_compatibility_spec food_compatibility_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_compatibility_spec
    ADD CONSTRAINT food_compatibility_spec_pkey PRIMARY KEY (id);


--
-- Name: food_compatibility_spec_product food_compatibility_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_compatibility_spec_product
    ADD CONSTRAINT food_compatibility_spec_product_pkey PRIMARY KEY (id);


--
-- Name: fullfillment_type fullfillment_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fullfillment_type
    ADD CONSTRAINT fullfillment_type_pkey PRIMARY KEY (id);


--
-- Name: grouprole grouprole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grouprole
    ADD CONSTRAINT grouprole_pkey PRIMARY KEY (id);


--
-- Name: inventory inventory_batch_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_batch_number_key UNIQUE (batch_number);


--
-- Name: inventory_bulletlist inventory_bulletlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_bulletlist
    ADD CONSTRAINT inventory_bulletlist_pkey PRIMARY KEY (id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);


--
-- Name: latest_deal latest_deal_latest_deals_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.latest_deal
    ADD CONSTRAINT latest_deal_latest_deals_code_key UNIQUE (latest_deals_code);


--
-- Name: latest_deal latest_deal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.latest_deal
    ADD CONSTRAINT latest_deal_pkey PRIMARY KEY (id);


--
-- Name: lukup_category lukup_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_category
    ADD CONSTRAINT lukup_category_pkey PRIMARY KEY (id);


--
-- Name: lukup_category_specification lukup_category_specification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_category_specification
    ADD CONSTRAINT lukup_category_specification_pkey PRIMARY KEY (id);


--
-- Name: lukup_complaint_category lukup_complaint_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_complaint_category
    ADD CONSTRAINT lukup_complaint_category_pkey PRIMARY KEY (id);


--
-- Name: lukup_complaint_reason lukup_complaint_reason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_complaint_reason
    ADD CONSTRAINT lukup_complaint_reason_pkey PRIMARY KEY (id);


--
-- Name: lukup_dietary_tag lukup_dietary_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_dietary_tag
    ADD CONSTRAINT lukup_dietary_tag_pkey PRIMARY KEY (id);


--
-- Name: lukup_event_activity_type lukup_event_activity_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_event_activity_type
    ADD CONSTRAINT lukup_event_activity_type_pkey PRIMARY KEY (id);


--
-- Name: lukup_event_category lukup_event_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_event_category
    ADD CONSTRAINT lukup_event_category_pkey PRIMARY KEY (id);


--
-- Name: lukup_product_specification lukup_product_specification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_product_specification
    ADD CONSTRAINT lukup_product_specification_pkey PRIMARY KEY (id);


--
-- Name: lukup_report_metric lukup_report_metric_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_report_metric
    ADD CONSTRAINT lukup_report_metric_pkey PRIMARY KEY (id);


--
-- Name: lukup_restauranct_cafe_category lukup_restauranct_cafe_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_restauranct_cafe_category
    ADD CONSTRAINT lukup_restauranct_cafe_category_pkey PRIMARY KEY (id);


--
-- Name: lukup_return_reason lukup_return_reason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_return_reason
    ADD CONSTRAINT lukup_return_reason_pkey PRIMARY KEY (id);


--
-- Name: lukup_sauce lukup_sauce_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_sauce
    ADD CONSTRAINT lukup_sauce_pkey PRIMARY KEY (id);


--
-- Name: lukup_service_type lukup_service_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_service_type
    ADD CONSTRAINT lukup_service_type_pkey PRIMARY KEY (id);


--
-- Name: lukup_specification lukup_specification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_specification
    ADD CONSTRAINT lukup_specification_pkey PRIMARY KEY (id);


--
-- Name: lukup_topping lukup_topping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_topping
    ADD CONSTRAINT lukup_topping_pkey PRIMARY KEY (id);


--
-- Name: material_spec material_spec_material_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_spec
    ADD CONSTRAINT material_spec_material_name_key UNIQUE (material_name);


--
-- Name: material_spec material_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_spec
    ADD CONSTRAINT material_spec_pkey PRIMARY KEY (id);


--
-- Name: material_spec_product material_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_spec_product
    ADD CONSTRAINT material_spec_product_pkey PRIMARY KEY (id);


--
-- Name: media_store media_store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_store
    ADD CONSTRAINT media_store_pkey PRIMARY KEY (id);


--
-- Name: media_url media_url_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_url
    ADD CONSTRAINT media_url_pkey PRIMARY KEY (id);


--
-- Name: media_user media_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_user
    ADD CONSTRAINT media_user_pkey PRIMARY KEY (id);


--
-- Name: message_text message_text_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_text
    ADD CONSTRAINT message_text_pkey PRIMARY KEY (id);


--
-- Name: num_of_door_spec num_of_door_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.num_of_door_spec
    ADD CONSTRAINT num_of_door_spec_pkey PRIMARY KEY (id);


--
-- Name: num_of_door_spec_product num_of_door_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.num_of_door_spec_product
    ADD CONSTRAINT num_of_door_spec_product_pkey PRIMARY KEY (id);


--
-- Name: num_of_drawer_spec num_of_drawer_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.num_of_drawer_spec
    ADD CONSTRAINT num_of_drawer_spec_pkey PRIMARY KEY (id);


--
-- Name: num_of_drawer_spec_product num_of_drawer_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.num_of_drawer_spec_product
    ADD CONSTRAINT num_of_drawer_spec_product_pkey PRIMARY KEY (id);


--
-- Name: num_of_shelve_spec num_of_shelve_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.num_of_shelve_spec
    ADD CONSTRAINT num_of_shelve_spec_pkey PRIMARY KEY (id);


--
-- Name: num_of_shelve_spec_product num_of_shelve_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.num_of_shelve_spec_product
    ADD CONSTRAINT num_of_shelve_spec_product_pkey PRIMARY KEY (id);


--
-- Name: offer offer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offer
    ADD CONSTRAINT offer_pkey PRIMARY KEY (id);


--
-- Name: order_delivery_address order_delivery_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_delivery_address
    ADD CONSTRAINT order_delivery_address_pkey PRIMARY KEY (id);


--
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: order_status order_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT order_status_pkey PRIMARY KEY (id);


--
-- Name: organizer_follower organizer_follower_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizer_follower
    ADD CONSTRAINT organizer_follower_pkey PRIMARY KEY (id);


--
-- Name: organizer organizer_organizer_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizer
    ADD CONSTRAINT organizer_organizer_uuid_key UNIQUE (organizer_uuid);


--
-- Name: organizer organizer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizer
    ADD CONSTRAINT organizer_pkey PRIMARY KEY (id);


--
-- Name: other_complaint other_complaint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.other_complaint
    ADD CONSTRAINT other_complaint_pkey PRIMARY KEY (id);


--
-- Name: payment_method payment_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method
    ADD CONSTRAINT payment_method_pkey PRIMARY KEY (id);


--
-- Name: power_source_spec power_source_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.power_source_spec
    ADD CONSTRAINT power_source_spec_pkey PRIMARY KEY (id);


--
-- Name: power_source_spec power_source_spec_power_source_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.power_source_spec
    ADD CONSTRAINT power_source_spec_power_source_name_key UNIQUE (power_source_name);


--
-- Name: power_source_spec_product power_source_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.power_source_spec_product
    ADD CONSTRAINT power_source_spec_product_pkey PRIMARY KEY (id);


--
-- Name: prime_service prime_service_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prime_service
    ADD CONSTRAINT prime_service_pkey PRIMARY KEY (id);


--
-- Name: prime_service_user prime_service_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prime_service_user
    ADD CONSTRAINT prime_service_user_pkey PRIMARY KEY (id);


--
-- Name: proc_lukup_event_category proc_lukup_event_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proc_lukup_event_category
    ADD CONSTRAINT proc_lukup_event_category_pkey PRIMARY KEY (id);


--
-- Name: product_complaint product_complaint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_complaint
    ADD CONSTRAINT product_complaint_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: product_sanction product_sanction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_sanction
    ADD CONSTRAINT product_sanction_pkey PRIMARY KEY (id);


--
-- Name: refund refund_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT refund_pkey PRIMARY KEY (id);


--
-- Name: regulatory_sanction regulatory_sanction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regulatory_sanction
    ADD CONSTRAINT regulatory_sanction_pkey PRIMARY KEY (id);


--
-- Name: report report_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_pkey PRIMARY KEY (id);


--
-- Name: request_throttle request_throttle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.request_throttle
    ADD CONSTRAINT request_throttle_pkey PRIMARY KEY (id);


--
-- Name: restaurant_cafe restaurant_cafe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurant_cafe
    ADD CONSTRAINT restaurant_cafe_pkey PRIMARY KEY (id);


--
-- Name: return_reason return_reason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_reason
    ADD CONSTRAINT return_reason_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sales_header sales_header_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_header
    ADD CONSTRAINT sales_header_pkey PRIMARY KEY (id);


--
-- Name: sauce_price sauce_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sauce_price
    ADD CONSTRAINT sauce_price_pkey PRIMARY KEY (id);


--
-- Name: saved_store saved_store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_store
    ADD CONSTRAINT saved_store_pkey PRIMARY KEY (id);


--
-- Name: search_key_inventory search_key_inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.search_key_inventory
    ADD CONSTRAINT search_key_inventory_pkey PRIMARY KEY (id);


--
-- Name: securitysettings securitysettings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.securitysettings
    ADD CONSTRAINT securitysettings_pkey PRIMARY KEY (id);


--
-- Name: seller seller_bmsname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller
    ADD CONSTRAINT seller_bmsname_key UNIQUE (bmsname);


--
-- Name: seller seller_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller
    ADD CONSTRAINT seller_pkey PRIMARY KEY (id);


--
-- Name: service_request service_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_request
    ADD CONSTRAINT service_request_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- Name: shipping_address shipping_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_address
    ADD CONSTRAINT shipping_address_pkey PRIMARY KEY (id);


--
-- Name: smart_home_protocol_spec smart_home_protocol_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_home_protocol_spec
    ADD CONSTRAINT smart_home_protocol_spec_pkey PRIMARY KEY (id);


--
-- Name: smart_home_protocol_spec_product smart_home_protocol_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_home_protocol_spec_product
    ADD CONSTRAINT smart_home_protocol_spec_product_pkey PRIMARY KEY (id);


--
-- Name: smart_home_protocol_spec smart_home_protocol_spec_smart_home_protocol_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_home_protocol_spec
    ADD CONSTRAINT smart_home_protocol_spec_smart_home_protocol_name_key UNIQUE (smart_home_protocol_name);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: store_accessiblity store_accessiblity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_accessiblity
    ADD CONSTRAINT store_accessiblity_pkey PRIMARY KEY (id);


--
-- Name: store_complaint store_complaint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_complaint
    ADD CONSTRAINT store_complaint_pkey PRIMARY KEY (id);


--
-- Name: store_detail store_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_detail
    ADD CONSTRAINT store_detail_pkey PRIMARY KEY (id);


--
-- Name: store_fullfillment store_fullfillment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_fullfillment
    ADD CONSTRAINT store_fullfillment_pkey PRIMARY KEY (id);


--
-- Name: store_location store_location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_location
    ADD CONSTRAINT store_location_pkey PRIMARY KEY (id);


--
-- Name: store store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_pkey PRIMARY KEY (id);


--
-- Name: store_report store_report_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_report
    ADD CONSTRAINT store_report_pkey PRIMARY KEY (id);


--
-- Name: store_review store_review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review
    ADD CONSTRAINT store_review_pkey PRIMARY KEY (id);


--
-- Name: store_sanction store_sanction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_sanction
    ADD CONSTRAINT store_sanction_pkey PRIMARY KEY (id);


--
-- Name: style_spec style_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.style_spec
    ADD CONSTRAINT style_spec_pkey PRIMARY KEY (id);


--
-- Name: style_spec_product style_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.style_spec_product
    ADD CONSTRAINT style_spec_product_pkey PRIMARY KEY (id);


--
-- Name: style_spec style_spec_style_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.style_spec
    ADD CONSTRAINT style_spec_style_name_key UNIQUE (style_name);


--
-- Name: subscription_fee subscription_fee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_fee
    ADD CONSTRAINT subscription_fee_pkey PRIMARY KEY (id);


--
-- Name: support_agent support_agent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_agent
    ADD CONSTRAINT support_agent_pkey PRIMARY KEY (id);


--
-- Name: table_list table_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.table_list
    ADD CONSTRAINT table_list_pkey PRIMARY KEY (id);


--
-- Name: ticket_discount_code ticket_discount_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_discount_code
    ADD CONSTRAINT ticket_discount_code_pkey PRIMARY KEY (id);


--
-- Name: ticket_discount_code ticket_discount_code_ticket_discount_code_num_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_discount_code
    ADD CONSTRAINT ticket_discount_code_ticket_discount_code_num_key UNIQUE (ticket_discount_code_num);


--
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (id);


--
-- Name: ticket_promo_code ticket_promo_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_promo_code
    ADD CONSTRAINT ticket_promo_code_pkey PRIMARY KEY (id);


--
-- Name: ticket_promo_code ticket_promo_code_ticket_promo_code_num_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_promo_code
    ADD CONSTRAINT ticket_promo_code_ticket_promo_code_num_key UNIQUE (ticket_promo_code_num);


--
-- Name: ticket_type ticket_type_barcode_image_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_type
    ADD CONSTRAINT ticket_type_barcode_image_key UNIQUE (barcode_image);


--
-- Name: ticket_type ticket_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_type
    ADD CONSTRAINT ticket_type_pkey PRIMARY KEY (id);


--
-- Name: topping_price topping_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topping_price
    ADD CONSTRAINT topping_price_pkey PRIMARY KEY (id);


--
-- Name: ubo_business_affiliation ubo_business_affiliation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubo_business_affiliation
    ADD CONSTRAINT ubo_business_affiliation_pkey PRIMARY KEY (id);


--
-- Name: ubo_verification_document ubo_verification_document_document_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubo_verification_document
    ADD CONSTRAINT ubo_verification_document_document_number_key UNIQUE (document_number);


--
-- Name: ubo_verification_document ubo_verification_document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubo_verification_document
    ADD CONSTRAINT ubo_verification_document_pkey PRIMARY KEY (id);


--
-- Name: ubo_verification_document ubo_verification_document_tax_identification_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubo_verification_document
    ADD CONSTRAINT ubo_verification_document_tax_identification_number_key UNIQUE (tax_identification_number);


--
-- Name: upc upc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upc
    ADD CONSTRAINT upc_pkey PRIMARY KEY (id);


--
-- Name: upc upc_upc_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upc
    ADD CONSTRAINT upc_upc_code_key UNIQUE (upc_code);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user_event_category_like user_event_category_like_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_event_category_like
    ADD CONSTRAINT user_event_category_like_pkey PRIMARY KEY (id);


--
-- Name: user_permission_entity user_permission_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permission_entity
    ADD CONSTRAINT user_permission_entity_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: vehicle vehicle_license_plate_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_license_plate_key UNIQUE (license_plate);


--
-- Name: vehicle vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (id);


--
-- Name: venue venue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venue
    ADD CONSTRAINT venue_pkey PRIMARY KEY (id);


--
-- Name: voltage_spec voltage_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voltage_spec
    ADD CONSTRAINT voltage_spec_pkey PRIMARY KEY (id);


--
-- Name: voltage_spec_product voltage_spec_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voltage_spec_product
    ADD CONSTRAINT voltage_spec_product_pkey PRIMARY KEY (id);


--
-- Name: voltage_spec voltage_spec_voltage_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voltage_spec
    ADD CONSTRAINT voltage_spec_voltage_name_key UNIQUE (voltage_name);


--
-- Name: idx_brand_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_brand_name ON public.brand USING btree (id);


--
-- Name: idx_capacityid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_capacityid ON public.capacity_spec_product USING btree (id_capacity);


--
-- Name: idx_categories_name_lukup; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_categories_name_lukup ON public.lukup_category USING btree (name);


--
-- Name: idx_city_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_city_name ON public.city USING btree (city_name);


--
-- Name: idx_components_includedid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_components_includedid ON public.components_included_spec_product USING btree (id_components_included);


--
-- Name: idx_deli_status_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_deli_status_name ON public.delivery_status USING btree (dsname);


--
-- Name: idx_district_geom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_district_geom ON public.districts USING gist (geom_location);


--
-- Name: idx_district_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_district_name ON public.districts USING btree (district_name);


--
-- Name: idx_event_geom_location; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_geom_location ON public.event USING gist (geom_location);


--
-- Name: idx_event_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_name ON public.event USING btree (event_name);


--
-- Name: idx_featuresid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_featuresid ON public.features_spec_product USING btree (id_features);


--
-- Name: idx_finishid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_finishid ON public.finish_spec_product USING btree (id_finish);


--
-- Name: idx_food_compatibilityid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_food_compatibilityid ON public.food_compatibility_spec_product USING btree (id_food_compatibility);


--
-- Name: idx_geom_location; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_geom_location ON public.venue USING gist (geom_location);


--
-- Name: idx_geom_location_oda; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_geom_location_oda ON public.order_delivery_address USING gist (geom_location);


--
-- Name: idx_geom_location_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_geom_location_person ON public.delivery_person USING gist (geom_location);


--
-- Name: idx_geom_location_states; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_geom_location_states ON public.states USING gist (geom_location);


--
-- Name: idx_key_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_key_name ON public.search_key_inventory USING btree (key_name);


--
-- Name: idx_m_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_m_name ON public.payment_method USING btree (method_name);


--
-- Name: idx_materialid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_materialid ON public.material_spec_product USING btree (id_material);


--
-- Name: idx_num_of_doorid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_num_of_doorid ON public.num_of_door_spec_product USING btree (id_num_of_door);


--
-- Name: idx_num_of_drawerid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_num_of_drawerid ON public.num_of_drawer_spec_product USING btree (id_num_of_drawer);


--
-- Name: idx_num_of_shelveid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_num_of_shelveid ON public.num_of_shelve_spec_product USING btree (id_num_of_shelve);


--
-- Name: idx_power_source; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_power_source ON public.power_source_spec_product USING btree (id_power_source);


--
-- Name: idx_return_shipment_track_num; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_return_shipment_track_num ON public.refund USING btree (return_shipment_tracking_number);


--
-- Name: idx_return_tracking_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_return_tracking_number ON public.customer_return_request USING btree (return_tracking_number);


--
-- Name: idx_sales_header_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sales_header_uuid ON public.sales_header USING btree (sales_order_uuid);


--
-- Name: idx_seller_bmsname; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_seller_bmsname ON public.seller USING btree (bmsname);


--
-- Name: idx_smart_home_protocolid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_smart_home_protocolid ON public.smart_home_protocol_spec_product USING btree (id_smart_home_protocol);


--
-- Name: idx_state_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_state_name ON public.states USING btree (state_name);


--
-- Name: idx_store_loct_geom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_store_loct_geom ON public.store_location USING gist (geom_location);


--
-- Name: idx_store_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_store_name ON public.store USING btree (id);


--
-- Name: idx_styleid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_styleid ON public.style_spec_product USING btree (id_style);


--
-- Name: idx_ticke_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ticke_uuid ON public.ticket USING btree (ticket_uuid);


--
-- Name: idx_upc_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_upc_code ON public.upc USING btree (upc_code);


--
-- Name: idx_user_first_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_first_name ON public."user" USING btree (first_name);


--
-- Name: idx_user_geom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_geom ON public."user" USING gist (geom_location);


--
-- Name: idx_user_phone; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_phone ON public."user" USING btree (phone);


--
-- Name: idx_voltageid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_voltageid ON public.voltage_spec_product USING btree (id_voltage);


--
-- Name: add_to_watchlist add_to_watchlist_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.add_to_watchlist
    ADD CONSTRAINT add_to_watchlist_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: add_to_watchlist add_to_watchlist_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.add_to_watchlist
    ADD CONSTRAINT add_to_watchlist_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: auction auction_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auction
    ADD CONSTRAINT auction_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: auction auction_id_user_seller_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auction
    ADD CONSTRAINT auction_id_user_seller_fkey FOREIGN KEY (id_user_seller) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auction auction_id_user_winner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auction
    ADD CONSTRAINT auction_id_user_winner_fkey FOREIGN KEY (id_user_winner) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: authtoken_token authtoken_token_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id);


--
-- Name: auto_bid auto_bid_id_auction_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auto_bid
    ADD CONSTRAINT auto_bid_id_auction_fkey FOREIGN KEY (id_auction) REFERENCES public.auction(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auto_bid auto_bid_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auto_bid
    ADD CONSTRAINT auto_bid_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bid bid_id_auction_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bid
    ADD CONSTRAINT bid_id_auction_fkey FOREIGN KEY (id_auction) REFERENCES public.auction(id) ON UPDATE CASCADE;


--
-- Name: bid bid_id_user_bidder_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bid
    ADD CONSTRAINT bid_id_user_bidder_fkey FOREIGN KEY (id_user_bidder) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: billing_addresses billing_addresses_id_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing_addresses
    ADD CONSTRAINT billing_addresses_id_city_fkey FOREIGN KEY (id_city) REFERENCES public.city(id) ON UPDATE CASCADE;


--
-- Name: billing_addresses billing_addresses_id_customer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing_addresses
    ADD CONSTRAINT billing_addresses_id_customer_fkey FOREIGN KEY (id_customer) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: billing_addresses billing_addresses_id_district_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing_addresses
    ADD CONSTRAINT billing_addresses_id_district_fkey FOREIGN KEY (id_district) REFERENCES public.districts(id) ON UPDATE CASCADE;


--
-- Name: book_detail book_detail_id_book_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_detail
    ADD CONSTRAINT book_detail_id_book_inventory_fkey FOREIGN KEY (id_book_inventory) REFERENCES public.book_inventory(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: book_inventory book_inventory_id_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_inventory
    ADD CONSTRAINT book_inventory_id_author_fkey FOREIGN KEY (id_author) REFERENCES public.author(id) ON UPDATE CASCADE;


--
-- Name: book_inventory book_inventory_id_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_inventory
    ADD CONSTRAINT book_inventory_id_store_fkey FOREIGN KEY (id_store) REFERENCES public.store(id) ON UPDATE CASCADE;


--
-- Name: book_media book_media_id_book_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_media
    ADD CONSTRAINT book_media_id_book_inventory_fkey FOREIGN KEY (id_book_inventory) REFERENCES public.book_inventory(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: book_promo_code book_promo_code_id_book_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_promo_code
    ADD CONSTRAINT book_promo_code_id_book_inventory_fkey FOREIGN KEY (id_book_inventory) REFERENCES public.book_inventory(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: book_review book_review_id_book_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_review
    ADD CONSTRAINT book_review_id_book_fkey FOREIGN KEY (id_book) REFERENCES public.book_inventory(id) ON UPDATE CASCADE;


--
-- Name: book_review book_review_id_commenter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_review
    ADD CONSTRAINT book_review_id_commenter_fkey FOREIGN KEY (id_commenter) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: book_review book_review_id_parent_comment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_review
    ADD CONSTRAINT book_review_id_parent_comment_fkey FOREIGN KEY (id_parent_comment) REFERENCES public.book_review(id) ON UPDATE CASCADE;


--
-- Name: caching_expiry_setting caching_expiry_setting_id_caching_settings_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caching_expiry_setting
    ADD CONSTRAINT caching_expiry_setting_id_caching_settings_fkey FOREIGN KEY (id_caching_settings) REFERENCES public.caching_setting(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: caching_expiry_setting caching_expiry_setting_id_caching_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caching_expiry_setting
    ADD CONSTRAINT caching_expiry_setting_id_caching_type_fkey FOREIGN KEY (id_caching_type) REFERENCES public.caching_type(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: caching_setting caching_setting_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caching_setting
    ADD CONSTRAINT caching_setting_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: caching_settings_detail caching_settings_detail_id_caching_feature_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caching_settings_detail
    ADD CONSTRAINT caching_settings_detail_id_caching_feature_fkey FOREIGN KEY (id_caching_feature) REFERENCES public.caching_feature(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: caching_settings_detail caching_settings_detail_id_caching_setting_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caching_settings_detail
    ADD CONSTRAINT caching_settings_detail_id_caching_setting_fkey FOREIGN KEY (id_caching_setting) REFERENCES public.caching_setting(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: caching_settings_detail caching_settings_detail_id_caching_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caching_settings_detail
    ADD CONSTRAINT caching_settings_detail_id_caching_type_fkey FOREIGN KEY (id_caching_type) REFERENCES public.caching_type(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: capacity_spec_product capacity_spec_product_id_capacity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capacity_spec_product
    ADD CONSTRAINT capacity_spec_product_id_capacity_fkey FOREIGN KEY (id_capacity) REFERENCES public.capacity_spec(id) ON UPDATE CASCADE;


--
-- Name: capacity_spec_product capacity_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capacity_spec_product
    ADD CONSTRAINT capacity_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cart cart_id_customer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_id_customer_fkey FOREIGN KEY (id_customer) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: chat_media_store chat_media_store_id_media_url_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_media_store
    ADD CONSTRAINT chat_media_store_id_media_url_fkey FOREIGN KEY (id_media_url) REFERENCES public.media_url(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: chat_media_store chat_media_store_id_sender_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_media_store
    ADD CONSTRAINT chat_media_store_id_sender_fkey FOREIGN KEY (id_sender) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: chat_room chat_room_id_creator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_room
    ADD CONSTRAINT chat_room_id_creator_fkey FOREIGN KEY (id_creator) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: chat_room_media chat_room_media_id_chat_media_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_room_media
    ADD CONSTRAINT chat_room_media_id_chat_media_store_fkey FOREIGN KEY (id_chat_media_store) REFERENCES public.chat_media_store(id) ON UPDATE CASCADE;


--
-- Name: chat_room_media chat_room_media_id_chat_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_room_media
    ADD CONSTRAINT chat_room_media_id_chat_room_fkey FOREIGN KEY (id_chat_room) REFERENCES public.chat_room(id) ON UPDATE CASCADE;


--
-- Name: chat_single chat_single_id_chat_media_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_single
    ADD CONSTRAINT chat_single_id_chat_media_store_fkey FOREIGN KEY (id_chat_media_store) REFERENCES public.chat_media_store(id) ON UPDATE CASCADE;


--
-- Name: chat_single chat_single_id_receiver_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_single
    ADD CONSTRAINT chat_single_id_receiver_fkey FOREIGN KEY (id_receiver) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: city city_id_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_id_country_fkey FOREIGN KEY (id_country) REFERENCES public.country(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: city city_id_state_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_id_state_fkey FOREIGN KEY (id_state) REFERENCES public.states(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: clerks clerks_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clerks
    ADD CONSTRAINT clerks_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: clerks clerks_id_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clerks
    ADD CONSTRAINT clerks_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.roles(id);


--
-- Name: clerks clerks_id_storelocation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clerks
    ADD CONSTRAINT clerks_id_storelocation_fkey FOREIGN KEY (id_storelocation) REFERENCES public.store_location(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: clerks clerks_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clerks
    ADD CONSTRAINT clerks_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: common_specification common_specification_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.common_specification
    ADD CONSTRAINT common_specification_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: complaint complaint_id_complaint_reason_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complaint
    ADD CONSTRAINT complaint_id_complaint_reason_fkey FOREIGN KEY (id_complaint_reason) REFERENCES public.lukup_complaint_reason(id) ON UPDATE CASCADE;


--
-- Name: complaint complaint_id_customer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complaint
    ADD CONSTRAINT complaint_id_customer_fkey FOREIGN KEY (id_customer) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: components_included_spec_product components_included_spec_product_id_components_included_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components_included_spec_product
    ADD CONSTRAINT components_included_spec_product_id_components_included_fkey FOREIGN KEY (id_components_included) REFERENCES public.components_included_spec(id) ON UPDATE CASCADE;


--
-- Name: components_included_spec_product components_included_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components_included_spec_product
    ADD CONSTRAINT components_included_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: customer_return_request customer_return_request_id_customer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_return_request
    ADD CONSTRAINT customer_return_request_id_customer_fkey FOREIGN KEY (id_customer) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_return_request customer_return_request_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_return_request
    ADD CONSTRAINT customer_return_request_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_return_request customer_return_request_id_order_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_return_request
    ADD CONSTRAINT customer_return_request_id_order_fkey FOREIGN KEY (id_order) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_return_request customer_return_request_id_return_reason_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_return_request
    ADD CONSTRAINT customer_return_request_id_return_reason_fkey FOREIGN KEY (id_return_reason) REFERENCES public.lukup_return_reason(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_service_request customer_service_request_id_service_request_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_service_request
    ADD CONSTRAINT customer_service_request_id_service_request_fkey FOREIGN KEY (id_service_request) REFERENCES public.service_request(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: customer_service_request customer_service_request_id_service_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_service_request
    ADD CONSTRAINT customer_service_request_id_service_type_fkey FOREIGN KEY (id_service_type) REFERENCES public.lukup_service_type(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: delivery_person delivery_person_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_person
    ADD CONSTRAINT delivery_person_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: delivery_person delivery_person_id_vehicle_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_person
    ADD CONSTRAINT delivery_person_id_vehicle_fkey FOREIGN KEY (id_vehicle) REFERENCES public.vehicle(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: delivery_person_review delivery_person_review_id_commenter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_person_review
    ADD CONSTRAINT delivery_person_review_id_commenter_fkey FOREIGN KEY (id_commenter) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: delivery_person_review delivery_person_review_id_delivery_person_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_person_review
    ADD CONSTRAINT delivery_person_review_id_delivery_person_fkey FOREIGN KEY (id_delivery_person) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: delivery_person_review delivery_person_review_id_parent_comment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_person_review
    ADD CONSTRAINT delivery_person_review_id_parent_comment_fkey FOREIGN KEY (id_parent_comment) REFERENCES public.delivery_person_review(id) ON UPDATE CASCADE;


--
-- Name: dish_drink_and_extra dish_drink_and_extra_id_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish_drink_and_extra
    ADD CONSTRAINT dish_drink_and_extra_id_category_fkey FOREIGN KEY (id_category) REFERENCES public.lukup_restauranct_cafe_category(id);


--
-- Name: dish_drink_and_extra dish_drink_and_extra_id_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish_drink_and_extra
    ADD CONSTRAINT dish_drink_and_extra_id_product_fkey FOREIGN KEY (id_product) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dish_drink_and_extra dish_drink_and_extra_id_restaurant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish_drink_and_extra
    ADD CONSTRAINT dish_drink_and_extra_id_restaurant_fkey FOREIGN KEY (id_restaurant) REFERENCES public.restaurant_cafe(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dish_meal dish_meal_id_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish_meal
    ADD CONSTRAINT dish_meal_id_category_fkey FOREIGN KEY (id_category) REFERENCES public.lukup_restauranct_cafe_category(id);


--
-- Name: dish_meal dish_meal_id_restaurant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish_meal
    ADD CONSTRAINT dish_meal_id_restaurant_fkey FOREIGN KEY (id_restaurant) REFERENCES public.restaurant_cafe(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dish_rating dish_rating_id_dish_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish_rating
    ADD CONSTRAINT dish_rating_id_dish_fkey FOREIGN KEY (id_dish) REFERENCES public.dish_meal(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: districts districts_id_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_id_city_fkey FOREIGN KEY (id_city) REFERENCES public.city(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: driver_complaint driver_complaint_id_complaint_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_complaint
    ADD CONSTRAINT driver_complaint_id_complaint_fkey FOREIGN KEY (id_complaint) REFERENCES public.complaint(id) ON UPDATE CASCADE;


--
-- Name: driver_complaint driver_complaint_id_driver_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_complaint
    ADD CONSTRAINT driver_complaint_id_driver_fkey FOREIGN KEY (id_driver) REFERENCES public.delivery_person(id) ON UPDATE CASCADE;


--
-- Name: event_activity_type event_activity_type_id_event_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_activity_type
    ADD CONSTRAINT event_activity_type_id_event_fkey FOREIGN KEY (id_event) REFERENCES public.event(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_activity_type event_activity_type_id_lukup_event_act_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_activity_type
    ADD CONSTRAINT event_activity_type_id_lukup_event_act_type_fkey FOREIGN KEY (id_lukup_event_act_type) REFERENCES public.event_activity_type(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_follower event_follower_id_event_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_follower
    ADD CONSTRAINT event_follower_id_event_fkey FOREIGN KEY (id_event) REFERENCES public.event(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_follower event_follower_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_follower
    ADD CONSTRAINT event_follower_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event event_id_event_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_id_event_category_fkey FOREIGN KEY (id_event_category) REFERENCES public.lukup_event_category(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event event_id_organizer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_id_organizer_fkey FOREIGN KEY (id_organizer) REFERENCES public.organizer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_media event_media_id_event_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_media
    ADD CONSTRAINT event_media_id_event_fkey FOREIGN KEY (id_event) REFERENCES public.event(id) ON UPDATE CASCADE;


--
-- Name: event_media event_media_id_media_url_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_media
    ADD CONSTRAINT event_media_id_media_url_fkey FOREIGN KEY (id_media_url) REFERENCES public.media_url(id) ON UPDATE CASCADE;


--
-- Name: event_staff event_staff_id_roles_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_staff
    ADD CONSTRAINT event_staff_id_roles_fkey FOREIGN KEY (id_roles) REFERENCES public.roles(id) ON UPDATE CASCADE;


--
-- Name: event_staff event_staff_id_staff_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_staff
    ADD CONSTRAINT event_staff_id_staff_fkey FOREIGN KEY (id_staff) REFERENCES public.event(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_tags event_tags_id_event_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags
    ADD CONSTRAINT event_tags_id_event_fkey FOREIGN KEY (id_event) REFERENCES public.event(id) ON UPDATE CASCADE;


--
-- Name: favorite_store favorite_store_id_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorite_store
    ADD CONSTRAINT favorite_store_id_store_fkey FOREIGN KEY (id_store) REFERENCES public.store(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: favorite_store favorite_store_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorite_store
    ADD CONSTRAINT favorite_store_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: features_spec_product features_spec_product_id_features_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features_spec_product
    ADD CONSTRAINT features_spec_product_id_features_fkey FOREIGN KEY (id_features) REFERENCES public.features_spec(id) ON UPDATE CASCADE;


--
-- Name: features_spec_product features_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features_spec_product
    ADD CONSTRAINT features_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: finish_spec_product finish_spec_product_id_finish_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finish_spec_product
    ADD CONSTRAINT finish_spec_product_id_finish_fkey FOREIGN KEY (id_finish) REFERENCES public.finish_spec(id) ON UPDATE CASCADE;


--
-- Name: finish_spec_product finish_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finish_spec_product
    ADD CONSTRAINT finish_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: food_compatibility_spec_product food_compatibility_spec_product_id_food_compatibility_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_compatibility_spec_product
    ADD CONSTRAINT food_compatibility_spec_product_id_food_compatibility_fkey FOREIGN KEY (id_food_compatibility) REFERENCES public.food_compatibility_spec(id) ON UPDATE CASCADE;


--
-- Name: food_compatibility_spec_product food_compatibility_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_compatibility_spec_product
    ADD CONSTRAINT food_compatibility_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: grouprole grouprole_id_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grouprole
    ADD CONSTRAINT grouprole_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: grouprole grouprole_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grouprole
    ADD CONSTRAINT grouprole_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id);


--
-- Name: inventory_bulletlist inventory_bulletlist_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_bulletlist
    ADD CONSTRAINT inventory_bulletlist_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory inventory_id_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_id_brand_fkey FOREIGN KEY (id_brand) REFERENCES public.brand(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: inventory inventory_id_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_id_product_fkey FOREIGN KEY (id_product) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: inventory inventory_id_storelocation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_id_storelocation_fkey FOREIGN KEY (id_storelocation) REFERENCES public.store_location(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: latest_deal latest_deal_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.latest_deal
    ADD CONSTRAINT latest_deal_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: latest_deal latest_deal_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.latest_deal
    ADD CONSTRAINT latest_deal_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lukup_category lukup_category_id_parent_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_category
    ADD CONSTRAINT lukup_category_id_parent_category_fkey FOREIGN KEY (id_parent_category) REFERENCES public.lukup_category(id) ON UPDATE CASCADE;


--
-- Name: lukup_category_specification lukup_category_specification_id_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_category_specification
    ADD CONSTRAINT lukup_category_specification_id_category_fkey FOREIGN KEY (id_category) REFERENCES public.lukup_category(id) ON UPDATE CASCADE;


--
-- Name: lukup_category_specification lukup_category_specification_id_spec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_category_specification
    ADD CONSTRAINT lukup_category_specification_id_spec_fkey FOREIGN KEY (id_spec) REFERENCES public.lukup_specification(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lukup_complaint_reason lukup_complaint_reason_id_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_complaint_reason
    ADD CONSTRAINT lukup_complaint_reason_id_category_fkey FOREIGN KEY (id_category) REFERENCES public.lukup_complaint_category(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lukup_event_category lukup_event_category_id_parent_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_event_category
    ADD CONSTRAINT lukup_event_category_id_parent_category_fkey FOREIGN KEY (id_parent_category) REFERENCES public.lukup_event_category(id) ON UPDATE CASCADE;


--
-- Name: lukup_product_specification lukup_product_specification_id_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_product_specification
    ADD CONSTRAINT lukup_product_specification_id_product_fkey FOREIGN KEY (id_product) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: lukup_product_specification lukup_product_specification_id_spec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_product_specification
    ADD CONSTRAINT lukup_product_specification_id_spec_fkey FOREIGN KEY (id_spec) REFERENCES public.lukup_specification(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lukup_restauranct_cafe_category lukup_restauranct_cafe_category_id_parent_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lukup_restauranct_cafe_category
    ADD CONSTRAINT lukup_restauranct_cafe_category_id_parent_category_fkey FOREIGN KEY (id_parent_category) REFERENCES public.lukup_restauranct_cafe_category(id);


--
-- Name: material_spec_product material_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_spec_product
    ADD CONSTRAINT material_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: material_spec_product material_spec_product_id_material_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_spec_product
    ADD CONSTRAINT material_spec_product_id_material_fkey FOREIGN KEY (id_material) REFERENCES public.material_spec(id) ON UPDATE CASCADE;


--
-- Name: media_store media_store_id_media_url_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_store
    ADD CONSTRAINT media_store_id_media_url_fkey FOREIGN KEY (id_media_url) REFERENCES public.media_url(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: media_store media_store_id_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_store
    ADD CONSTRAINT media_store_id_store_fkey FOREIGN KEY (id_store) REFERENCES public.store(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: media_url media_url_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_url
    ADD CONSTRAINT media_url_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: media_user media_user_id_media_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_user
    ADD CONSTRAINT media_user_id_media_fkey FOREIGN KEY (id_media) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: media_user media_user_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_user
    ADD CONSTRAINT media_user_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.media_url(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: message_text message_text_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_text
    ADD CONSTRAINT message_text_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: num_of_door_spec_product num_of_door_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.num_of_door_spec_product
    ADD CONSTRAINT num_of_door_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: num_of_door_spec_product num_of_door_spec_product_id_num_of_door_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.num_of_door_spec_product
    ADD CONSTRAINT num_of_door_spec_product_id_num_of_door_fkey FOREIGN KEY (id_num_of_door) REFERENCES public.num_of_door_spec(id) ON UPDATE CASCADE;


--
-- Name: num_of_drawer_spec_product num_of_drawer_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.num_of_drawer_spec_product
    ADD CONSTRAINT num_of_drawer_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: num_of_drawer_spec_product num_of_drawer_spec_product_id_num_of_drawer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.num_of_drawer_spec_product
    ADD CONSTRAINT num_of_drawer_spec_product_id_num_of_drawer_fkey FOREIGN KEY (id_num_of_drawer) REFERENCES public.num_of_drawer_spec(id) ON UPDATE CASCADE;


--
-- Name: num_of_shelve_spec_product num_of_shelve_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.num_of_shelve_spec_product
    ADD CONSTRAINT num_of_shelve_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: num_of_shelve_spec_product num_of_shelve_spec_product_id_num_of_shelve_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.num_of_shelve_spec_product
    ADD CONSTRAINT num_of_shelve_spec_product_id_num_of_shelve_fkey FOREIGN KEY (id_num_of_shelve) REFERENCES public.num_of_shelve_spec(id) ON UPDATE CASCADE;


--
-- Name: offer offer_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offer
    ADD CONSTRAINT offer_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: offer offer_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offer
    ADD CONSTRAINT offer_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: order_delivery_address order_delivery_address_id_order_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_delivery_address
    ADD CONSTRAINT order_delivery_address_id_order_fkey FOREIGN KEY (id_order) REFERENCES public."order"(id);


--
-- Name: order order_id_customer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_id_customer_fkey FOREIGN KEY (id_customer) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order order_id_fullfillment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_id_fullfillment_fkey FOREIGN KEY (id_fullfillment) REFERENCES public.fullfillment_type(id) ON UPDATE CASCADE;


--
-- Name: order order_id_payment_method_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_id_payment_method_fkey FOREIGN KEY (id_payment_method) REFERENCES public.payment_method(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: order order_id_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_id_status_fkey FOREIGN KEY (id_status) REFERENCES public.order_status(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: order_item order_item_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: order_item order_item_id_order_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_id_order_fkey FOREIGN KEY (id_order) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: organizer_follower organizer_follower_id_organizer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizer_follower
    ADD CONSTRAINT organizer_follower_id_organizer_fkey FOREIGN KEY (id_organizer) REFERENCES public.event(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: organizer_follower organizer_follower_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizer_follower
    ADD CONSTRAINT organizer_follower_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: organizer organizer_id_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizer
    ADD CONSTRAINT organizer_id_city_fkey FOREIGN KEY (id_city) REFERENCES public.city(id) ON UPDATE CASCADE;


--
-- Name: organizer organizer_id_state_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizer
    ADD CONSTRAINT organizer_id_state_fkey FOREIGN KEY (id_state) REFERENCES public.states(id) ON UPDATE CASCADE;


--
-- Name: other_complaint other_complaint_id_complaint_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.other_complaint
    ADD CONSTRAINT other_complaint_id_complaint_fkey FOREIGN KEY (id_complaint) REFERENCES public.complaint(id) ON UPDATE CASCADE;


--
-- Name: power_source_spec_product power_source_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.power_source_spec_product
    ADD CONSTRAINT power_source_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: power_source_spec_product power_source_spec_product_id_power_source_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.power_source_spec_product
    ADD CONSTRAINT power_source_spec_product_id_power_source_fkey FOREIGN KEY (id_power_source) REFERENCES public.power_source_spec(id) ON UPDATE CASCADE;


--
-- Name: prime_service prime_service_id_service_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prime_service
    ADD CONSTRAINT prime_service_id_service_type_fkey FOREIGN KEY (id_service_type) REFERENCES public.lukup_service_type(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: prime_service_user prime_service_user_id_prime_service_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prime_service_user
    ADD CONSTRAINT prime_service_user_id_prime_service_fkey FOREIGN KEY (id_prime_service) REFERENCES public.prime_service(id) ON UPDATE CASCADE;


--
-- Name: prime_service_user prime_service_user_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prime_service_user
    ADD CONSTRAINT prime_service_user_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: proc_lukup_event_category proc_lukup_event_category_id_parent_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proc_lukup_event_category
    ADD CONSTRAINT proc_lukup_event_category_id_parent_category_fkey FOREIGN KEY (id_parent_category) REFERENCES public.lukup_event_category(id) ON UPDATE CASCADE;


--
-- Name: product_complaint product_complaint_id_complaint_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_complaint
    ADD CONSTRAINT product_complaint_id_complaint_fkey FOREIGN KEY (id_complaint) REFERENCES public.complaint(id) ON UPDATE CASCADE;


--
-- Name: product_complaint product_complaint_id_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_complaint
    ADD CONSTRAINT product_complaint_id_product_fkey FOREIGN KEY (id_product) REFERENCES public.inventory(id) ON UPDATE CASCADE;


--
-- Name: product_sanction product_sanction_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_sanction
    ADD CONSTRAINT product_sanction_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_sanction product_sanction_id_sanction_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_sanction
    ADD CONSTRAINT product_sanction_id_sanction_fkey FOREIGN KEY (id_sanction) REFERENCES public.regulatory_sanction(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: refund refund_id_order_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT refund_id_order_fkey FOREIGN KEY (id_order) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: refund refund_id_refund_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT refund_id_refund_fkey FOREIGN KEY (id_refund) REFERENCES public.return_reason(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: regulatory_sanction regulatory_sanction_id_sanctioning_authority_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regulatory_sanction
    ADD CONSTRAINT regulatory_sanction_id_sanctioning_authority_fkey FOREIGN KEY (id_sanctioning_authority) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: report report_id_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_id_created_by_fkey FOREIGN KEY (id_created_by) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: restaurant_cafe restaurant_cafe_id_cuisine_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurant_cafe
    ADD CONSTRAINT restaurant_cafe_id_cuisine_type_fkey FOREIGN KEY (id_cuisine_type) REFERENCES public.cuisine_type(id) ON UPDATE CASCADE;


--
-- Name: restaurant_cafe restaurant_cafe_id_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurant_cafe
    ADD CONSTRAINT restaurant_cafe_id_store_fkey FOREIGN KEY (id_store) REFERENCES public.store(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sales_header sales_header_id_customer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_header
    ADD CONSTRAINT sales_header_id_customer_fkey FOREIGN KEY (id_customer) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sales_header sales_header_id_sale_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_header
    ADD CONSTRAINT sales_header_id_sale_user_fkey FOREIGN KEY (id_sale_user) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: sales_header sales_header_id_ship_to_address_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_header
    ADD CONSTRAINT sales_header_id_ship_to_address_fkey FOREIGN KEY (id_ship_to_address) REFERENCES public.shipping_address(id) ON UPDATE CASCADE;


--
-- Name: sauce_price sauce_price_id_restaurant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sauce_price
    ADD CONSTRAINT sauce_price_id_restaurant_fkey FOREIGN KEY (id_restaurant) REFERENCES public.restaurant_cafe(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sauce_price sauce_price_id_sauce_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sauce_price
    ADD CONSTRAINT sauce_price_id_sauce_fkey FOREIGN KEY (id_sauce) REFERENCES public.lukup_sauce(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: saved_store saved_store_id_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_store
    ADD CONSTRAINT saved_store_id_store_fkey FOREIGN KEY (id_store) REFERENCES public.store(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: saved_store saved_store_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_store
    ADD CONSTRAINT saved_store_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: search_key_inventory search_key_inventory_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.search_key_inventory
    ADD CONSTRAINT search_key_inventory_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id);


--
-- Name: securitysettings securitysettings_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.securitysettings
    ADD CONSTRAINT securitysettings_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: seller seller_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller
    ADD CONSTRAINT seller_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: service_request service_request_id_customer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_request
    ADD CONSTRAINT service_request_id_customer_fkey FOREIGN KEY (id_customer) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: service_request service_request_id_order_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_request
    ADD CONSTRAINT service_request_id_order_fkey FOREIGN KEY (id_order) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: session session_id_event_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_id_event_fkey FOREIGN KEY (id_event) REFERENCES public.event(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_address shipping_address_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_address
    ADD CONSTRAINT shipping_address_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_address shipping_address_id_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_address
    ADD CONSTRAINT shipping_address_id_city_fkey FOREIGN KEY (id_city) REFERENCES public.city(id) ON UPDATE CASCADE;


--
-- Name: shipping_address shipping_address_id_state_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_address
    ADD CONSTRAINT shipping_address_id_state_fkey FOREIGN KEY (id_state) REFERENCES public.states(id) ON UPDATE CASCADE;


--
-- Name: smart_home_protocol_spec_product smart_home_protocol_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_home_protocol_spec_product
    ADD CONSTRAINT smart_home_protocol_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: smart_home_protocol_spec_product smart_home_protocol_spec_product_id_smart_home_protocol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_home_protocol_spec_product
    ADD CONSTRAINT smart_home_protocol_spec_product_id_smart_home_protocol_fkey FOREIGN KEY (id_smart_home_protocol) REFERENCES public.smart_home_protocol_spec(id) ON UPDATE CASCADE;


--
-- Name: states states_id_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_id_country_fkey FOREIGN KEY (id_country) REFERENCES public.country(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: store_accessiblity store_accessiblity_id_store_location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_accessiblity
    ADD CONSTRAINT store_accessiblity_id_store_location_fkey FOREIGN KEY (id_store_location) REFERENCES public.store_location(id);


--
-- Name: store_complaint store_complaint_id_complaint_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_complaint
    ADD CONSTRAINT store_complaint_id_complaint_fkey FOREIGN KEY (id_complaint) REFERENCES public.complaint(id) ON UPDATE CASCADE;


--
-- Name: store_complaint store_complaint_id_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_complaint
    ADD CONSTRAINT store_complaint_id_store_fkey FOREIGN KEY (id_store) REFERENCES public.store(id) ON UPDATE CASCADE;


--
-- Name: store_detail store_detail_id_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_detail
    ADD CONSTRAINT store_detail_id_store_fkey FOREIGN KEY (id_store) REFERENCES public.store(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: store_detail store_detail_id_store_location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_detail
    ADD CONSTRAINT store_detail_id_store_location_fkey FOREIGN KEY (id_store_location) REFERENCES public.store_location(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: store_fullfillment store_fullfillment_id_fullfillment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_fullfillment
    ADD CONSTRAINT store_fullfillment_id_fullfillment_fkey FOREIGN KEY (id_fullfillment) REFERENCES public.fullfillment_type(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: store_fullfillment store_fullfillment_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_fullfillment
    ADD CONSTRAINT store_fullfillment_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: store_location store_location_id_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_location
    ADD CONSTRAINT store_location_id_city_fkey FOREIGN KEY (id_city) REFERENCES public.city(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: store_location store_location_id_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_location
    ADD CONSTRAINT store_location_id_store_fkey FOREIGN KEY (id_store) REFERENCES public.store(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: store_review store_review_id_commenter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review
    ADD CONSTRAINT store_review_id_commenter_fkey FOREIGN KEY (id_commenter) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: store_review store_review_id_parent_comment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review
    ADD CONSTRAINT store_review_id_parent_comment_fkey FOREIGN KEY (id_parent_comment) REFERENCES public.store_review(id) ON UPDATE CASCADE;


--
-- Name: store_review store_review_id_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review
    ADD CONSTRAINT store_review_id_store_fkey FOREIGN KEY (id_store) REFERENCES public.store(id) ON UPDATE CASCADE;


--
-- Name: store_sanction store_sanction_id_sanction_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_sanction
    ADD CONSTRAINT store_sanction_id_sanction_fkey FOREIGN KEY (id_sanction) REFERENCES public.regulatory_sanction(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: store_sanction store_sanction_id_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_sanction
    ADD CONSTRAINT store_sanction_id_store_fkey FOREIGN KEY (id_store) REFERENCES public.store(id) ON UPDATE CASCADE;


--
-- Name: style_spec_product style_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.style_spec_product
    ADD CONSTRAINT style_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: style_spec_product style_spec_product_id_style_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.style_spec_product
    ADD CONSTRAINT style_spec_product_id_style_fkey FOREIGN KEY (id_style) REFERENCES public.style_spec(id) ON UPDATE CASCADE;


--
-- Name: subscription_fee subscription_fee_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_fee
    ADD CONSTRAINT subscription_fee_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: support_agent support_agent_id_authtoken_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_agent
    ADD CONSTRAINT support_agent_id_authtoken_fkey FOREIGN KEY (id_authtoken) REFERENCES public.authtoken_token(id) ON UPDATE CASCADE;


--
-- Name: support_agent support_agent_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_agent
    ADD CONSTRAINT support_agent_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: ticket ticket_id_event_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_id_event_fkey FOREIGN KEY (id_event) REFERENCES public.event(id) ON DELETE CASCADE;


--
-- Name: ticket_promo_code ticket_promo_code_id_ticket_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_promo_code
    ADD CONSTRAINT ticket_promo_code_id_ticket_fkey FOREIGN KEY (id_ticket) REFERENCES public.ticket(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ticket_type ticket_type_id_event_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_type
    ADD CONSTRAINT ticket_type_id_event_fkey FOREIGN KEY (id_event) REFERENCES public.event(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: topping_price topping_price_id_restaurant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topping_price
    ADD CONSTRAINT topping_price_id_restaurant_fkey FOREIGN KEY (id_restaurant) REFERENCES public.restaurant_cafe(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: topping_price topping_price_id_topping_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topping_price
    ADD CONSTRAINT topping_price_id_topping_fkey FOREIGN KEY (id_topping) REFERENCES public.lukup_topping(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ubo_business_affiliation ubo_business_affiliation_id_ubo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubo_business_affiliation
    ADD CONSTRAINT ubo_business_affiliation_id_ubo_fkey FOREIGN KEY (id_ubo) REFERENCES public.ubo_verification_document(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ubo_business_affiliation ubo_business_affiliation_id_verifier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubo_business_affiliation
    ADD CONSTRAINT ubo_business_affiliation_id_verifier_fkey FOREIGN KEY (id_verifier) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ubo_verification_document ubo_verification_document_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubo_verification_document
    ADD CONSTRAINT ubo_verification_document_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: ubo_verification_document ubo_verification_document_id_verifier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubo_verification_document
    ADD CONSTRAINT ubo_verification_document_id_verifier_fkey FOREIGN KEY (id_verifier) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: upc upc_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upc
    ADD CONSTRAINT upc_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: user_event_category_like user_event_category_like_id_event_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_event_category_like
    ADD CONSTRAINT user_event_category_like_id_event_fkey FOREIGN KEY (id_event) REFERENCES public.event(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_event_category_like user_event_category_like_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_event_category_like
    ADD CONSTRAINT user_event_category_like_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user user_id_district_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_id_district_fkey FOREIGN KEY (id_district) REFERENCES public.districts(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: user user_id_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: user_permission_entity user_permission_entity_id_table_list_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permission_entity
    ADD CONSTRAINT user_permission_entity_id_table_list_fkey FOREIGN KEY (id_table_list) REFERENCES public.table_list(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_permission_entity user_permission_entity_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permission_entity
    ADD CONSTRAINT user_permission_entity_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: vehicle vehicle_id_color_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_id_color_fkey FOREIGN KEY (id_color) REFERENCES public.color_spec(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: vehicle vehicle_id_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_id_owner_fkey FOREIGN KEY (id_owner) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: voltage_spec_product voltage_spec_product_id_inventory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voltage_spec_product
    ADD CONSTRAINT voltage_spec_product_id_inventory_fkey FOREIGN KEY (id_inventory) REFERENCES public.inventory(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: voltage_spec_product voltage_spec_product_id_voltage_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voltage_spec_product
    ADD CONSTRAINT voltage_spec_product_id_voltage_fkey FOREIGN KEY (id_voltage) REFERENCES public.voltage_spec(id) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--

