----------------------- 1 ---------------------------------
create table branch
(
 id integer not null,
 branch_name character varying(128) not null,
 branch_code character varying(128)
);
ALTER TABLE branch ADD CONSTRAINT branch_pk PRIMARY KEY(id);
ALTER TABLE branch ADD CONSTRAINT branch_name_uk UNIQUE(branch_name);
ALTER TABLE branch ADD CONSTRAINT branch_bcode_uk UNIQUE(branch_code);

insert into branch(id,branch_name,branch_code) values (1,'Durgapur','DGP');
insert into branch(id,branch_name,branch_code) values (2,'Bankura','BNK');

CREATE SEQUENCE branch_seqs START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
-----------------------------------------------------------

----------------------- 2 ---------------------------------
create table user_type
(
  id integer not null,
  user_type character varying(64),
  description character varying(1024) ---1 super user, 2 --> Purchase 3 --> Sales 4 --> view only
);
ALTER TABLE user_type ADD CONSTRAINT user_type_pk PRIMARY KEY(id);
insert into user_type(id,user_type,description) values (1,'SUPERUSER','User having admin role');
insert into user_type(id,user_type,description) values (2,'PURCHASE','User having purchase entry role');
insert into user_type(id,user_type,description) values (3,'SALES','User having sales role');
insert into user_type(id,user_type,description) values (4,'VIEWONLY','User having view only role');

CREATE SEQUENCE user_type_seqs START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

create table user_master
( 
 id integer not null,
 user_name character varying(64) not null,
 password character varying(128) not null,
 first_name character varying(64) not null,
 middle_name character varying(64),
 last_name character varying(64) not null,
 mobile character varying(20),
 email_id character varying(64),
 address character varying(2048),
 user_type_id integer not null 
);
ALTER TABLE user_master ADD CONSTRAINT user_master_pk PRIMARY KEY(id);
ALTER TABLE user_master ADD CONSTRAINT user_master_uname_uk UNIQUE(user_name);
ALTER TABLE user_master ADD CONSTRAINT user_mast_usrtypeid_fk FOREIGN KEY (user_type_id) REFERENCES user_type (id);

CREATE SEQUENCE user_master_seqs START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
------------------------------------------------------------


----------------------- 3 ---------------------------------
create table product_master
(
 id integer not null,
 product_name character varying(128) not null, --- unique
 product_code character varying(64), --- unique
 unit_of_measure integer not null -- 1 by weight, 2 by quantity
);
ALTER TABLE product_master ADD CONSTRAINT product_master_pk PRIMARY KEY(id);
ALTER TABLE product_master ADD CONSTRAINT prod_mast_prodname_uk UNIQUE(product_name);
ALTER TABLE product_master ADD CONSTRAINT prod_mast_prodcode_uk UNIQUE(product_code);
CREATE SEQUENCE product_master_seqs START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;


create table product_details
(
 id integer not null,
 weights numeric(14,4),
 quantity numeric(14,4),
 type integer, --1 --> High, 2-->  Middle 3 --> Low (if unit_of_measure=2 then it should be null)
 product_master_id integer not null, 
 purchase_date timestamp without time zone not null,
 amount numeric(14,4) not null,
 vat numeric(14,4),
 branch_id integer not null,
 user_master_id integer not null,
 k_and_p character varying(64),
 sale_quantity numeric(14,4),
 is_available boolean default true not null, 
 comments character varying(2048),
 deleted boolean default false not null
);
ALTER TABLE product_details ADD CONSTRAINT product_details_pk PRIMARY KEY(id);
ALTER TABLE product_details ADD CONSTRAINT prod_det_prodmastid_fk FOREIGN KEY (product_master_id) REFERENCES product_master (id);
ALTER TABLE product_details ADD CONSTRAINT prod_det_branchid_fk FOREIGN KEY (branch_id) REFERENCES branch (id);
ALTER TABLE product_details ADD CONSTRAINT prod_det_usrmastid_fk FOREIGN KEY (user_master_id) REFERENCES user_master (id);
CREATE SEQUENCE product_details_seqs START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;


create table stock_deatils
(
 id integer not null,
 product_code character varying(64),
 product_name character varying(128) not null,
 quantity numeric(14,4),
 weight numeric(14,4),
 unit_of_measure integer not null,
 product_master_id integer,
 branch_id integer not null,
 k_and_p character varying(64)
);
ALTER TABLE stock_deatils ADD CONSTRAINT stock_deatils_pk PRIMARY KEY(id);
ALTER TABLE stock_deatils ADD CONSTRAINT stock_deatils_uk UNIQUE(product_name,unit_of_measure,branch_id);
ALTER TABLE stock_deatils ADD CONSTRAINT stock_det_prodmastid_fk FOREIGN KEY (product_master_id) REFERENCES product_master (id);
ALTER TABLE stock_deatils ADD CONSTRAINT stock_deatils_branid_fk FOREIGN KEY (branch_id) REFERENCES branch (id);
CREATE SEQUENCE stock_deatils_seqs START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;


create table stock_alert
(
 id integer not null,
 product_master_id integer not null,
 type integer, --- 1-->high 2--->mid 3 --- low 
 min_val numeric(14,4),
 max_val numeric(14,4)
);
ALTER TABLE stock_alert ADD CONSTRAINT stock_alert_pk PRIMARY KEY(id);  
ALTER TABLE stock_alert ADD CONSTRAINT stock_alert_uk UNIQUE(product_master_id,type);
ALTER TABLE stock_alert ADD CONSTRAINT stock_alert_prodmasid_fk FOREIGN KEY (product_master_id) REFERENCES product_master (id);
CREATE SEQUENCE stock_alert_seqs START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
-----------------------------------------------------
CREATE OR REPLACE FUNCTION product_det_aftins_tri_fun()
  RETURNS trigger AS
$BODY$
DECLARE
ctr integer;
var_unit_of_measure integer;
BEGIN
	if(TG_OP='INSERT') then
	select unit_of_measure into var_unit_of_measure from product_master where id=NEW.product_master_id;
	if(NEW.type is null and var_unit_of_measure=2) then
		select count(id) into ctr from stock_deatils where product_master_id=NEW.product_master_id and unit_of_measure=2;
		if(ctr>0) then
			update stock_deatils set quantity=coalesce(quantity,0)+coalesce(NEW.quantity,0),weight=coalesce(weight,0)+coalesce(NEW.weight,0) where product_master_id=NEW.product_master_id and unit_of_measure=2;
		else
			insert into stock_deatils (id,product_code,product_name,quantity,weight,unit_of_measure,product_master_id,branch_id,k_and_p) values (nextval('stock_deatils_seqs'),(select product_code from product_master where id=NEW.product_master_id),(select product_name from product_master where id=NEW.product_master_id),NEW.quantity,NEW.weight,var_unit_of_measure,NEW.product_master_id,NEW.branch_id,NEW.k_and_p);
		end if;
	elsif(NEW.type is not null and var_unit_of_measure=1) then
		select count(id) into ctr from stock_deatils where product_master_id=NEW.product_master_id and unit_of_measure=1;
		if(ctr>0) then
			update stock_deatils set quantity=coalesce(quantity,0)+coalesce(NEW.quantity,0),weight=coalesce(weight,0)+coalesce(NEW.weight,0) where product_master_id=NEW.product_master_id and unit_of_measure=1;
		else
			insert into stock_deatils (id,product_code,product_name,quantity,weight,unit_of_measure,product_master_id,branch_id,k_and_p) values (nextval('stock_deatils_seqs'),(select product_code from product_master where id=NEW.product_master_id),(select product_name from product_master where id=NEW.product_master_id),NEW.quantity,NEW.weight,var_unit_of_measure,NEW.product_master_id,NEW.branch_id,NEW.k_and_p);
		end if;
	end if;
	end if;
return NEW;
END;
$BODY$
  LANGUAGE plpgsql;
CREATE TRIGGER product_det_aftins_tri AFTER INSERT ON product_details FOR EACH ROW EXECUTE PROCEDURE product_det_aftins_tri_fun();




