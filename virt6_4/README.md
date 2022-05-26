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

```
postgres=# 
begin;
    create table orders_new (
        id integer NOT NULL,
        title varchar(80) NOT NULL,
        price integer) partition by range(price);
    create table orders_less partition of orders_new for values from (0) to (499);
    create table orders_more partition of orders_new for values from (499) to (99999);
    insert into orders_new (id, title, price) select * from orders;
commit;
BEGIN
CREATE TABLE
CREATE TABLE
CREATE TABLE
INSERT 0 8
COMMIT
```
Избежать разбиения таблицы вручную можно было, если определить тип при проектировании и создании partitioned table.  

**Задача 4**  

```
root@89cc3da2e6d8:/#pg_dump -d test_database > /pgvolume/db_dump.sql
```
Определить уникальность значения столбца title можно использовать индекс.

