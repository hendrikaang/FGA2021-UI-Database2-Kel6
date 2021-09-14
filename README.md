# Minimarket ORACLE Database
#### Disusun oleh FGA2021-UI-Database2-Kel6:
- Abdullah Fadly
- Hendrika Anggriawan
- Dio Tri Ananda

#### Table of content:
* [Pendahuluan](https://github.com/hendrikaang/FGA2021-UI-Database2-Kel6#pendahuluan)
* [1. Create Tables](https://github.com/hendrikaang/FGA2021-UI-Database2-Kel6#1-create-tables#1-create-tables)
* [2. Create Constraints](https://github.com/hendrikaang/FGA2021-UI-Database2-Kel6#2-create-constraints)
* [3. Create Views](https://github.com/hendrikaang/FGA2021-UI-Database2-Kel6#3-create-views)
* [4. Create Sequences](https://github.com/hendrikaang/FGA2021-UI-Database2-Kel6#4-create-sequences)
* [5. Add Data to Tables](https://github.com/hendrikaang/FGA2021-UI-Database2-Kel6#5-add-data-to-tables)
* [6. Create Indexes](https://github.com/hendrikaang/FGA2021-UI-Database2-Kel6#6-create-indexes)
* [7. Create Synonyms](https://github.com/hendrikaang/FGA2021-UI-Database2-Kel6#7-create-synonyms)
* [8. Test The Database](https://github.com/hendrikaang/FGA2021-UI-Database2-Kel6#8-test-database)

## Pendahuluan
Bagi perusahaan atau organisasi, keberadaan database (basis data) memiliki fungsi dan peran penting dalam mendukung proses bisnis agar lebih efektif dan efisien. Sebab, database merupakan salah satu komponen utama dalam sistem informasi, yang merupakan dasar dalam menyediakan suatu informasi bagi para pemakai (user).

Secara sederhana, database dapat diartikan sebagai kumpulan berbagai data dan informasi yang tersimpan dan tersusun di dalam komputer secara sistematik yang dapat diperiksa, diolah dengan menggunakan program komputer untuk mendapatkan informasi dari database tersebut. Perangkat lunak yang digunakan untuk mengelola dan memanggil database disebut dengan sistem Database Management System (DBMS).

Pemanfaatan dan pengolahan database yang baik di perusahaan, misalnya perusahaan ritel minimarket bisa membantu kasir lebih cepat bekerja mencari jumlah barang yang ada atau juga mencari harga barang yang dijual. Begitu juga bagi admin, dengan database bisa membuat pekerjaan lebih mudah seperti mencari stock barang yang paling dicari dan lainnya.

Secara garis besar, tahapan dalam membuat database diawali dengan memahami bisnis rule perusahaan, lalu membuat model database design, diakhiri dengan membuat implementasi program database secara fisik.

Pada laporan ini, akan dijabarkan langkah lebih detil pada tahapan pembuatan program implementasi program database yang diantaranya adalah pembuatan table (CREATE TABLE), penambahan constraint, penginputan data, membuat VIEW, menambahkan sequence, index, dan synonym, serta melakukan testing.


### 1. Create Tables
**CREATE TABLE** adalah perintah yang digunakan untuk membuat sebuah tabel di database. Format penulisan kueri dalam membuat tabel adalah sebagai berikut:
```sql
CREATE TABLE table_name
  (column data type [DEFAULT expression],
  column data type [DEFAULT expression],
  ……[ ] )
```
Pada ERD perusahaan ritel minimarket, terdapat 11 entitas yang saling berhubungan, sehingga dibutuhkan 11 tabel pada implementasi program. Berikut adalah gambar ERD yang akan diimplementasikan.
![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)

Berikut ini merupakan kode yang digunakan untuk membuat tabel yang dibutuhkan untuk mengimplementasikan ERD di atas.
#### Membuat tabel r_locations
```sql
CREATE TABLE r_LOCATIONS (
  postal_code NUMBER(5) CONSTRAINT r_LOCATIONS_pk PRIMARY KEY,
  district VARCHAR2(50) NOT NULL,
  regency VARCHAR2(50) NOT NULL,
  province VARCHAR2(50) NOT NULL
);
```
#### Membuat tabel r_customers
```sql
CREATE TABLE r_CUSTOMERS (
  customer_id NUMBER(5) CONSTRAINT r_customers_pk PRIMARY KEY,
  NIK NUMBER(16) NOT NULL,
  phone_number NUMBER(13) NOT NULL,
  customer_name VARCHAR2(50) NOT NULL,
  address VARCHAR2(100) NOT NULL,
  email VARCHAR2(50),
  point INTEGER,
  postal_code NUMBER(5) NOT NULL
);
```
#### Membuat tabel r_stores
```sql
CREATE TABLE r_STORES (
  store_id NUMBER(5) CONSTRAINT r_STORES_pk PRIMARY KEY,
  phone_number NUMBER(13) NOT NULL,
  store_name VARCHAR2(50) NOT NULL,
  address VARCHAR2(100) NOT NULL,
  NPWP NUMBER(15),
  postal_code NUMBER(5) NOT NULL
);
```
#### Membuat tabel r_employees
```sql
CREATE TABLE r_EMPLOYEES (
  employee_id NUMBER(5) CONSTRAINT r_EMPLOYEES_pk PRIMARY KEY,
  NIK NUMBER(16) NOT NULL,
  phone_number NUMBER(13) NOT NULL,
  employee_name VARCHAR2(50) NOT NULL,
  address VARCHAR2(100) NOT NULL,
  email VARCHAR2(50) NOT NULL,
   bank_account VARCHAR2(30) NOT NULL,
  postal_code NUMBER(5) NOT NULL,
  store_id NUMBER(5) NOT NULL
);
```
#### Membuat tabel r_transactions
```sql
CREATE TABLE r_TRANSACTIONS (
  transaction_id NUMBER(5,0) CONSTRAINT r_trx_pk PRIMARY KEY,
  transaction_date DATE NOT NULL,
  payment_type VARCHAR2(20) NOT NULL,
  total_transaction INTEGER NOT NULL,
  customer_id NUMBER(5,0),
  employee_id NUMBER(5,0)
);
```
#### Membuat tabel r_salary_histories
```sql
CREATE TABLE r_SALARY_HISTORIES (
  start_date_salary DATE NOT NULL,
  end_date_salary DATE,
  wages INTEGER NOT NULL,
  description VARCHAR2(50),
  PIC VARCHAR2(50) NOT NULL,
  employee_id NUMBER(5) NOT NULL
  CONSTRAINT r_slr_start_emps_id_pk PRIMARY KEY(start_date_salary,employee_id)
);
```
#### Membuat tabel r_products
```sql
CREATE TABLE r_PRODUCTS (
  product_id NUMBER(15) CONSTRAINT r_products_pk PRIMARY KEY,
  product_name VARCHAR2(50) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  stock INTEGER NOT NULL,
  expire_date DATE,
  store_id NUMBER(5) NOT NULL
);
```
#### Membuat tabel r_items
```sql
CREATE TABLE r_ITEMS (
  transaction_id NUMBER(5) NOT NULL,
  product_id NUMBER(15) NOT NULL,
  quantity INTEGER
  CONSTRAINT r_itm_trx_prod_id_pk PRIMARY KEY(transaction_id,product_id)
);
```
#### Membuat tabel r_suppliers
```sql
CREATE TABLE r_SUPPLIERS (
  supplier_id NUMBER(5) CONSTRAINT r_suppliers_pk PRIMARY KEY,
  phone_number NUMBER(13) NOT NULL,
  supplier_name VARCHAR2(50) NOT NULL,
  email VARCHAR2(50) NOT NULL,
  address VARCHAR2(100) NOT NULL,
  postal_code NUMBER(5) NOT NULL
);
```
#### Membuat tabel r_supplies
```sql
CREATE TABLE r_SUPPLIES (
  supply_date DATE NOT NULL,
  supplier_id NUMBER(5) NOT NULL,
  product_id NUMBER(15) NOT NULL,
  quantity INTEGER
);
```
#### Membuat tabel r_discount_histories
```sql
CREATE TABLE r_DISCOUNT_HISTORIES (
  start_date_discount DATE NOT NULL,
  end_date_discount DATE,
  percentage DECIMAL(4,2) NOT NULL,
  product_id NUMBER(15) NOT NULL
  CONSTRAINT r_disc_start_prod_id_pk PRIMARY KEY(start_date_discount,product_id)
);
```


### 2. Create Constraints
Constraint di SQL adalah sebuah opsi atau atribut yang berfungsi untuk membatasi nilai setiap data yang akan dimasukkan dalam suatu kolom di dalam tabel database SQL. Ini memastikan keakuratan dan keandalan data dalam database. Batasan bisa berupa level kolom atau level tabel. Batasan level kolom diterapkan hanya untuk satu kolom, sedangkan batasan level tabel diterapkan ke seluruh tabel. Format penulisan kueri untuk constraint adalah sebagai berikut:
```sql
CREATE TABLE table_name
  (column data type [DEFAULT expression] CONSTRAINT name_constraint_given CONSTRAINT_TYPE,
  column data type [DEFAULT expression] CONSTRAINT name_constraint_given CONSTRAINT_TYPE ,
……[ ] );
```
Keterangan:

Constraint | Penjelasan
---------- | -------------
NOT NULL | Menentukan suatu kokom tidak boleh berisi NULL
UNIQUE | Untuk mencegah suatu kolom memiliki 2 baris atau lebih berisi data yang sama
PRIMARY KEY | Mengkombinasikan constraint NOT NULL dan UNIQUE dalam satu deklarasi. Mengidentifikasi secara unik setiap baris pada tabel
FOREIGN KEY |Memaksakan nilai pada suatu tabel untuk bernilai sama dengan tabel lain
CHECK | Menentukan suatu kondisi yang harus benar


#### Membuat constraint r_locations
```sql
CREATE TABLE r_LOCATIONS (
  postal_code NUMBER(5) CONSTRAINT r_LOCATIONS_pk PRIMARY KEY,
  district VARCHAR2(50) NOT NULL,
  regency VARCHAR2(50) NOT NULL,
  province VARCHAR2(50) NOT NULL
);
```
#### Membuat constraint r_customers
```sql
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
```
#### Membuat constraint r_stores
```sql
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
```
#### Membuat constraint r_employees
```sql
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
```
#### Membuat constraint r_transactions
```sql
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
```
#### Membuat constraint r_salary_histories
```sql
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
```
#### Membuat constraint r_products
```sql
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
```
#### Membuat constraint r_items
```sql
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
```
#### Membuat constraint r_suppliers
```sql
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
```
#### Membuat constraint r_supplies
```sql
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
```
#### Membuat constraint r_discount_histories
```sql
CREATE TABLE r_DISCOUNT_HISTORIES (
  start_date_discount DATE NOT NULL,
  end_date_discount DATE,
  percentage DECIMAL(4,2) NOT NULL,
  product_id NUMBER(15) NOT NULL,
  CONSTRAINT r_disc_prod_id_fk FOREIGN KEY (product_id)
  REFERENCES R_PRODUCTS(product_id) ON DELETE SET NULL,
  CONSTRAINT r_disc_start_prod_id_pk PRIMARY KEY(start_date_discount,product_id)
);
```

### 3. Create Views
View dapat digunakan untuk memudahkan pengguna yang bukan seorang DBA dalam menggunakan query. Berikut adalah syntax penggunaan views.
```sql
CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW view_name [(alias[,alias...])] AS subquery
[WITH CHECK OPTION [CONSTRAINT constraint]]
[WITH READ ONLY [CONSTRAINT constraint]]
```

Berikut adalah salah satu contoh penggunaan view. View di bawah ini digunakan untuk menampilkan nama toko, daftar produk, stok, tanggal kedaluarsa, dan supplier produk-produk yang stoknya tinggal sedikit atau produk yang akan segera kedaluarsa.
![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)
```sql
CREATE OR REPLACE VIEW view_warehouse_problem
	AS SELECT s.store_name AS "Toko", 
  p.product_name AS "Produk", 
  p.stock AS "Stok", 
  p.expire_date AS "Kedaluarsa", 
  s.supplier_name AS "Supplier"
FROM r_products p, r_stores s, r_suppliers s, r_supplies supply
WHERE 
	p.store_id = s.store_id AND
	p.product_id = supply.product_id AND
	supply.supplier_id = s.supplier_id AND 
	(p.expire_date >= (SYSDATE + 30) OR p.stock <= 1000);
```

### 4. Create Sequences
Sequence biasa digunakan untuk membuat penomoran otomatis. Berikut adalah syntax pembuatan sequence.
```sql
CREATE SEQUENCE sequence_name
[INCREMENT BY n]
[START WITH n]
[MAXVALUE n | NOMAXVALUE]
[MINVALUE n | NOMINVALUE]
[CYCLE | NOCYCLE]
[CACHE | NOCACHE]
```
Di dalam project ini, sequence digunakan untuk membantu memberi id untuk tabel r_transactions, r_customers, r_employees, r_stores, r_suppliers. Berikut adalah kode yang digunakan.
```sql
CREATE SEQUENCE transaction_id_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE;
CREATE SEQUENCE people_id_seq;
CREATE SEQUENCE store_id_seq;
CREATE SEQUENCE supplier_id_sed;
```

### 5. Add Data to Tables
Untuk menambahkan data ke dalam tabel, digunakan perintah INSERT. Insert memiliki syntax yang cukup mudah untuk memasukkan data satu-persatu. Untuk memasukkan data beberapa baris sekaligus, syntaxnya sedikit berbeda. Berikut adalah syntax insert untuk menambahkan 1 baris data.
```sql
INSERT INTO table_name
	(column_name_1, column_name_2,...)
VALUES
	(value_column_1, value_column_2,...);
```
Ada banyak data contoh yang kami masukkan, cara menginputnnya pun juga beragam:
#### Cara 1
Caranya yaitu hanya menyertakan konten barisnya tanpa menuliskan kolom-kolomnya. Cara yang pertama ini cukup tidak direkomendasikan karena kita harus tahu betul bagaimana database disimpan di dalam sistem. Kita harus tahu pasti bagaimana urutannya dan ketentuan-ketentuannya.
```sql
INSERT INTO r_stores
VALUES
	(sre_seq.NEXTVAL, 085282731008, 'Stasiun Depok', 'GGS, Jl. St. Depok Lama, Depok', 092542943407000, 16431);

INSERT INTO r_salary_histories
VALUES
	('01-Aug-2021', '31-Jul-2023', 2100000, NULL, 'big boss', 1);
```
#### Cara 2
Caranya mirip dengan cara 1 namun dengan menuliskan kolom-kolomnya. Cara ini lebih direkomendasikan untuk memasukkan data satu-persatu ke dalam sistem. Juga dengan cara ini, kita bisa menggunakan sequence di dalamnya.
```sql
-- Memasukkan data employee
INSERT INTO r_employees
	(employee_id, nik, phone_number, employee_name, address, email, bank_account, postal_code, store_id)
VALUES
	(ppe_seq.NEXTVAL, 6273140804002001, 085246821145, 'Budi Susilawati', 'Jl. Raya Pajajaran No.102, RT.03/RW.12, Bantarjati', 'bs@gmail.com', 114359842555732, 16153, 1);

-- Memasukkan data customer
INSERT INTO r_customers (customer_id, nik, phone_number, customer_name, address, email, point, postal_code)
VALUES (ppe_seq.NEXTVAL, 3173050501000007, 085200827199,' Tania Karantina', 'Jl. Pitara No.96, RW.15, Pancoran MAS', 'takar@gmail.com', 0, 16436);
INSERT INTO r_customers (customer_id, nik, phone_number, customer_name, address, email, point, postal_code)
VALUES (ppe_seq.NEXTVAL, 3263131101998003, 081358923850, 'Salma Covidah', 'Jl. Matraman, Ratu Jaya', 'salma_cov@gmail.com', 0, 16439);
INSERT INTO r_customers (customer_id, nik, phone_number, customer_name, address, email, point, postal_code)
VALUES (ppe_seq.NEXTVAL, 6273140804002001, 087365900932, 'Maskur Yudhistira', 'Ruko Verbena D-16, Jl. Boulevard Grand Depok City, Tirtajaya', 'mas_yudhi@gmail.com', 103, 16412);

-- Memasukkan data supplier
INSERT INTO r_suppliers
	(supplier_id, phone_number, supplier_name, email, address, postal_code)
VALUES
	(spr_seq.NEXTVAL, 085246821145, 'Budi Susilawati', 'bs@gmail.com', 'Jl. Raya Pajajaran No.102, RT.03/RW.12, Bantarjati', 16153);

-- Memasukkan data histori diskon
INSERT INTO r_discount_histories
	(start_date_discount, end_date_discount, percentage, product_id)
VALUES
	('20-Sep-2021', '21-Sep-2021', 20, 8998009010590);

-- Memasukkan data supplies
INSERT INTO r_supplies
	(supply_date, supplier_id, product_id, quantity)
VALUES
	('20-Sep-2021', 1, 8998009010590, 240);

-- Memasukkan data transaksi
INSERT INTO r_transactions (transaction_id, transaction_date, payment_type, total_transaction, customer_id, employee_id)
VALUES (trx_seq.NEXTVAL, TO_DATE('07-Sep-2021', 'dd-Mon-yyyy'), 'cash', 58500, 2, 1);
INSERT INTO r_transactions (transaction_id, transaction_date, payment_type, total_transaction, customer_id, employee_id)
VALUES (trx_seq.NEXTVAL, TO_DATE('07-Sep-2021', 'dd-Mon-yyyy'), 'cash', 79800, 4, 1);
INSERT INTO r_transactions (transaction_id, transaction_date, payment_type, total_transaction, customer_id, employee_id)
VALUES (trx_seq.NEXTVAL, TO_DATE('14-Sep-2021', 'dd-Mon-yyyy'), 'cash', 460000, 3, 1);
INSERT INTO r_transactions (transaction_id, transaction_date, payment_type, total_transaction, customer_id, employee_id)
VALUES (trx_seq.NEXTVAL, TO_DATE('14-Sep-2021', 'dd-Mon-yyyy'), 'cash', 120000, 2, 1);
```
#### Cara 3
Cara ini digunakan untuk memasukkan *multirow data* sehingga kita bisa memasukkan beberapa baris data sekaligus. Caranya dengan menggunakan bantuan tabel DUAL. Apabila kita mau menggunakan cara ini, kita jadi tidak bisa menggunakan sequence.
```sql
INSERT INTO r_locations (postal_code, district, regency, province)
	WITH location AS ( 
		SELECT 16436, 'Pancoran Mas', 'Kota Depok', 'Jawa Barat' FROM dual UNION ALL 
		SELECT 16439, 'Cipayung', 'Kota Depok', 'Jawa Barat' FROM dual UNION ALL 
		SELECT 16412, 'Sukmajaya', 'Kota Depok', 'Jawa Barat' FROM dual UNION ALL 
		SELECT 16431, 'Pancoran Mas', 'Kota Depok', 'Jawa Barat' FROM dual UNION ALL
		SELECT 16153, 'Bogor Utara', 'Kota Bogor', 'Jawa Barat' FROM dual
    ) 
	SELECT * FROM location;

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
```

### 6. Create Indexes
Pada database, index merupakan sebuah struktur data yang berisi kumpulan keys beserta referensinya ke actual data di table. Tujuannya untuk memepercepat proses penentuan lokasi data tanpa melakukan pencarian secara penuh pada keseluruh data (full scan). Format penulisan kueri untuk index adalah sebagai berikut:
```sql
CREATE INDEX nama_index ON nama_tabel(nama_field1,nama_field2,…);
```
Pada tabel discount_history yang telah dibuat, akan ditambahkan index dengan kueri sebagai berikut:
```sql
CREATE INDEX discount_idx ON r_discount_histories(start_date_discount,end_date_discount);
```

### 7. Create Synonyms
Synonim adalah obyek-obyek database yang memungkinkan untuk memanggil suatu tabel dengan nama lain. Create synonym berguna untuk menganti atau menyingkat nama yang sulit diingat dari sebuah objek. User dapat mengakses data pada tabel yang berisis informasi yang sensitif dan privat melalui synonym tanpa harus mengetahui nama tabel aslinya.
Format penulisan kueri untuk synonim adalah sebagai berikut:
```sql
CREATE [OR REPLACE] [PUBLIC] SYNONYM  nama_synonim FOR  nama_schema.object;
```
Pada database yang telah dibuat, akan ditambahkan synonym dengan kueri sebagai berikut:
```sql
CREATE SYNONYM  trx_seq FOR  transaction_id_seq;
CREATE SYNONYM  ppe_seq FOR people_id_seq;
CREATE SYNONYM  sre_seq FOR store_id_seq;
CREATE SYNONYM  spr_seq FOR supplier_id_sed;
```

### 8. Test Database
Test Num | Date | Test Description | Input | Expected Output | Result
-------- | ---- | ---------------- | ----- | --------------- | ------
1 | 12/09/2021 | Confirm NOT NULL constraint on postal_code in r_locations | INSERT INTO r_locations (postal_code, district, regency, province) VALUES (NULL, 'Bogor Utara', 'Kota Bogor', 'Jawa Barat'); | Cannot insert NULL | ORA-01400: cannot insert NULL into ("ID_A848_SQL_S02"."R_LOCATIONS"."POSTAL_CODE
2 | 12/09/2021 | Confirm PRIMARY KEY constraint on EMPLOYEE_ID in EMPLOYEES table where data value  must be unique and not null | INSERT INTO EMPLOYEES (EMPLOYEE_id) VALUES(NULL) \n INSERT INTO EMPLOYEES(EMPLOYEE_id) VALUES(‘JB01’) | Cannot insert NULL and non-uniqe value | ORA-01400: cannot insert NULL into ("ID_A848_SQL_S02"."EMPLOYEES"."EMPLOYEE_ID") \n ORA-00001: unique constraint (ID_A848_SQL_S02.EMPLOYEE_ID_PK) violated
3 | 12/09/2021 | Confirm  FOREIGN KEY constraint using ON DELETE CASCADE option on postal_code in STORE tabl from postal_code as parent table | DELETE FROM postal_code WHERE postal_code='OX9 9ZB' | Deleted province province_id value in the postal code is also deleted in STORES table are deleted | postal_code= 'OX9 9ZB' deletd in STORES table
4 | 12/09/2021 | Display PRODUCTS information |  SELECT  * from ITEMS  \n   SELECT * from SUPPLIES | item product  \n  information displayed, supplies product information displayed | item product information displayed  \n  supplie product information displayed
6 | 12/09/2021 | Display view view_warehouse_problem | SELECT * from view_warehouse_problem | View view_warehouse_problem | View view_warehouse_problem displayed
7 | 12/09/2021 | Display discount history information by using index discount_histories | select * from all_indexes where table_name = 'r_discount_histories' ; | discount history information | discount history information


