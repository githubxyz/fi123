--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.4.4
-- Started on 2015-10-03 14:50:09

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 186 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2089 (class 0 OID 0)
-- Dependencies: 186
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 199 (class 1255 OID 96828)
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
 if(NEW.type is null and var_unit_of_measure=2) then
  select count(id) into ctr from stock_deatils where product_master_id=NEW.product_master_id and unit_of_measure=2 and type=NEW.type;
  if(ctr>0) then
   update stock_deatils set quantity=coalesce(quantity,0)+coalesce(NEW.quantity,0),weight=coalesce(weight,0)+coalesce(NEW.weight,0) where product_master_id=NEW.product_master_id and unit_of_measure=2 and type=NEW.type;
  else
   insert into stock_deatils (id,product_code,product_name,quantity,weight,unit_of_measure,product_master_id,branch_id,k_and_p,type) values (nextval('stock_deatils_seqs'),(select product_code from product_master where id=NEW.product_master_id),(select product_name from product_master where id=NEW.product_master_id),NEW.quantity,NEW.weight,var_unit_of_measure,NEW.product_master_id,NEW.branch_id,NEW.k_and_p,NEW.type);
  end if;
 elsif(NEW.type is not null and var_unit_of_measure=1) then
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
-- TOC entry 172 (class 1259 OID 96829)
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE branch (
    id integer NOT NULL,
    branch_name character varying(128) NOT NULL,
    branch_code character varying(128)
);


ALTER TABLE branch OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 96832)
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
-- TOC entry 174 (class 1259 OID 96834)
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
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE product_details OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 96842)
-- Name: product_details_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE product_details_seqs
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_details_seqs OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 96844)
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
-- TOC entry 177 (class 1259 OID 96847)
-- Name: product_master_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE product_master_seqs
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_master_seqs OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 96849)
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
-- TOC entry 179 (class 1259 OID 96852)
-- Name: stock_alert_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE stock_alert_seqs
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stock_alert_seqs OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 96854)
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
-- TOC entry 181 (class 1259 OID 96857)
-- Name: stock_deatils_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE stock_deatils_seqs
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stock_deatils_seqs OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 96859)
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
-- TOC entry 183 (class 1259 OID 96865)
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
-- TOC entry 184 (class 1259 OID 96867)
-- Name: user_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_type (
    id integer NOT NULL,
    user_type character varying(64),
    description character varying(1024)
);


ALTER TABLE user_type OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 96873)
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
-- TOC entry 2068 (class 0 OID 96829)
-- Dependencies: 172
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO branch (id, branch_name, branch_code) VALUES (1, 'Durgapur', 'DGP');
INSERT INTO branch (id, branch_name, branch_code) VALUES (2, 'Bankura', 'BNK');


--
-- TOC entry 2090 (class 0 OID 0)
-- Dependencies: 173
-- Name: branch_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('branch_seqs', 1, false);


--
-- TOC entry 2070 (class 0 OID 96834)
-- Dependencies: 174
-- Data for Name: product_details; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2091 (class 0 OID 0)
-- Dependencies: 175
-- Name: product_details_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_details_seqs', 1, true);


--
-- TOC entry 2072 (class 0 OID 96844)
-- Dependencies: 176
-- Data for Name: product_master; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2092 (class 0 OID 0)
-- Dependencies: 177
-- Name: product_master_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_master_seqs', 1, true);


--
-- TOC entry 2074 (class 0 OID 96849)
-- Dependencies: 178
-- Data for Name: stock_alert; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2093 (class 0 OID 0)
-- Dependencies: 179
-- Name: stock_alert_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stock_alert_seqs', 1, true);


--
-- TOC entry 2076 (class 0 OID 96854)
-- Dependencies: 180
-- Data for Name: stock_deatils; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2094 (class 0 OID 0)
-- Dependencies: 181
-- Name: stock_deatils_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stock_deatils_seqs', 1, true);


--
-- TOC entry 2078 (class 0 OID 96859)
-- Dependencies: 182
-- Data for Name: user_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_master (id, user_name, password, first_name, middle_name, last_name, mobile, email_id, address, user_type_id) VALUES (1, 'admin', 'admin', 'Surat', NULL, 'Sashmal', NULL, NULL, NULL, 1);


--
-- TOC entry 2095 (class 0 OID 0)
-- Dependencies: 183
-- Name: user_master_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_master_seqs', 1, false);


--
-- TOC entry 2080 (class 0 OID 96867)
-- Dependencies: 184
-- Data for Name: user_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_type (id, user_type, description) VALUES (1, 'SUPERUSER', 'User having admin role');
INSERT INTO user_type (id, user_type, description) VALUES (2, 'PURCHASE', 'User having purchase entry role');
INSERT INTO user_type (id, user_type, description) VALUES (3, 'SALES', 'User having sales role');
INSERT INTO user_type (id, user_type, description) VALUES (4, 'VIEWONLY', 'User having view only role');


--
-- TOC entry 2096 (class 0 OID 0)
-- Dependencies: 185
-- Name: user_type_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_type_seqs', 1, false);


--
-- TOC entry 1924 (class 2606 OID 96876)
-- Name: branch_bcode_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_bcode_uk UNIQUE (branch_code);


--
-- TOC entry 1926 (class 2606 OID 96878)
-- Name: branch_name_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_name_uk UNIQUE (branch_name);


--
-- TOC entry 1928 (class 2606 OID 96880)
-- Name: branch_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_pk PRIMARY KEY (id);


--
-- TOC entry 1932 (class 2606 OID 96882)
-- Name: prod_mast_prodcode_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT prod_mast_prodcode_uk UNIQUE (product_code);


--
-- TOC entry 1934 (class 2606 OID 96884)
-- Name: prod_mast_prodname_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT prod_mast_prodname_uk UNIQUE (product_name);


--
-- TOC entry 1930 (class 2606 OID 96886)
-- Name: product_details_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT product_details_pk PRIMARY KEY (id);


--
-- TOC entry 1936 (class 2606 OID 96888)
-- Name: product_master_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT product_master_pk PRIMARY KEY (id);


--
-- TOC entry 1938 (class 2606 OID 96890)
-- Name: stock_alert_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_pk PRIMARY KEY (id);


--
-- TOC entry 1940 (class 2606 OID 96892)
-- Name: stock_alert_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_uk UNIQUE (product_master_id, type);


--
-- TOC entry 1942 (class 2606 OID 96894)
-- Name: stock_deatils_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_pk PRIMARY KEY (id);


--
-- TOC entry 1944 (class 2606 OID 96940)
-- Name: stock_deatils_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_uk UNIQUE (product_name, unit_of_measure, branch_id, type);


--
-- TOC entry 1946 (class 2606 OID 96898)
-- Name: user_master_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_master_pk PRIMARY KEY (id);


--
-- TOC entry 1948 (class 2606 OID 96900)
-- Name: user_master_uname_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_master_uname_uk UNIQUE (user_name);


--
-- TOC entry 1950 (class 2606 OID 96902)
-- Name: user_type_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_type
    ADD CONSTRAINT user_type_pk PRIMARY KEY (id);


--
-- TOC entry 1958 (class 2620 OID 96903)
-- Name: product_det_aftins_tri; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER product_det_aftins_tri AFTER INSERT ON product_details FOR EACH ROW EXECUTE PROCEDURE product_det_aftins_tri_fun();


--
-- TOC entry 1951 (class 2606 OID 96904)
-- Name: prod_det_branchid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_branchid_fk FOREIGN KEY (branch_id) REFERENCES branch(id);


--
-- TOC entry 1952 (class 2606 OID 96909)
-- Name: prod_det_prodmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_prodmastid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 1953 (class 2606 OID 96914)
-- Name: prod_det_usrmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_usrmastid_fk FOREIGN KEY (user_master_id) REFERENCES user_master(id);


--
-- TOC entry 1954 (class 2606 OID 96919)
-- Name: stock_alert_prodmasid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_prodmasid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 1955 (class 2606 OID 96924)
-- Name: stock_deatils_branid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_branid_fk FOREIGN KEY (branch_id) REFERENCES branch(id);


--
-- TOC entry 1956 (class 2606 OID 96929)
-- Name: stock_det_prodmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_det_prodmastid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 1957 (class 2606 OID 96934)
-- Name: user_mast_usrtypeid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_mast_usrtypeid_fk FOREIGN KEY (user_type_id) REFERENCES user_type(id);


--
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-10-03 14:50:09

--
-- PostgreSQL database dump complete
--

