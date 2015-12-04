--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.4.4
-- Started on 2015-11-29 13:42:04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 200 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2192 (class 0 OID 0)
-- Dependencies: 200
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 213 (class 1255 OID 458624)
-- Name: get_day_order(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_day_order() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 DECLARE lastDate VARCHAR;
 DECLARE currDate VARCHAR;
 DECLARE configKey VARCHAR;
 DECLARE nextseqval character varying;
    BEGIN
     SELECT 'system.day.order' INTO configKey;
 
     SELECT value INTO lastDate
     FROM system_config_parameter
        WHERE key = configKey;
 
        SELECT to_char(now(), 'YYYY-MM-DD') INTO currDate;
 
        IF lastDate IS NULL OR lastDate <> currDate THEN
         IF lastDate IS NULL THEN
       INSERT INTO system_config_parameter VALUES (configKey, currDate);
      ELSE
       UPDATE system_config_parameter SET value = currDate WHERE key = configKey;
         END IF;
         ALTER SEQUENCE corder_day_order_sequence RESTART;
        END IF;
        select NEXTVAL('corder_day_order_sequence')::text into nextseqval;
        if(length(nextseqval)=1) then
   nextseqval:='000'||nextseqval;
        elsif(length(nextseqval)=2) then
   nextseqval:='00'||nextseqval;
        elsif(length(nextseqval)=3) then
   nextseqval:='0'||nextseqval;       
        end if;
        RETURN currDate ||'-'|| nextseqval;
    END;
$$;


ALTER FUNCTION public.get_day_order() OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 458625)
-- Name: insert_orderno_trig_fun(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION insert_orderno_trig_fun() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
   NEW.bill_no=get_day_order();
            RETURN NEW;
        END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.insert_orderno_trig_fun() OWNER TO postgres;

--
-- TOC entry 215 (class 1255 OID 458626)
-- Name: prod_det_before_updt_tri_fun(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION prod_det_before_updt_tri_fun() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
ctr integer;
BEGIN
	if(TG_OP='UPDATE') then
		select count(id) into ctr from stock_deatils where product_master_id=NEW.product_master_id and type=NEW.type;
		if(ctr>0) then
			update stock_deatils set quantity=coalesce(quantity,0)-coalesce(OLD.quantity,0),weight=coalesce(weight,0)-coalesce(OLD.weight,0) where product_master_id=OLD.product_master_id and type=OLD.type;
			update stock_deatils set quantity=coalesce(quantity,0)+coalesce(NEW.quantity,0),weight=coalesce(weight,0)+coalesce(NEW.weight,0) where product_master_id=NEW.product_master_id and type=NEW.type;
		else
			insert into stock_deatils (id,product_code,product_name,quantity,weight,product_master_id,branch_id,k_and_p,type) values (nextval('stock_deatils_seqs'),(select product_code from product_master where id=NEW.product_master_id),(select product_name from product_master where id=NEW.product_master_id),NEW.quantity,NEW.weight,NEW.product_master_id,NEW.branch_id,NEW.k_and_p,NEW.type);
		end if;
	end if;
return NEW;
END;
$$;


ALTER FUNCTION public.prod_det_before_updt_tri_fun() OWNER TO postgres;

--
-- TOC entry 216 (class 1255 OID 458627)
-- Name: product_det_aftins_tri_fun(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION product_det_aftins_tri_fun() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
ctr integer;
BEGIN
	if(TG_OP='INSERT') then
		select count(id) into ctr from stock_deatils where product_master_id=NEW.product_master_id and type=NEW.type;
		if(ctr>0) then
			update stock_deatils set quantity=coalesce(quantity,0)+coalesce(NEW.quantity,0),weight=coalesce(weight,0)+coalesce(NEW.weight,0) where product_master_id=NEW.product_master_id and type=NEW.type;
		else
			insert into stock_deatils (id,product_code,product_name,quantity,weight,product_master_id,branch_id,k_and_p,type) values (nextval('stock_deatils_seqs'),(select product_code from product_master where id=NEW.product_master_id),(select product_name from product_master where id=NEW.product_master_id),NEW.quantity,NEW.weight,NEW.product_master_id,NEW.branch_id,NEW.k_and_p,NEW.type);
		end if;
	end if;
return NEW;
END;
$$;


ALTER FUNCTION public.product_det_aftins_tri_fun() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 172 (class 1259 OID 458628)
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE branch (
    id integer NOT NULL,
    branch_name character varying(128) NOT NULL,
    branch_code character varying(128),
    branch_city character varying(128),
    branch_pin character varying(128),
    branch_phone character varying(128),
    branch_email character varying(128),
    vat_no character varying(128),
    address_line1 character varying(256),
    address_line2 character varying(256)
);


ALTER TABLE branch OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 458634)
-- Name: branch_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE branch_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE branch_seqs OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 458636)
-- Name: corder_day_order_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE corder_day_order_sequence
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE corder_day_order_sequence OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 458638)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE customer (
    id integer NOT NULL,
    customer_name character varying(128) NOT NULL,
    address character varying(128),
    city character varying(128),
    pin character varying(128),
    phone character varying(128),
    email character varying(128),
    vat_no character varying(128)
);


ALTER TABLE customer OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 458644)
-- Name: customer_payment_info; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE customer_payment_info (
    id integer NOT NULL,
    sales_master_id integer,
    total_bill_amount numeric(14,4),
    pay numeric(14,4) DEFAULT 0 NOT NULL,
    due_amount numeric(14,4) DEFAULT 0 NOT NULL,
    payment_date timestamp without time zone,
    mode_of_payment character varying(64),
    cheque_no character varying(64)
);


ALTER TABLE customer_payment_info OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 458649)
-- Name: customer_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE customer_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customer_seqs OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 458651)
-- Name: product_details; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE product_details (
    id integer NOT NULL,
    weight numeric(14,4),
    quantity numeric(14,4),
    type integer,
    product_master_id integer NOT NULL,
    purchase_date timestamp without time zone NOT NULL,
    amount numeric(14,4) NOT NULL,
    vat numeric(14,4),
    branch_id integer NOT NULL,
    user_master_id integer NOT NULL,
    k_and_p character varying(64),
    sale_quantity numeric(14,4),
    is_available boolean DEFAULT true NOT NULL,
    comments character varying(2048),
    deleted boolean DEFAULT false NOT NULL,
    purchase_payment_info_ref integer
);


ALTER TABLE product_details OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 458659)
-- Name: product_details_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE product_details_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_details_seqs OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 458661)
-- Name: product_group_map; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE product_group_map (
    id integer NOT NULL,
    code character varying(128)
);


ALTER TABLE product_group_map OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 458664)
-- Name: product_group_map_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE product_group_map_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_group_map_seqs OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 458666)
-- Name: product_master; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE product_master (
    id integer NOT NULL,
    product_name character varying(128) NOT NULL,
    product_code character varying(64),
    group_id integer,
    qty_unit character varying(128),
    weight_unit character varying(128),
    is_sub_item_type_req boolean DEFAULT false NOT NULL
);


ALTER TABLE product_master OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 458670)
-- Name: product_master_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE product_master_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_master_seqs OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 458672)
-- Name: purchase_payment_info; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE purchase_payment_info (
    id integer NOT NULL,
    company_name character varying(128),
    bill_no character varying(128),
    payment numeric(14,4) DEFAULT 0 NOT NULL,
    balance numeric(14,4) DEFAULT 0 NOT NULL,
    advance numeric(14,4) DEFAULT 0 NOT NULL
);


ALTER TABLE purchase_payment_info OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 458678)
-- Name: purchase_payment_info_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE purchase_payment_info_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchase_payment_info_seqs OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 458680)
-- Name: sales_details; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sales_details (
    id integer NOT NULL,
    product_master_id integer,
    quantity numeric(14,4),
    measure numeric(14,4),
    vat_percentage numeric(14,4),
    vat_amount numeric(14,4),
    total_amount_without_vat numeric(14,4),
    total_amount_with_vat numeric(14,4),
    braanch_id integer NOT NULL,
    sale_master_id integer,
    unit_price numeric(14,2)
);


ALTER TABLE sales_details OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 458683)
-- Name: sales_details_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sales_details_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales_details_seqs OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 458685)
-- Name: sales_master; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sales_master (
    id integer NOT NULL,
    total_vat_amount numeric(14,4),
    total_amount_without_vat numeric(14,4),
    total_amount_with_vat numeric(14,4),
    braanch_id integer NOT NULL,
    user_id integer NOT NULL,
    customer_vat_no character varying(128),
    bill_date timestamp without time zone DEFAULT now(),
    discount_amount numeric(14,4),
    bill_no character varying,
    customer_id integer
);


ALTER TABLE sales_master OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 458692)
-- Name: sales_master_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sales_master_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales_master_seqs OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 458694)
-- Name: stock_alert; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stock_alert (
    id integer NOT NULL,
    product_master_id integer NOT NULL,
    type integer,
    min_val numeric(14,4),
    max_val numeric(14,4)
);


ALTER TABLE stock_alert OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 458697)
-- Name: stock_alert_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE stock_alert_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stock_alert_seqs OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 458699)
-- Name: stock_deatils; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stock_deatils (
    id integer NOT NULL,
    product_code character varying(64),
    product_name character varying(128) NOT NULL,
    quantity numeric(14,4),
    weight numeric(14,4),
    product_master_id integer,
    branch_id integer NOT NULL,
    k_and_p character varying(64),
    type integer
);


ALTER TABLE stock_deatils OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 458702)
-- Name: stock_deatils_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE stock_deatils_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stock_deatils_seqs OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 458704)
-- Name: system_config_parameter; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE system_config_parameter (
    key character varying,
    value character varying
);


ALTER TABLE system_config_parameter OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 458710)
-- Name: user_branch_map; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_branch_map (
    id integer NOT NULL,
    user_master_id integer NOT NULL,
    branch_id integer NOT NULL
);


ALTER TABLE user_branch_map OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 458713)
-- Name: user_master; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_master (
    id integer NOT NULL,
    user_name character varying(64) NOT NULL,
    password character varying(128) NOT NULL,
    first_name character varying(64) NOT NULL,
    middle_name character varying(64),
    last_name character varying(64) NOT NULL,
    mobile character varying(20),
    email_id character varying(64),
    address character varying(2048),
    user_type_id integer NOT NULL
);


ALTER TABLE user_master OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 458719)
-- Name: user_master_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_master_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_master_seqs OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 458721)
-- Name: user_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_type (
    id integer NOT NULL,
    user_type character varying(64),
    description character varying(1024)
);


ALTER TABLE user_type OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 458727)
-- Name: user_type_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_type_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_type_seqs OWNER TO postgres;

--
-- TOC entry 2157 (class 0 OID 458628)
-- Dependencies: 172
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO branch (id, branch_name, branch_code, branch_city, branch_pin, branch_phone, branch_email, vat_no, address_line1, address_line2) VALUES (1, 'Durgapur', 'DGP', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO branch (id, branch_name, branch_code, branch_city, branch_pin, branch_phone, branch_email, vat_no, address_line1, address_line2) VALUES (2, 'Bankura', 'BNK', NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 2193 (class 0 OID 0)
-- Dependencies: 173
-- Name: branch_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('branch_seqs', 0, true);


--
-- TOC entry 2194 (class 0 OID 0)
-- Dependencies: 174
-- Name: corder_day_order_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('corder_day_order_sequence', 0, true);


--
-- TOC entry 2160 (class 0 OID 458638)
-- Dependencies: 175
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2161 (class 0 OID 458644)
-- Dependencies: 176
-- Data for Name: customer_payment_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2195 (class 0 OID 0)
-- Dependencies: 177
-- Name: customer_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('customer_seqs', 0, true);


--
-- TOC entry 2163 (class 0 OID 458651)
-- Dependencies: 178
-- Data for Name: product_details; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2196 (class 0 OID 0)
-- Dependencies: 179
-- Name: product_details_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_details_seqs', 0, true);


--
-- TOC entry 2165 (class 0 OID 458661)
-- Dependencies: 180
-- Data for Name: product_group_map; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2197 (class 0 OID 0)
-- Dependencies: 181
-- Name: product_group_map_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_group_map_seqs', 0, true);


--
-- TOC entry 2167 (class 0 OID 458666)
-- Dependencies: 182
-- Data for Name: product_master; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2198 (class 0 OID 0)
-- Dependencies: 183
-- Name: product_master_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_master_seqs', 0, true);


--
-- TOC entry 2169 (class 0 OID 458672)
-- Dependencies: 184
-- Data for Name: purchase_payment_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2199 (class 0 OID 0)
-- Dependencies: 185
-- Name: purchase_payment_info_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('purchase_payment_info_seqs', 0, true);


--
-- TOC entry 2171 (class 0 OID 458680)
-- Dependencies: 186
-- Data for Name: sales_details; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2200 (class 0 OID 0)
-- Dependencies: 187
-- Name: sales_details_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sales_details_seqs', 0, true);


--
-- TOC entry 2173 (class 0 OID 458685)
-- Dependencies: 188
-- Data for Name: sales_master; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2201 (class 0 OID 0)
-- Dependencies: 189
-- Name: sales_master_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sales_master_seqs', 0, true);


--
-- TOC entry 2175 (class 0 OID 458694)
-- Dependencies: 190
-- Data for Name: stock_alert; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2202 (class 0 OID 0)
-- Dependencies: 191
-- Name: stock_alert_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stock_alert_seqs', 0, true);


--
-- TOC entry 2177 (class 0 OID 458699)
-- Dependencies: 192
-- Data for Name: stock_deatils; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2203 (class 0 OID 0)
-- Dependencies: 193
-- Name: stock_deatils_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stock_deatils_seqs', 0, true);


--
-- TOC entry 2179 (class 0 OID 458704)
-- Dependencies: 194
-- Data for Name: system_config_parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2180 (class 0 OID 458710)
-- Dependencies: 195
-- Data for Name: user_branch_map; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2181 (class 0 OID 458713)
-- Dependencies: 196
-- Data for Name: user_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_master (id, user_name, password, first_name, middle_name, last_name, mobile, email_id, address, user_type_id) VALUES (1, 'admin', 'admin', 'Surat', NULL, 'Sashmal', NULL, NULL, NULL, 1);
INSERT INTO user_master (id, user_name, password, first_name, middle_name, last_name, mobile, email_id, address, user_type_id) VALUES (2, 'purchase', '123qwe', 'Amit', NULL, 'Saha', NULL, NULL, NULL, 2);


--
-- TOC entry 2204 (class 0 OID 0)
-- Dependencies: 197
-- Name: user_master_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_master_seqs', 0, true);


--
-- TOC entry 2183 (class 0 OID 458721)
-- Dependencies: 198
-- Data for Name: user_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_type (id, user_type, description) VALUES (1, 'SUPERUSER', 'User having admin role');
INSERT INTO user_type (id, user_type, description) VALUES (2, 'PURCHASE', 'User having purchase entry role');
INSERT INTO user_type (id, user_type, description) VALUES (3, 'SALES', 'User having sales role');
INSERT INTO user_type (id, user_type, description) VALUES (4, 'VIEWONLY', 'User having view only role');


--
-- TOC entry 2205 (class 0 OID 0)
-- Dependencies: 199
-- Name: user_type_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_type_seqs', 0, true);


--
-- TOC entry 1982 (class 2606 OID 458730)
-- Name: branch_bcode_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_bcode_uk UNIQUE (branch_code);


--
-- TOC entry 1984 (class 2606 OID 458732)
-- Name: branch_name_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_name_uk UNIQUE (branch_name);


--
-- TOC entry 1986 (class 2606 OID 458734)
-- Name: branch_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_pk PRIMARY KEY (id);


--
-- TOC entry 1992 (class 2606 OID 458736)
-- Name: customer_payment_info_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY customer_payment_info
    ADD CONSTRAINT customer_payment_info_pk PRIMARY KEY (id);


--
-- TOC entry 1988 (class 2606 OID 458738)
-- Name: customer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_pk PRIMARY KEY (id);


--
-- TOC entry 1990 (class 2606 OID 458740)
-- Name: customer_vat_no_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_vat_no_uk UNIQUE (vat_no);


--
-- TOC entry 2000 (class 2606 OID 458742)
-- Name: prod_mast_prodcode_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT prod_mast_prodcode_uk UNIQUE (product_code);


--
-- TOC entry 2002 (class 2606 OID 458744)
-- Name: prod_mast_prodname_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT prod_mast_prodname_uk UNIQUE (product_name);


--
-- TOC entry 1994 (class 2606 OID 458746)
-- Name: product_details_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT product_details_pk PRIMARY KEY (id);


--
-- TOC entry 1996 (class 2606 OID 458748)
-- Name: product_group_map_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_group_map
    ADD CONSTRAINT product_group_map_pk PRIMARY KEY (id);


--
-- TOC entry 1998 (class 2606 OID 458750)
-- Name: product_group_map_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_group_map
    ADD CONSTRAINT product_group_map_uk UNIQUE (code);


--
-- TOC entry 2004 (class 2606 OID 458752)
-- Name: product_master_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT product_master_pk PRIMARY KEY (id);


--
-- TOC entry 2006 (class 2606 OID 458754)
-- Name: purchase_payment_info_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY purchase_payment_info
    ADD CONSTRAINT purchase_payment_info_pk PRIMARY KEY (id);


--
-- TOC entry 2008 (class 2606 OID 458756)
-- Name: sales_details_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sales_details
    ADD CONSTRAINT sales_details_pk PRIMARY KEY (id);


--
-- TOC entry 2010 (class 2606 OID 458758)
-- Name: sales_master_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sales_master
    ADD CONSTRAINT sales_master_pk PRIMARY KEY (id);


--
-- TOC entry 2012 (class 2606 OID 458760)
-- Name: stock_alert_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_pk PRIMARY KEY (id);


--
-- TOC entry 2014 (class 2606 OID 458762)
-- Name: stock_alert_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_uk UNIQUE (product_master_id, type);


--
-- TOC entry 2016 (class 2606 OID 458764)
-- Name: stock_deatils_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_pk PRIMARY KEY (id);


--
-- TOC entry 2018 (class 2606 OID 458766)
-- Name: user_branch_map_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_branch_map
    ADD CONSTRAINT user_branch_map_pk PRIMARY KEY (id);


--
-- TOC entry 2020 (class 2606 OID 458768)
-- Name: user_branch_map_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_branch_map
    ADD CONSTRAINT user_branch_map_uk UNIQUE (user_master_id, branch_id);


--
-- TOC entry 2022 (class 2606 OID 458770)
-- Name: user_master_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_master_pk PRIMARY KEY (id);


--
-- TOC entry 2024 (class 2606 OID 458772)
-- Name: user_master_uname_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_master_uname_uk UNIQUE (user_name);


--
-- TOC entry 2026 (class 2606 OID 458774)
-- Name: user_type_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_type
    ADD CONSTRAINT user_type_pk PRIMARY KEY (id);


--
-- TOC entry 2047 (class 2620 OID 458775)
-- Name: insert_orderno_trig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insert_orderno_trig BEFORE INSERT ON sales_master FOR EACH ROW EXECUTE PROCEDURE insert_orderno_trig_fun();


--
-- TOC entry 2045 (class 2620 OID 458776)
-- Name: prod_det_before_updt_tri; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER prod_det_before_updt_tri BEFORE UPDATE ON product_details FOR EACH ROW EXECUTE PROCEDURE prod_det_before_updt_tri_fun();


--
-- TOC entry 2046 (class 2620 OID 458777)
-- Name: product_det_aftins_tri; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER product_det_aftins_tri AFTER INSERT ON product_details FOR EACH ROW EXECUTE PROCEDURE product_det_aftins_tri_fun();


--
-- TOC entry 2027 (class 2606 OID 458778)
-- Name: customer_payment_info_sales_mastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customer_payment_info
    ADD CONSTRAINT customer_payment_info_sales_mastid_fk FOREIGN KEY (sales_master_id) REFERENCES sales_master(id);


--
-- TOC entry 2028 (class 2606 OID 458783)
-- Name: prod_det_branchid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_branchid_fk FOREIGN KEY (branch_id) REFERENCES branch(id);


--
-- TOC entry 2029 (class 2606 OID 458788)
-- Name: prod_det_paymentinfo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_paymentinfo_fk FOREIGN KEY (purchase_payment_info_ref) REFERENCES purchase_payment_info(id);


--
-- TOC entry 2030 (class 2606 OID 458793)
-- Name: prod_det_prodmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_prodmastid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 2031 (class 2606 OID 458798)
-- Name: prod_det_usrmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_usrmastid_fk FOREIGN KEY (user_master_id) REFERENCES user_master(id);


--
-- TOC entry 2032 (class 2606 OID 458803)
-- Name: product_master_groupid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT product_master_groupid_fk FOREIGN KEY (group_id) REFERENCES product_group_map(id);


--
-- TOC entry 2033 (class 2606 OID 458808)
-- Name: sales_details_braanch_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_details
    ADD CONSTRAINT sales_details_braanch_id_fk FOREIGN KEY (braanch_id) REFERENCES branch(id);


--
-- TOC entry 2034 (class 2606 OID 458813)
-- Name: sales_details_pm_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_details
    ADD CONSTRAINT sales_details_pm_id_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 2035 (class 2606 OID 458818)
-- Name: sales_details_sale_master_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_details
    ADD CONSTRAINT sales_details_sale_master_id_fkey FOREIGN KEY (sale_master_id) REFERENCES sales_master(id);


--
-- TOC entry 2036 (class 2606 OID 458823)
-- Name: sales_master_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_master
    ADD CONSTRAINT sales_master_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES customer(id);


--
-- TOC entry 2037 (class 2606 OID 458828)
-- Name: sales_master_sales_braanch_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_master
    ADD CONSTRAINT sales_master_sales_braanch_id_fk FOREIGN KEY (braanch_id) REFERENCES branch(id);


--
-- TOC entry 2038 (class 2606 OID 458833)
-- Name: sales_master_sales_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_master
    ADD CONSTRAINT sales_master_sales_user_id_fk FOREIGN KEY (user_id) REFERENCES user_master(id);


--
-- TOC entry 2039 (class 2606 OID 458838)
-- Name: stock_alert_prodmasid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_prodmasid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 2040 (class 2606 OID 458843)
-- Name: stock_deatils_branid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_branid_fk FOREIGN KEY (branch_id) REFERENCES branch(id);


--
-- TOC entry 2041 (class 2606 OID 458848)
-- Name: stock_det_prodmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_det_prodmastid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 2042 (class 2606 OID 458853)
-- Name: user_branch_map_branchid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_branch_map
    ADD CONSTRAINT user_branch_map_branchid_fk FOREIGN KEY (branch_id) REFERENCES branch(id);


--
-- TOC entry 2043 (class 2606 OID 458858)
-- Name: user_branch_map_usrid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_branch_map
    ADD CONSTRAINT user_branch_map_usrid_fk FOREIGN KEY (user_master_id) REFERENCES user_master(id);


--
-- TOC entry 2044 (class 2606 OID 458863)
-- Name: user_mast_usrtypeid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_mast_usrtypeid_fk FOREIGN KEY (user_type_id) REFERENCES user_type(id);


--
-- TOC entry 2191 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-11-29 13:42:04

--
-- PostgreSQL database dump complete
--

ALTER TABLE product_master ADD gown character varying(128);

