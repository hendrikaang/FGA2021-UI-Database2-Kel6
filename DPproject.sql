--Drop all tables if they exist
DROP TABLE r_discount_histories;
DROP TABLE r_supplies;
DROP TABLE r_suppliers;
DROP TABLE r_items;
DROP TABLE r_products;
DROP TABLE r_salary_histories;
DROP TABLE r_transactions;
DROP TABLE r_employees;
DROP TABLE r_stores;
DROP TABLE r_customers;
DROP TABLE r_locations;
DROP SEQUENCE transaction_id_seq;
DROP SEQUENCE people_id_seq;
DROP SEQUENCE store_id_seq;
DROP SEQUENCE supplier_id_sed;
DROP SYNONYM  trx_seq;
DROP SYNONYM  ppe_seq;
DROP SYNONYM  sre_seq;
DROP SYNONYM  spr_seq;


CREATE TABLE r_LOCATIONS (
postal_code NUMBER(5) CONSTRAINT r_LOCATIONS_pk PRIMARY KEY,
district VARCHAR2(50) NOT NULL,
regency VARCHAR2(50) NOT NULL,
province VARCHAR2(50) NOT NULL
);

CREATE TABLE r_CUSTOMERS (
customer_id NUMBER(5) CONSTRAINT r_customers_pk PRIMARY KEY,
NIK NUMBER(16) NOT NULL,
phone_number NUMBER(13) NOT NULL,
customer_name VARCHAR2(50) NOT NULL,
address VARCHAR2(100) NOT NULL,
email VARCHAR2(50),
point INTEGER,
postal_code NUMBER(5) NOT NULL,
CONSTRAINT r_cust_postal_code_fk FOREIGN KEY (postal_code)
REFERENCES R_LOCATIONS(postal_code) ON DELETE SET NULL
);

CREATE TABLE r_STORES (
store_id NUMBER(5) CONSTRAINT r_STORES_pk PRIMARY KEY,
phone_number NUMBER(13) NOT NULL,
store_name VARCHAR2(50) NOT NULL,
address VARCHAR2(100) NOT NULL,
NPWP NUMBER(15),
postal_code NUMBER(5) NOT NULL,
CONSTRAINT r_stor_postal_code_fk FOREIGN KEY (postal_code)
REFERENCES R_LOCATIONS(postal_code) ON DELETE SET NULL
);

CREATE TABLE r_EMPLOYEES (
employee_id NUMBER(5) CONSTRAINT r_EMPLOYEES_pk PRIMARY KEY,
NIK NUMBER(16) NOT NULL,
phone_number NUMBER(13) NOT NULL,
employee_name VARCHAR2(50) NOT NULL,
address VARCHAR2(100) NOT NULL,
email VARCHAR2(50) NOT NULL,
bank_account VARCHAR2(30) NOT NULL,
postal_code NUMBER(5) NOT NULL,
store_id NUMBER(5) NOT NULL,
CONSTRAINT r_emps_postal_code_fk FOREIGN KEY (postal_code)
REFERENCES R_LOCATIONS(postal_code) ON DELETE SET NULL,
CONSTRAINT r_emps_store_id_fk FOREIGN KEY (store_id)
REFERENCES R_STORES(store_id) ON DELETE SET NULL
);

CREATE TABLE r_TRANSACTIONS (
transaction_id NUMBER(5,0) CONSTRAINT r_trx_pk PRIMARY KEY,
transaction_date DATE NOT NULL,
payment_type VARCHAR2(20) NOT NULL,
total_transaction INTEGER NOT NULL,
customer_id NUMBER(5,0),
employee_id NUMBER(5,0),
CONSTRAINT r_trx_cust_id_fk FOREIGN KEY (customer_id)
REFERENCES r_CUSTOMERS(customer_id) ON DELETE SET NULL,
CONSTRAINT r_trx_emps_id_fk FOREIGN KEY (employee_id)
REFERENCES r_EMPLOYEES(employee_id) ON DELETE SET NULL
);

CREATE TABLE r_SALARY_HISTORIES (
start_date_salary DATE NOT NULL,
end_date_salary DATE,
wages INTEGER NOT NULL,
description VARCHAR2(50),
PIC VARCHAR2(50) NOT NULL,
employee_id NUMBER(5) NOT NULL,
CONSTRAINT r_slr_emps_id_fk FOREIGN KEY (employee_id)
REFERENCES R_EMPLOYEES(employee_id) ON DELETE SET NULL,
CONSTRAINT r_slr_start_emps_id_pk PRIMARY KEY(start_date_salary,employee_id)
);

CREATE TABLE r_PRODUCTS (
product_id NUMBER(15) CONSTRAINT r_products_pk PRIMARY KEY,
product_name VARCHAR2(50) NOT NULL,
price DECIMAL(10,2) NOT NULL,
stock INTEGER NOT NULL,
expire_date DATE,
store_id NUMBER(5) NOT NULL,
CONSTRAINT r_prod_store_id_fk FOREIGN KEY (store_id)
REFERENCES R_STORES(store_id) ON DELETE SET NULL
);

CREATE TABLE r_ITEMS (
transaction_id NUMBER(5) NOT NULL,
product_id NUMBER(15) NOT NULL,
quantity INTEGER,
CONSTRAINT r_itm_trx_id_fk FOREIGN KEY (transaction_id)
REFERENCES R_TRANSACTIONS(transaction_id) ON DELETE SET NULL,
CONSTRAINT r_itm_prod_id_fk FOREIGN KEY (product_id)
REFERENCES R_PRODUCTS(product_id) ON DELETE SET NULL,
CONSTRAINT r_itm_trx_prod_id_pk PRIMARY KEY(transaction_id,product_id)
);

CREATE TABLE r_SUPPLIERS (
supplier_id NUMBER(5) CONSTRAINT r_suppliers_pk PRIMARY KEY,
phone_number NUMBER(13) NOT NULL,
supplier_name VARCHAR2(50) NOT NULL,
email VARCHAR2(50) NOT NULL,
address VARCHAR2(100) NOT NULL,
postal_code NUMBER(5) NOT NULL,
CONSTRAINT r_suppliers_postal_code_fk FOREIGN KEY (postal_code)
REFERENCES R_LOCATIONS(postal_code) ON DELETE SET NULL
);

CREATE TABLE r_SUPPLIES (
supply_date DATE NOT NULL,
supplier_id NUMBER(5) NOT NULL,
product_id NUMBER(15) NOT NULL,
quantity INTEGER,
CONSTRAINT r_supplies_supplier_id_fk FOREIGN KEY (supplier_id)
REFERENCES R_SUPPLIERS(supplier_id) ON DELETE SET NULL,
CONSTRAINT r_supplies_prod_id_fk FOREIGN KEY (product_id)
REFERENCES R_PRODUCTS(product_id) ON DELETE SET NULL,
CONSTRAINT r_supplies_supplier_prod_id_pk PRIMARY KEY(supplier_id,product_id,supply_date)
);

CREATE TABLE r_DISCOUNT_HISTORIES (
start_date_discount DATE NOT NULL,
end_date_discount DATE,
percentage DECIMAL(4,2) NOT NULL,
product_id NUMBER(15) NOT NULL,
CONSTRAINT r_disc_prod_id_fk FOREIGN KEY (product_id)
REFERENCES R_PRODUCTS(product_id) ON DELETE SET NULL,
CONSTRAINT r_disc_start_prod_id_pk PRIMARY KEY(start_date_discount,product_id)
);


--Create Sequence
CREATE SEQUENCE transaction_id_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE;

CREATE SEQUENCE people_id_seq;

CREATE SEQUENCE store_id_seq;

CREATE SEQUENCE supplier_id_sed;

CREATE SYNONYM  trx_seq FOR  transaction_id_seq;
CREATE SYNONYM  ppe_seq FOR people_id_seq;
CREATE SYNONYM  sre_seq FOR store_id_seq;
CREATE SYNONYM  spr_seq FOR supplier_id_sed;


--Insert Data
INSERT INTO r_locations (postal_code, district, regency, province)
	WITH location AS ( 
		SELECT 16436, 'Pancoran Mas', 'Kota Depok', 'Jawa Barat' FROM dual UNION ALL 
		SELECT 16439, 'Cipayung', 'Kota Depok', 'Jawa Barat' FROM dual UNION ALL 
		SELECT 16412, 'Sukmajaya', 'Kota Depok', 'Jawa Barat' FROM dual UNION ALL 
		SELECT 16431, 'Pancoran Mas', 'Kota Depok', 'Jawa Barat' FROM dual UNION ALL
		SELECT 16153, 'Bogor Utara', 'Kota Bogor', 'Jawa Barat' FROM dual
    ) 
	SELECT * FROM location;

INSERT INTO r_stores
VALUES
	(sre_seq.NEXTVAL, 085282731008, 'Stasiun Depok', 'GGS, Jl. St. Depok Lama, Depok', 092542943407000, 16431);

INSERT INTO r_employees
	(employee_id, nik, phone_number, employee_name, address, email, bank_account, postal_code, store_id)
VALUES
	(ppe_seq.NEXTVAL, 6273140804002001, 085246821145, 'Budi Susilawati', 'Jl. Raya Pajajaran No.102, RT.03/RW.12, Bantarjati', 'bs@gmail.com', 114359842555732, 16153, 1);

INSERT INTO r_salary_histories
VALUES
	('01-Aug-2021', '31-Jul-2023', 2100000, NULL, 'big boss', 1);

INSERT INTO r_customers (customer_id, nik, phone_number, customer_name, address, email, point, postal_code)
VALUES (ppe_seq.NEXTVAL, 3173050501000007, 085200827199,' Tania Karantina', 'Jl. Pitara No.96, RW.15, Pancoran MAS', 'takar@gmail.com', 0, 16436);
INSERT INTO r_customers (customer_id, nik, phone_number, customer_name, address, email, point, postal_code)
VALUES (ppe_seq.NEXTVAL, 3263131101998003, 081358923850, 'Salma Covidah', 'Jl. Matraman, Ratu Jaya', 'salma_cov@gmail.com', 0, 16439);
INSERT INTO r_customers (customer_id, nik, phone_number, customer_name, address, email, point, postal_code)
VALUES (ppe_seq.NEXTVAL, 6273140804002001, 087365900932, 'Maskur Yudhistira', 'Ruko Verbena D-16, Jl. Boulevard Grand Depok City, Tirtajaya', 'mas_yudhi@gmail.com', 103, 16412);

INSERT INTO r_products
	(product_id, product_name, price, stock, expire_date, store_id)
	WITH product AS (
		SELECT 8997019580772, 't-soft tissue 200', 3400, 500, TO_DATE('21-07-2024', 'dd-mm-yyyy'), 1 FROM dual UNION ALL
		SELECT 4902430403856, 'oral-b soft 3', 12500, 100, TO_DATE('19-11-2026', 'dd-mm-yyyy'), 1 FROM dual UNION ALL
		SELECT 8997213160114, 'beleaf soap 90gr', 8400, 96, TO_DATE('22-06-2023', 'dd-mm-yyyy'), 1 FROM dual UNION ALL
		SELECT 8996001305126, 'arden cookies 300gr', 16000, 240, TO_DATE('06-03-2022', 'dd-mm-yyyy'), 1 FROM dual UNION ALL
		SELECT 8998866500388, 'teh rio 180ml', 1000, 1000, TO_DATE('02-11-2021', 'dd-mm-yyyy'), 1 FROM dual UNION ALL
		SELECT 8991102222006, 'teh gelas 160ml', 1000, 1200, TO_DATE('06-08-2022', 'dd-mm-yyyy'), 1 FROM dual UNION ALL
		SELECT 6971174324619, 'alkindo mask 50', 21000, 85, TO_DATE('30-12-2024', 'dd-mm-yyyy'), 1 FROM dual UNION ALL
		SELECT 8999809700032, 'vicee vit c 500gr', 2500, 240, TO_DATE('01-07-2023', 'dd-mm-yyyy'), 1 FROM dual UNION ALL
		SELECT 8998009010590, 'ultramilk coklat 125ml', 3500, 120, TO_DATE('17-11-2020', 'dd-mm-yyyy'), 1 FROM dual UNION ALL
		SELECT 8993175549820, 'nabati raspberry yoghurt 132gr', 6000, 120, TO_DATE('09-07-2022', 'dd-mm-yyyy'), 1 FROM dual
	)
	SELECT * FROM product;

INSERT INTO r_suppliers
	(supplier_id, phone_number, supplier_name, email, address, postal_code)
VALUES
	(spr_seq.NEXTVAL, 085246821145, 'Budi Susilawati', 'bs@gmail.com', 'Jl. Raya Pajajaran No.102, RT.03/RW.12, Bantarjati', 16153);
    
INSERT INTO r_discount_histories
	(start_date_discount, end_date_discount, percentage, product_id)
VALUES
	('20-Sep-2021', '21-Sep-2021', 20, 8998009010590);

INSERT INTO r_supplies
	(supply_date, supplier_id, product_id, quantity)
VALUES
	('20-Sep-2021', 1, 8998009010590, 240);

INSERT INTO r_transactions (transaction_id, transaction_date, payment_type, total_transaction, customer_id, employee_id)
VALUES (trx_seq.NEXTVAL, TO_DATE('07-Sep-2021', 'dd-Mon-yyyy'), 'cash', 58500, 2, 1);
INSERT INTO r_transactions (transaction_id, transaction_date, payment_type, total_transaction, customer_id, employee_id)
VALUES (trx_seq.NEXTVAL, TO_DATE('07-Sep-2021', 'dd-Mon-yyyy'), 'cash', 79800, 4, 1);
INSERT INTO r_transactions (transaction_id, transaction_date, payment_type, total_transaction, customer_id, employee_id)
VALUES (trx_seq.NEXTVAL, TO_DATE('14-Sep-2021', 'dd-Mon-yyyy'), 'cash', 460000, 3, 1);
INSERT INTO r_transactions (transaction_id, transaction_date, payment_type, total_transaction, customer_id, employee_id)
VALUES (trx_seq.NEXTVAL, TO_DATE('14-Sep-2021', 'dd-Mon-yyyy'), 'cash', 120000, 2, 1);

INSERT INTO r_items
	(transaction_id, product_id, quantity)
	WITH items AS (
		SELECT 1, 8997019580772, 10 FROM dual UNION ALL
		SELECT 1, 4902430403856, 1 FROM dual UNION ALL
		SELECT 1, 8993175549820, 2 FROM dual UNION ALL
		SELECT 2, 8997213160114, 2 FROM dual UNION ALL
		SELECT 2, 6971174324619, 3 FROM dual UNION ALL
		SELECT 3, 8999809700032, 24 FROM dual UNION ALL
		SELECT 3, 6971174324619, 5 FROM dual UNION ALL
		SELECT 3, 8998009010590, 50 FROM dual UNION ALL
		SELECT 3, 8998866500388, 120 FROM dual UNION ALL
		SELECT 4, 8993175549820, 20 FROM dual
	)
	SELECT * FROM items;

CREATE OR REPLACE VIEW view_warehouse_problem
	AS SELECT s.store_name AS "Toko", p.product_name AS "Produk", p.stock AS "Stok", p.expire_date AS "Kedaluarsa", s.supplier_name AS "Supplier"
	FROM r_products p, r_stores s, r_suppliers s, r_supplies supply
	WHERE 
		p.store_id = s.store_id AND 
		p.product_id = supply.product_id AND 
		supply.supplier_id = s.supplier_id AND 
		(p.expire_date >= (SYSDATE + 30) OR
		p.stock <= 100)
	ORDER BY s.store_name, p.product_name;

