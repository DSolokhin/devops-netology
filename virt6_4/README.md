**Задача 1**  
```
\l - вывод списка БД
\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo} connect to new database (currently "postgres") - подключение к БД  
\dt[S+] [PATTERN] - вывод списка таблиц  
\d[S+]  NAME - вывод описания содержимого таблиц  
\q - выход из psql
```

**Задача 2**  
```
postgres@spb-mon-serv:/$ psql -f /pgvolume/dump.sql test_database
SET
SET
SET
SET
SET
 set_config 
------------
 
(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval 
--------
      8
(1 row)

ALTER TABLE
```
```
postgres=# analyze verbose orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
```
```
postgres=# select avg_width from pg_stats where tablename='orders';
 avg_width 
-----------
         4
        16
         4
(3 rows)
```

**Задача 3**  

Избежать разбиения таблицы вручную можно было, если определить тип при проектировании и создании partitioned table. 

```
select * from payment 

SELECT DISTINCT DATE_TRUNC('month', payment_date) 
FROM payment


CREATE TABLE payment_05_2005 
(CHECK (DATE_TRUNC('month', payment_date) = '01.05.2005')) INHERITS (payment);

CREATE TABLE payment_06_2005 
(CHECK (DATE_TRUNC('month', payment_date) = '01.06.2005')) INHERITS (payment);

CREATE TABLE payment_07_2005 
(CHECK (DATE_TRUNC('month', payment_date) = '01.07.2005')) INHERITS (payment);

CREATE TABLE payment_08_2005 
(CHECK (DATE_TRUNC('month', payment_date) = '01.08.2005')) INHERITS (payment);

CREATE INDEX payment_05_2005_date_idx ON payment_05_2005 (CAST(payment_date as date));

CREATE TRIGGER payment_insert_tg
BEFORE insert ON payment
FOR EACH ROW EXECUTE FUNCTION payment_insert_tg();

drop trigger payment_insert_tg on payment

CREATE OR REPLACE FUNCTION payment_insert_tg() RETURNS TRIGGER AS $$
DECLARE new_month date; new_month_part text; partition_table_name text;
BEGIN
  new_month = DATE_TRUNC('month', new.payment_date)::date;
  new_month_part = CONCAT(SPLIT_PART(new_month::text, '-', 2), '_', SPLIT_PART(new_month::text, '-', 1));
  partition_table_name = FORMAT('payment_%s', new_month_part); --payment_05_2005
  IF (TO_REGCLASS(partition_table_name) IS NULL) THEN
    EXECUTE FORMAT(
      'CREATE TABLE %I ('
      '  CHECK (DATE_TRUNC(''month'', payment_date) = %L)'
      ') INHERITS (payment);'
      , partition_table_name, new_month);
    EXECUTE FORMAT(
      'CREATE INDEX %1$s_date_idx ON %1$I (CAST(payment_date as date));'
      , partition_table_name);
  END IF;
 	--if TG_OP = 'INSERT' then
  EXECUTE FORMAT('INSERT INTO %I VALUES ($1.*)', partition_table_name) USING NEW;
 	--elseif TG_OP = 'UPDATE' then update
  RETURN NULL;
END; $$ LANGUAGE plpgsql;

explain analyze
select * from payment 

WITH cte AS (  
	DELETE FROM ONLY payment RETURNING *)
INSERT INTO payment   
SELECT * FROM cte;

create table new_payment (like payment)

select * from payment_02_2006

insert into payment
select * from new_payment

select * from new_payment

delete from payment
```

**Задача 4**  

```
root@89cc3da2e6d8:/#pg_dump -d test_database > /pgvolume/db_dump.sql
```
Нужно добавить параметр UNIQUE в описание столбца таблицы:  
```
CREATE TABLE public.orders (
    id integer DEFAULT NULL NOT NULL,
    title character varying(80) NOT NULL UNIQUE,
    price integer DEFAULT 0
);
CREATE TABLE public.orders_less500 (
    id integer DEFAULT NULL NOT NULL,
    title character varying(80) NOT NULL UNIQUE,
    price integer DEFAULT 0
);
CREATE TABLE public.orders_more499 (
    id integer DEFAULT NULL NOT NULL,
    title character varying(80) NOT NULL UNIQUE,
    price integer DEFAULT 0
);
```

