--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.4.4
-- Started on 2015-10-05 21:36:10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 188 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2108 (class 0 OID 0)
-- Dependencies: 188
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 201 (class 1255 OID 104908)
-- Name: product_det_aftins_tri_fun(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION product_det_aftins_tri_fun() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
ctr integer;
var_unit_of_measure integer;
BEGIN
 if(TG_OP='INSERT') then
 select unit_of_measure into var_unit_of_measure from product_master where id=NEW.product_master_id;
 if((NEW.type=0 or NEW.type is null) and var_unit_of_measure=2) then
  select count(id) into ctr from stock_deatils where product_master_id=NEW.product_master_id and unit_of_measure=2 and type=NEW.type;
  if(ctr>0) then
   update stock_deatils set quantity=coalesce(quantity,0)+coalesce(NEW.quantity,0),weight=coalesce(weight,0)+coalesce(NEW.weight,0) where product_master_id=NEW.product_master_id and unit_of_measure=2 and type=NEW.type;
  else
   insert into stock_deatils (id,product_code,product_name,quantity,weight,unit_of_measure,product_master_id,branch_id,k_and_p,type) values (nextval('stock_deatils_seqs'),(select product_code from product_master where id=NEW.product_master_id),(select product_name from product_master where id=NEW.product_master_id),NEW.quantity,NEW.weight,var_unit_of_measure,NEW.product_master_id,NEW.branch_id,NEW.k_and_p,NEW.type);
  end if;
 elsif(NEW.type<>0 and var_unit_of_measure=1) then
  select count(id) into ctr from stock_deatils where product_master_id=NEW.product_master_id and unit_of_measure=1 and type=NEW.type;
  if(ctr>0) then
   update stock_deatils set quantity=coalesce(quantity,0)+coalesce(NEW.quantity,0),weight=coalesce(weight,0)+coalesce(NEW.weight,0) where product_master_id=NEW.product_master_id and unit_of_measure=1 and type=NEW.type;
  else
   insert into stock_deatils (id,product_code,product_name,quantity,weight,unit_of_measure,product_master_id,branch_id,k_and_p,type) values (nextval('stock_deatils_seqs'),(select product_code from product_master where id=NEW.product_master_id),(select product_name from product_master where id=NEW.product_master_id),NEW.quantity,NEW.weight,var_unit_of_measure,NEW.product_master_id,NEW.branch_id,NEW.k_and_p,NEW.type);
  end if;
 end if;
 end if;
return NEW;
END;
$$;


ALTER FUNCTION public.product_det_aftins_tri_fun() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 172 (class 1259 OID 104909)
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE branch (
    id integer NOT NULL,
    branch_name character varying(128) NOT NULL,
    branch_code character varying(128)
);


ALTER TABLE branch OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 104912)
-- Name: branch_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE branch_seqs
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE branch_seqs OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 104914)
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
    purchase_payment_info_ref integer NOT NULL
);


ALTER TABLE product_details OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 104922)
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
-- TOC entry 186 (class 1259 OID 105019)
-- Name: product_group_map; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE product_group_map (
    id integer NOT NULL,
    code character varying(128)
);


ALTER TABLE product_group_map OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 104924)
-- Name: product_master; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE product_master (
    id integer NOT NULL,
    product_name character varying(128) NOT NULL,
    product_code character varying(64),
    unit_of_measure integer NOT NULL,
    unit_type character varying(64)
);


ALTER TABLE product_master OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 104927)
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
-- TOC entry 187 (class 1259 OID 105026)
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
-- TOC entry 178 (class 1259 OID 104929)
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
-- TOC entry 179 (class 1259 OID 104932)
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
-- TOC entry 180 (class 1259 OID 104934)
-- Name: stock_deatils; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stock_deatils (
    id integer NOT NULL,
    product_code character varying(64),
    product_name character varying(128) NOT NULL,
    quantity numeric(14,4),
    weight numeric(14,4),
    unit_of_measure integer NOT NULL,
    product_master_id integer,
    branch_id integer NOT NULL,
    k_and_p character varying(64),
    type integer
);


ALTER TABLE stock_deatils OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 104937)
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
-- TOC entry 182 (class 1259 OID 104939)
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
-- TOC entry 183 (class 1259 OID 104945)
-- Name: user_master_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_master_seqs
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_master_seqs OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 104947)
-- Name: user_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_type (
    id integer NOT NULL,
    user_type character varying(64),
    description character varying(1024)
);


ALTER TABLE user_type OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 104953)
-- Name: user_type_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_type_seqs
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_type_seqs OWNER TO postgres;

--
-- TOC entry 2085 (class 0 OID 104909)
-- Dependencies: 172
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO branch (id, branch_name, branch_code) VALUES (1, 'Durgapur', 'DGP');
INSERT INTO branch (id, branch_name, branch_code) VALUES (2, 'Bankura', 'BNK');


--
-- TOC entry 2109 (class 0 OID 0)
-- Dependencies: 173
-- Name: branch_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('branch_seqs', 1, false);


--
-- TOC entry 2087 (class 0 OID 104914)
-- Dependencies: 174
-- Data for Name: product_details; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2110 (class 0 OID 0)
-- Dependencies: 175
-- Name: product_details_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_details_seqs', 0, true);


--
-- TOC entry 2099 (class 0 OID 105019)
-- Dependencies: 186
-- Data for Name: product_group_map; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2089 (class 0 OID 104924)
-- Dependencies: 176
-- Data for Name: product_master; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2111 (class 0 OID 0)
-- Dependencies: 177
-- Name: product_master_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_master_seqs', 0, true);


--
-- TOC entry 2100 (class 0 OID 105026)
-- Dependencies: 187
-- Data for Name: purchase_payment_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2091 (class 0 OID 104929)
-- Dependencies: 178
-- Data for Name: stock_alert; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2112 (class 0 OID 0)
-- Dependencies: 179
-- Name: stock_alert_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stock_alert_seqs', 0, true);


--
-- TOC entry 2093 (class 0 OID 104934)
-- Dependencies: 180
-- Data for Name: stock_deatils; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2113 (class 0 OID 0)
-- Dependencies: 181
-- Name: stock_deatils_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stock_deatils_seqs', 0, true);


--
-- TOC entry 2095 (class 0 OID 104939)
-- Dependencies: 182
-- Data for Name: user_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_master (id, user_name, password, first_name, middle_name, last_name, mobile, email_id, address, user_type_id) VALUES (1, 'admin', 'admin', 'Surat', NULL, 'Sashmal', NULL, NULL, NULL, 1);


--
-- TOC entry 2114 (class 0 OID 0)
-- Dependencies: 183
-- Name: user_master_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_master_seqs', 1, false);


--
-- TOC entry 2097 (class 0 OID 104947)
-- Dependencies: 184
-- Data for Name: user_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_type (id, user_type, description) VALUES (1, 'SUPERUSER', 'User having admin role');
INSERT INTO user_type (id, user_type, description) VALUES (2, 'PURCHASE', 'User having purchase entry role');
INSERT INTO user_type (id, user_type, description) VALUES (3, 'SALES', 'User having sales role');
INSERT INTO user_type (id, user_type, description) VALUES (4, 'VIEWONLY', 'User having view only role');


--
-- TOC entry 2115 (class 0 OID 0)
-- Dependencies: 185
-- Name: user_type_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_type_seqs', 1, false);


--
-- TOC entry 1935 (class 2606 OID 104956)
-- Name: branch_bcode_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_bcode_uk UNIQUE (branch_code);


--
-- TOC entry 1937 (class 2606 OID 104958)
-- Name: branch_name_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_name_uk UNIQUE (branch_name);


--
-- TOC entry 1939 (class 2606 OID 104960)
-- Name: branch_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_pk PRIMARY KEY (id);


--
-- TOC entry 1943 (class 2606 OID 104962)
-- Name: prod_mast_prodcode_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT prod_mast_prodcode_uk UNIQUE (product_code);


--
-- TOC entry 1945 (class 2606 OID 104964)
-- Name: prod_mast_prodname_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT prod_mast_prodname_uk UNIQUE (product_name);


--
-- TOC entry 1941 (class 2606 OID 104966)
-- Name: product_details_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT product_details_pk PRIMARY KEY (id);


--
-- TOC entry 1963 (class 2606 OID 105023)
-- Name: product_group_map_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_group_map
    ADD CONSTRAINT product_group_map_pk PRIMARY KEY (id);


--
-- TOC entry 1965 (class 2606 OID 105025)
-- Name: product_group_map_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_group_map
    ADD CONSTRAINT product_group_map_uk UNIQUE (code);


--
-- TOC entry 1947 (class 2606 OID 104968)
-- Name: product_master_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT product_master_pk PRIMARY KEY (id);


--
-- TOC entry 1967 (class 2606 OID 105033)
-- Name: purchase_payment_info_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY purchase_payment_info
    ADD CONSTRAINT purchase_payment_info_pk PRIMARY KEY (id);


--
-- TOC entry 1949 (class 2606 OID 104970)
-- Name: stock_alert_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_pk PRIMARY KEY (id);


--
-- TOC entry 1951 (class 2606 OID 104972)
-- Name: stock_alert_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_uk UNIQUE (product_master_id, type);


--
-- TOC entry 1953 (class 2606 OID 104974)
-- Name: stock_deatils_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_pk PRIMARY KEY (id);


--
-- TOC entry 1955 (class 2606 OID 104976)
-- Name: stock_deatils_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_uk UNIQUE (product_name, unit_of_measure, branch_id, type);


--
-- TOC entry 1957 (class 2606 OID 104978)
-- Name: user_master_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_master_pk PRIMARY KEY (id);


--
-- TOC entry 1959 (class 2606 OID 104980)
-- Name: user_master_uname_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_master_uname_uk UNIQUE (user_name);


--
-- TOC entry 1961 (class 2606 OID 104982)
-- Name: user_type_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_type
    ADD CONSTRAINT user_type_pk PRIMARY KEY (id);


--
-- TOC entry 1975 (class 2620 OID 104983)
-- Name: product_det_aftins_tri; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER product_det_aftins_tri AFTER INSERT ON product_details FOR EACH ROW EXECUTE PROCEDURE product_det_aftins_tri_fun();


--
-- TOC entry 1968 (class 2606 OID 104984)
-- Name: prod_det_branchid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_branchid_fk FOREIGN KEY (branch_id) REFERENCES branch(id);


--
-- TOC entry 1969 (class 2606 OID 104989)
-- Name: prod_det_prodmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_prodmastid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 1970 (class 2606 OID 104994)
-- Name: prod_det_usrmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_usrmastid_fk FOREIGN KEY (user_master_id) REFERENCES user_master(id);


--
-- TOC entry 1971 (class 2606 OID 104999)
-- Name: stock_alert_prodmasid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_prodmasid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 1972 (class 2606 OID 105004)
-- Name: stock_deatils_branid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_branid_fk FOREIGN KEY (branch_id) REFERENCES branch(id);


--
-- TOC entry 1973 (class 2606 OID 105009)
-- Name: stock_det_prodmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_det_prodmastid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 1974 (class 2606 OID 105014)
-- Name: user_mast_usrtypeid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_mast_usrtypeid_fk FOREIGN KEY (user_type_id) REFERENCES user_type(id);


--
-- TOC entry 2107 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-10-05 21:36:11

--
-- PostgreSQL database dump complete
--


ALTER TABLE branch ADD branch_city character varying(128);
ALTER TABLE branch ADD branch_pin character varying(128);
ALTER TABLE branch ADD branch_phone character varying(128);
ALTER TABLE branch ADD branch_email character varying(128);
--------------
CREATE TABLE sales_master
(
  id integer NOT NULL,
  sales_details_id integer,
  total_vat_amount numeric(14,4),
  total_amount_without_vat numeric(14,4),
  total_amount_with_vat numeric(14,4),
  braanch_id integer not null,
  user_id integer not null,
  customer_vat_no character varying(128),
  bill_date timestamp without time zone default now()
);
CREATE TABLE sales_details
(
  id integer NOT NULL,
  product_master_id integer,
  quantity numeric(14,4),
  measure numeric(14,4),
  vat_percentage numeric(14,4),
  vat_amount numeric(14,4),
  total_amount_without_vat numeric(14,4),
  total_amount_with_vat numeric(14,4),
  braanch_id integer not null
);


ALTER TABLE sales_master ADD CONSTRAINT sales_master_pk PRIMARY KEY(id);  
ALTER TABLE sales_details ADD CONSTRAINT sales_details_pk PRIMARY KEY(id);  
ALTER TABLE sales_master ADD CONSTRAINT sales_master_sales_detid_fk FOREIGN KEY (sales_details_id) REFERENCES sales_details (id);
ALTER TABLE sales_master ADD CONSTRAINT sales_master_sales_braanch_id_fk FOREIGN KEY (braanch_id) REFERENCES branch (id);
ALTER TABLE sales_master ADD CONSTRAINT sales_master_sales_user_id_fk FOREIGN KEY (user_id) REFERENCES user_master (id);

ALTER TABLE sales_details ADD CONSTRAINT sales_details_pm_id_fk FOREIGN KEY (product_master_id) REFERENCES product_master (id);
ALTER TABLE sales_details ADD CONSTRAINT sales_details_braanch_id_fk FOREIGN KEY (braanch_id) REFERENCES branch (id);
------------
ALTER TABLE branch ADD vat_no character varying(128);
CREATE TABLE customer
(
  id integer NOT NULL,
  customer_name character varying(128) NOT NULL,
  address character varying(128),
  city character varying(128),
  pin character varying(128),
  phone character varying(128),
  email character varying(128),
  vat_no character varying(128)
);
ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY(id);
ALTER TABLE customer ADD CONSTRAINT customer_vat_no_uk UNIQUE(vat_no);
-------------
CREATE TABLE customer_payment_info
(
  id integer NOT NULL,
  sales_master_id integer,
  total_bill_amount numeric(14,4),
  pay numeric(14,4) NOT NULL DEFAULT 0,
  due_amount numeric(14,4) NOT NULL DEFAULT 0,
  payment_date timestamp without time zone
);
ALTER TABLE customer_payment_info ADD CONSTRAINT customer_payment_info_pk PRIMARY KEY(id);
ALTER TABLE customer_payment_info ADD CONSTRAINT customer_payment_info_sales_mastid_fk FOREIGN KEY (sales_master_id) REFERENCES sales_master (id);
ALTER TABLE sales_master ADD discount_amount numeric(14,4);

ALTER TABLE customer_payment_info ADD mode_of_payment character varying(64);
ALTER TABLE customer_payment_info ADD cheque_no character varying(64);
---------------------------------------------
CREATE TABLE user_branch_map
(
  id integer NOT NULL,
  user_master_id integer not null,
  branch_id integer not null
);


ALTER TABLE user_branch_map ADD CONSTRAINT user_branch_map_pk PRIMARY KEY(id);
ALTER TABLE user_branch_map ADD CONSTRAINT user_branch_map_usrid_fk FOREIGN KEY (user_master_id) REFERENCES user_master (id);
ALTER TABLE user_branch_map ADD CONSTRAINT user_branch_map_branchid_fk FOREIGN KEY (branch_id) REFERENCES branch (id);

ALTER TABLE user_branch_map ADD CONSTRAINT user_branch_map_uk UNIQUE(user_master_id,branch_id);

