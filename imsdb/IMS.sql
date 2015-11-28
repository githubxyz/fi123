--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
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
-- Name: product_group_map; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE product_group_map (
    id integer NOT NULL,
    code character varying(128)
);


ALTER TABLE product_group_map OWNER TO postgres;

--
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
-- Name: system_config_parameter; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE system_config_parameter (
    key character varying,
    value character varying
);


ALTER TABLE system_config_parameter OWNER TO postgres;

--
-- Name: user_branch_map; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_branch_map (
    id integer NOT NULL,
    user_master_id integer NOT NULL,
    branch_id integer NOT NULL
);


ALTER TABLE user_branch_map OWNER TO postgres;

--
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
-- Name: user_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_type (
    id integer NOT NULL,
    user_type character varying(64),
    description character varying(1024)
);


ALTER TABLE user_type OWNER TO postgres;

--
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
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO branch (id, branch_name, branch_code, branch_city, branch_pin, branch_phone, branch_email, vat_no, address_line1, address_line2) VALUES (1, 'Durgapur', 'DGP', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO branch (id, branch_name, branch_code, branch_city, branch_pin, branch_phone, branch_email, vat_no, address_line1, address_line2) VALUES (2, 'Bankura', 'BNK', NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Name: branch_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('branch_seqs', 1, false);


--
-- Name: corder_day_order_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('corder_day_order_sequence', 1, true);


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: customer_payment_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: customer_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('customer_seqs', 1, true);


--
-- Data for Name: product_details; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: product_details_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_details_seqs', 1, true);


--
-- Data for Name: product_group_map; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: product_group_map_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_group_map_seqs', 1, true);


--
-- Data for Name: product_master; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: product_master_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_master_seqs', 1, true);


--
-- Data for Name: purchase_payment_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: purchase_payment_info_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('purchase_payment_info_seqs', 1, true);


--
-- Data for Name: sales_details; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: sales_details_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sales_details_seqs', 1, true);


--
-- Data for Name: sales_master; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: sales_master_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sales_master_seqs', 1, true);


--
-- Data for Name: stock_alert; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: stock_alert_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stock_alert_seqs', 1, true);


--
-- Data for Name: stock_deatils; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: stock_deatils_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stock_deatils_seqs', 9, true);


--
-- Data for Name: system_config_parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: user_branch_map; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: user_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_master (id, user_name, password, first_name, middle_name, last_name, mobile, email_id, address, user_type_id) VALUES (1, 'admin', 'admin', 'Surat', NULL, 'Sashmal', NULL, NULL, NULL, 1);
INSERT INTO user_master (id, user_name, password, first_name, middle_name, last_name, mobile, email_id, address, user_type_id) VALUES (2, 'purchase', '123qwe', 'Amit', NULL, 'Saha', NULL, NULL, NULL, 2);


--
-- Name: user_master_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_master_seqs', 1, false);


--
-- Data for Name: user_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_type (id, user_type, description) VALUES (1, 'SUPERUSER', 'User having admin role');
INSERT INTO user_type (id, user_type, description) VALUES (2, 'PURCHASE', 'User having purchase entry role');
INSERT INTO user_type (id, user_type, description) VALUES (3, 'SALES', 'User having sales role');
INSERT INTO user_type (id, user_type, description) VALUES (4, 'VIEWONLY', 'User having view only role');


--
-- Name: user_type_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_type_seqs', 1, false);


--
-- Name: branch_bcode_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_bcode_uk UNIQUE (branch_code);


--
-- Name: branch_name_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_name_uk UNIQUE (branch_name);


--
-- Name: branch_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_pk PRIMARY KEY (id);


--
-- Name: customer_payment_info_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY customer_payment_info
    ADD CONSTRAINT customer_payment_info_pk PRIMARY KEY (id);


--
-- Name: customer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_pk PRIMARY KEY (id);


--
-- Name: customer_vat_no_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_vat_no_uk UNIQUE (vat_no);


--
-- Name: prod_mast_prodcode_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT prod_mast_prodcode_uk UNIQUE (product_code);


--
-- Name: prod_mast_prodname_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT prod_mast_prodname_uk UNIQUE (product_name);


--
-- Name: product_details_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT product_details_pk PRIMARY KEY (id);


--
-- Name: product_group_map_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_group_map
    ADD CONSTRAINT product_group_map_pk PRIMARY KEY (id);


--
-- Name: product_group_map_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_group_map
    ADD CONSTRAINT product_group_map_uk UNIQUE (code);


--
-- Name: product_master_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT product_master_pk PRIMARY KEY (id);


--
-- Name: purchase_payment_info_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY purchase_payment_info
    ADD CONSTRAINT purchase_payment_info_pk PRIMARY KEY (id);


--
-- Name: sales_details_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sales_details
    ADD CONSTRAINT sales_details_pk PRIMARY KEY (id);


--
-- Name: sales_master_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sales_master
    ADD CONSTRAINT sales_master_pk PRIMARY KEY (id);


--
-- Name: stock_alert_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_pk PRIMARY KEY (id);


--
-- Name: stock_alert_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_uk UNIQUE (product_master_id, type);


--
-- Name: stock_deatils_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_pk PRIMARY KEY (id);


--
-- Name: user_branch_map_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_branch_map
    ADD CONSTRAINT user_branch_map_pk PRIMARY KEY (id);


--
-- Name: user_branch_map_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_branch_map
    ADD CONSTRAINT user_branch_map_uk UNIQUE (user_master_id, branch_id);


--
-- Name: user_master_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_master_pk PRIMARY KEY (id);


--
-- Name: user_master_uname_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_master_uname_uk UNIQUE (user_name);


--
-- Name: user_type_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_type
    ADD CONSTRAINT user_type_pk PRIMARY KEY (id);


--
-- Name: insert_orderno_trig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insert_orderno_trig BEFORE INSERT ON sales_master FOR EACH ROW EXECUTE PROCEDURE insert_orderno_trig_fun();


--
-- Name: prod_det_before_updt_tri; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER prod_det_before_updt_tri BEFORE UPDATE ON product_details FOR EACH ROW EXECUTE PROCEDURE prod_det_before_updt_tri_fun();


--
-- Name: product_det_aftins_tri; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER product_det_aftins_tri AFTER INSERT ON product_details FOR EACH ROW EXECUTE PROCEDURE product_det_aftins_tri_fun();


--
-- Name: customer_payment_info_sales_mastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customer_payment_info
    ADD CONSTRAINT customer_payment_info_sales_mastid_fk FOREIGN KEY (sales_master_id) REFERENCES sales_master(id);


--
-- Name: prod_det_branchid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_branchid_fk FOREIGN KEY (branch_id) REFERENCES branch(id);


--
-- Name: prod_det_paymentinfo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_paymentinfo_fk FOREIGN KEY (purchase_payment_info_ref) REFERENCES purchase_payment_info(id);


--
-- Name: prod_det_prodmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_prodmastid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- Name: prod_det_usrmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_usrmastid_fk FOREIGN KEY (user_master_id) REFERENCES user_master(id);


--
-- Name: product_master_groupid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT product_master_groupid_fk FOREIGN KEY (group_id) REFERENCES product_group_map(id);


--
-- Name: sales_details_braanch_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_details
    ADD CONSTRAINT sales_details_braanch_id_fk FOREIGN KEY (braanch_id) REFERENCES branch(id);


--
-- Name: sales_details_pm_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_details
    ADD CONSTRAINT sales_details_pm_id_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- Name: sales_details_sale_master_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_details
    ADD CONSTRAINT sales_details_sale_master_id_fkey FOREIGN KEY (sale_master_id) REFERENCES sales_master(id);


--
-- Name: sales_master_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_master
    ADD CONSTRAINT sales_master_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES customer(id);


--
-- Name: sales_master_sales_braanch_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_master
    ADD CONSTRAINT sales_master_sales_braanch_id_fk FOREIGN KEY (braanch_id) REFERENCES branch(id);


--
-- Name: sales_master_sales_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_master
    ADD CONSTRAINT sales_master_sales_user_id_fk FOREIGN KEY (user_id) REFERENCES user_master(id);


--
-- Name: stock_alert_prodmasid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_prodmasid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- Name: stock_deatils_branid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_branid_fk FOREIGN KEY (branch_id) REFERENCES branch(id);


--
-- Name: stock_det_prodmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_det_prodmastid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- Name: user_branch_map_branchid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_branch_map
    ADD CONSTRAINT user_branch_map_branchid_fk FOREIGN KEY (branch_id) REFERENCES branch(id);


--
-- Name: user_branch_map_usrid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_branch_map
    ADD CONSTRAINT user_branch_map_usrid_fk FOREIGN KEY (user_master_id) REFERENCES user_master(id);


--
-- Name: user_mast_usrtypeid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_mast_usrtypeid_fk FOREIGN KEY (user_type_id) REFERENCES user_type(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

