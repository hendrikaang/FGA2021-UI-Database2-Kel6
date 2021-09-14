# Minimarket ORACLE Database
#### Disusun oleh FGA2021-UI-Database2-Kel6:
- Abdullah Fadly
- Hendrika Anggriawan
- Dio Tri Ananda

## Minimarket Database
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

### 4. Create Sequences

### 5. Add Data to Tables

### 6. Create Indexes

### 7. Create Synonyms

### 8. Test Database
