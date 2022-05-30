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
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
ALTER TABLE orders RENAME TO orders_copy;
CREATE TABLE orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0)
	PARTITION BY RANGE (price);
CREATE TABLE orders_more499 PARTITION OF orders
    FOR VALUES FROM (500) TO (2147483647);
CREATE TABLE orders_less500 PARTITION OF orders
    FOR VALUES FROM (0) TO (500);
INSERT INTO orders (id, title, price) SELECT * FROM orders_copy;
ALTER SEQUENCE orders_id_seq OWNED BY public.orders.id;
ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
DROP TABLE orders_copy;
COMMIT;
```

test_database=# insert into orders (title, price) values ('test less 499', 300), ('test more 500', 600);
INSERT 0 2

test_database=# select * FROM orders;
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
  9 | test less 499        |   300
  2 | My little database   |   500
  6 | WAL never lies       |   900
  8 | Dbiezdmin            |   501
 10 | test more 500        |   600

test_database=# select * FROM orders_less500;
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
  9 | test less 499        |   300

test_database=# select * FROM orders_more499;
  2 | My little database |   500
  6 | WAL never lies     |   900
  8 | Dbiezdmin          |   501
 10 | test more 500      |   600

```
Можно, для этого из предложенной транзакции достаточно убрать запросы с переименованием и копированием данных    


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

