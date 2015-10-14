--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.1
-- Dumped by pg_dump version 9.1.1
-- Started on 2015-10-14 20:34:23

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 177 (class 3079 OID 11638)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1950 (class 0 OID 0)
-- Dependencies: 177
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 189 (class 1255 OID 271533)
-- Dependencies: 527 6
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
-- TOC entry 161 (class 1259 OID 271534)
-- Dependencies: 6
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE branch (
    id integer NOT NULL,
    branch_name character varying(128) NOT NULL,
    branch_code character varying(128)
);


ALTER TABLE public.branch OWNER TO postgres;

--
-- TOC entry 162 (class 1259 OID 271537)
-- Dependencies: 6
-- Name: branch_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE branch_seqs
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.branch_seqs OWNER TO postgres;

--
-- TOC entry 1951 (class 0 OID 0)
-- Dependencies: 162
-- Name: branch_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('branch_seqs', 1, false);


--
-- TOC entry 163 (class 1259 OID 271539)
-- Dependencies: 1887 1888 6
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


ALTER TABLE public.product_details OWNER TO postgres;

--
-- TOC entry 164 (class 1259 OID 271547)
-- Dependencies: 6
-- Name: product_details_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE product_details_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_details_seqs OWNER TO postgres;

--
-- TOC entry 1952 (class 0 OID 0)
-- Dependencies: 164
-- Name: product_details_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_details_seqs', 0, true);


--
-- TOC entry 165 (class 1259 OID 271549)
-- Dependencies: 6
-- Name: product_group_map; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE product_group_map (
    id integer NOT NULL,
    code character varying(128)
);


ALTER TABLE public.product_group_map OWNER TO postgres;

--
-- TOC entry 166 (class 1259 OID 271552)
-- Dependencies: 6
-- Name: product_master; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE product_master (
    id integer NOT NULL,
    product_name character varying(128) NOT NULL,
    product_code character varying(64),
    unit_of_measure integer NOT NULL,
    unit_type character varying(64),
    group_id integer
);


ALTER TABLE public.product_master OWNER TO postgres;

--
-- TOC entry 167 (class 1259 OID 271555)
-- Dependencies: 6
-- Name: product_master_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE product_master_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_master_seqs OWNER TO postgres;

--
-- TOC entry 1953 (class 0 OID 0)
-- Dependencies: 167
-- Name: product_master_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_master_seqs', 0, true);


--
-- TOC entry 168 (class 1259 OID 271557)
-- Dependencies: 1889 1890 1891 6
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


ALTER TABLE public.purchase_payment_info OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 271563)
-- Dependencies: 6
-- Name: stock_alert; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stock_alert (
    id integer NOT NULL,
    product_master_id integer NOT NULL,
    type integer,
    min_val numeric(14,4),
    max_val numeric(14,4)
);


ALTER TABLE public.stock_alert OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 271566)
-- Dependencies: 6
-- Name: stock_alert_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE stock_alert_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_alert_seqs OWNER TO postgres;

--
-- TOC entry 1954 (class 0 OID 0)
-- Dependencies: 170
-- Name: stock_alert_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stock_alert_seqs', 0, true);


--
-- TOC entry 171 (class 1259 OID 271568)
-- Dependencies: 6
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


ALTER TABLE public.stock_deatils OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 271571)
-- Dependencies: 6
-- Name: stock_deatils_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE stock_deatils_seqs
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_deatils_seqs OWNER TO postgres;

--
-- TOC entry 1955 (class 0 OID 0)
-- Dependencies: 172
-- Name: stock_deatils_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stock_deatils_seqs', 0, true);


--
-- TOC entry 173 (class 1259 OID 271573)
-- Dependencies: 6
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


ALTER TABLE public.user_master OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 271579)
-- Dependencies: 6
-- Name: user_master_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_master_seqs
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_master_seqs OWNER TO postgres;

--
-- TOC entry 1956 (class 0 OID 0)
-- Dependencies: 174
-- Name: user_master_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_master_seqs', 1, false);


--
-- TOC entry 175 (class 1259 OID 271581)
-- Dependencies: 6
-- Name: user_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_type (
    id integer NOT NULL,
    user_type character varying(64),
    description character varying(1024)
);


ALTER TABLE public.user_type OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 271587)
-- Dependencies: 6
-- Name: user_type_seqs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_type_seqs
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_type_seqs OWNER TO postgres;

--
-- TOC entry 1957 (class 0 OID 0)
-- Dependencies: 176
-- Name: user_type_seqs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_type_seqs', 1, false);


--
-- TOC entry 1936 (class 0 OID 271534)
-- Dependencies: 161
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY branch (id, branch_name, branch_code) FROM stdin;
1	Durgapur	DGP
2	Bankura	BNK
\.


--
-- TOC entry 1937 (class 0 OID 271539)
-- Dependencies: 163
-- Data for Name: product_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY product_details (id, weight, quantity, type, product_master_id, purchase_date, amount, vat, branch_id, user_master_id, k_and_p, sale_quantity, is_available, comments, deleted, purchase_payment_info_ref) FROM stdin;
\.


--
-- TOC entry 1938 (class 0 OID 271549)
-- Dependencies: 165
-- Data for Name: product_group_map; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY product_group_map (id, code) FROM stdin;
\.


--
-- TOC entry 1939 (class 0 OID 271552)
-- Dependencies: 166
-- Data for Name: product_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY product_master (id, product_name, product_code, unit_of_measure, unit_type, group_id) FROM stdin;
\.


--
-- TOC entry 1940 (class 0 OID 271557)
-- Dependencies: 168
-- Data for Name: purchase_payment_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY purchase_payment_info (id, company_name, bill_no, payment, balance, advance) FROM stdin;
\.


--
-- TOC entry 1941 (class 0 OID 271563)
-- Dependencies: 169
-- Data for Name: stock_alert; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY stock_alert (id, product_master_id, type, min_val, max_val) FROM stdin;
\.


--
-- TOC entry 1942 (class 0 OID 271568)
-- Dependencies: 171
-- Data for Name: stock_deatils; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY stock_deatils (id, product_code, product_name, quantity, weight, unit_of_measure, product_master_id, branch_id, k_and_p, type) FROM stdin;
\.


--
-- TOC entry 1943 (class 0 OID 271573)
-- Dependencies: 173
-- Data for Name: user_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_master (id, user_name, password, first_name, middle_name, last_name, mobile, email_id, address, user_type_id) FROM stdin;
1	admin	admin	Surat	\N	Sashmal	\N	\N	\N	1
\.


--
-- TOC entry 1944 (class 0 OID 271581)
-- Dependencies: 175
-- Data for Name: user_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_type (id, user_type, description) FROM stdin;
1	SUPERUSER	User having admin role
2	PURCHASE	User having purchase entry role
3	SALES	User having sales role
4	VIEWONLY	User having view only role
\.


--
-- TOC entry 1893 (class 2606 OID 271590)
-- Dependencies: 161 161
-- Name: branch_bcode_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_bcode_uk UNIQUE (branch_code);


--
-- TOC entry 1895 (class 2606 OID 271592)
-- Dependencies: 161 161
-- Name: branch_name_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_name_uk UNIQUE (branch_name);


--
-- TOC entry 1897 (class 2606 OID 271594)
-- Dependencies: 161 161
-- Name: branch_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branch
    ADD CONSTRAINT branch_pk PRIMARY KEY (id);


--
-- TOC entry 1905 (class 2606 OID 271596)
-- Dependencies: 166 166
-- Name: prod_mast_prodcode_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT prod_mast_prodcode_uk UNIQUE (product_code);


--
-- TOC entry 1907 (class 2606 OID 271598)
-- Dependencies: 166 166
-- Name: prod_mast_prodname_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT prod_mast_prodname_uk UNIQUE (product_name);


--
-- TOC entry 1899 (class 2606 OID 271600)
-- Dependencies: 163 163
-- Name: product_details_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT product_details_pk PRIMARY KEY (id);


--
-- TOC entry 1901 (class 2606 OID 271602)
-- Dependencies: 165 165
-- Name: product_group_map_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_group_map
    ADD CONSTRAINT product_group_map_pk PRIMARY KEY (id);


--
-- TOC entry 1903 (class 2606 OID 271604)
-- Dependencies: 165 165
-- Name: product_group_map_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_group_map
    ADD CONSTRAINT product_group_map_uk UNIQUE (code);


--
-- TOC entry 1909 (class 2606 OID 271606)
-- Dependencies: 166 166
-- Name: product_master_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT product_master_pk PRIMARY KEY (id);


--
-- TOC entry 1911 (class 2606 OID 271608)
-- Dependencies: 168 168
-- Name: purchase_payment_info_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY purchase_payment_info
    ADD CONSTRAINT purchase_payment_info_pk PRIMARY KEY (id);


--
-- TOC entry 1913 (class 2606 OID 271610)
-- Dependencies: 169 169
-- Name: stock_alert_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_pk PRIMARY KEY (id);


--
-- TOC entry 1915 (class 2606 OID 271612)
-- Dependencies: 169 169 169
-- Name: stock_alert_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_uk UNIQUE (product_master_id, type);


--
-- TOC entry 1917 (class 2606 OID 271614)
-- Dependencies: 171 171
-- Name: stock_deatils_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_pk PRIMARY KEY (id);


--
-- TOC entry 1919 (class 2606 OID 271616)
-- Dependencies: 171 171 171 171 171
-- Name: stock_deatils_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_uk UNIQUE (product_name, unit_of_measure, branch_id, type);


--
-- TOC entry 1921 (class 2606 OID 271618)
-- Dependencies: 173 173
-- Name: user_master_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_master_pk PRIMARY KEY (id);


--
-- TOC entry 1923 (class 2606 OID 271620)
-- Dependencies: 173 173
-- Name: user_master_uname_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_master_uname_uk UNIQUE (user_name);


--
-- TOC entry 1925 (class 2606 OID 271622)
-- Dependencies: 175 175
-- Name: user_type_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_type
    ADD CONSTRAINT user_type_pk PRIMARY KEY (id);


--
-- TOC entry 1935 (class 2620 OID 271623)
-- Dependencies: 189 163
-- Name: product_det_aftins_tri; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER product_det_aftins_tri AFTER INSERT ON product_details FOR EACH ROW EXECUTE PROCEDURE product_det_aftins_tri_fun();


--
-- TOC entry 1926 (class 2606 OID 271624)
-- Dependencies: 163 161 1896
-- Name: prod_det_branchid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_branchid_fk FOREIGN KEY (branch_id) REFERENCES branch(id);


--
-- TOC entry 1929 (class 2606 OID 271660)
-- Dependencies: 163 168 1910
-- Name: prod_det_paymentinfo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_paymentinfo_fk FOREIGN KEY (purchase_payment_info_ref) REFERENCES purchase_payment_info(id);


--
-- TOC entry 1927 (class 2606 OID 271629)
-- Dependencies: 1908 166 163
-- Name: prod_det_prodmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_prodmastid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 1928 (class 2606 OID 271634)
-- Dependencies: 1920 173 163
-- Name: prod_det_usrmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_details
    ADD CONSTRAINT prod_det_usrmastid_fk FOREIGN KEY (user_master_id) REFERENCES user_master(id);


--
-- TOC entry 1930 (class 2606 OID 271665)
-- Dependencies: 166 165 1900
-- Name: product_master_groupid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_master
    ADD CONSTRAINT product_master_groupid_fk FOREIGN KEY (group_id) REFERENCES product_group_map(id);


--
-- TOC entry 1931 (class 2606 OID 271639)
-- Dependencies: 169 166 1908
-- Name: stock_alert_prodmasid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_alert
    ADD CONSTRAINT stock_alert_prodmasid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 1932 (class 2606 OID 271644)
-- Dependencies: 171 1896 161
-- Name: stock_deatils_branid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_deatils_branid_fk FOREIGN KEY (branch_id) REFERENCES branch(id);


--
-- TOC entry 1933 (class 2606 OID 271649)
-- Dependencies: 166 1908 171
-- Name: stock_det_prodmastid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock_deatils
    ADD CONSTRAINT stock_det_prodmastid_fk FOREIGN KEY (product_master_id) REFERENCES product_master(id);


--
-- TOC entry 1934 (class 2606 OID 271654)
-- Dependencies: 1924 173 175
-- Name: user_mast_usrtypeid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_master
    ADD CONSTRAINT user_mast_usrtypeid_fk FOREIGN KEY (user_type_id) REFERENCES user_type(id);


--
-- TOC entry 1949 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-10-14 20:34:24

--
-- PostgreSQL database dump complete
--

