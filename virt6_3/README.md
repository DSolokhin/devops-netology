***Задача 1***  

```
mysql> status
--------------
mysql  Ver 8.0.29 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		12
Current database:	test_db
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.29 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8mb4
Db     characterset:	utf8mb4
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/run/mysqld/mysqld.sock
Binary data as:		Hexadecimal
Uptime:			31 min 56 sec

Threads: 2  Questions: 31  Slow queries: 0  Opens: 140  Flush tables: 3  Open tables: 59  Queries per second avg: 0.016
--------------

mysql> connect
Connection id:    37
Current database: test_db

mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)

mysql> select count(*) from orders where price>300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```

**Задача 2**  

```
mysql> create user 'test'@'localhost' 
    ->     identified with mysql_native_password by 'test-pass' 
    ->     with max_queries_per_hour 100
    ->     password expire interval 180 day 
    ->     failed_login_attempts 3 
    ->     attribute '{"fname": "James","lname": "Pretty"}';
Query OK, 0 rows affected (0.00 sec)

mysql> grant select on test_db. to test@'localhost';
mysql> flush privileges;


mysql> select * from INFORMATION_SCHEMA.USER_ATTRIBUTEs where user = 'test';
+------+-----------+---------------------------------------+
| USER | HOST      | ATTRIBUTE                             |
+------+-----------+---------------------------------------+
| test | localhost | {"fname": "James", "lname": "Pretty"} |
+------+-----------+---------------------------------------+
1 row in set (0.00 sec)
```

**Задача 3**  

```
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SHOW PROFILES;
+----------+------------+-----------------------------------------+
| Query_ID | Duration   | Query                                   |
+----------+------------+-----------------------------------------+
|        1 | 0.00302500 | show table status where name = 'orders' |
|        2 | 0.00016250 | SET profiling = 1                       |
+----------+------------+-----------------------------------------+
2 rows in set, 1 warning (0.00 sec)
```
![6_3](https://user-images.githubusercontent.com/26553608/170005698-07112c7c-3b27-4d3f-8b54-b9d8edb6ca09.JPG)


