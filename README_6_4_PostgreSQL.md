# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql

### Ответ
```
igord@ubuntu:~/devops-netology/devops-netology/6-4-PostgreSQL$ sudo docker pull postgres:13

igord@ubuntu:~/devops-netology/devops-netology/6-4-PostgreSQL$ sudo docker volume create volume_6-4
volume_6-4

igord@ubuntu:~/devops-netology/devops-netology/6-4-PostgreSQL$ sudo docker run --rm -d --name postgre_6-4 -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v volume_6-4:/var/lib/postgresql/data postgres:13 
d8396cbc8d207a6188bac7c560f1077ca4c9e8d52d865e55f18c8197b9600213

igord@ubuntu:~/devops-netology/devops-netology/6-4-PostgreSQL$ sudo docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                                       NAMES
d8396cbc8d20   postgres:13   "docker-entrypoint.s…"   30 seconds ago   Up 30 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   postgre_6-4

igord@ubuntu:~/devops-netology/devops-netology/6-4-PostgreSQL$ sudo docker exec -it postgre_6-4 bash

root@d8396cbc8d20:/# psql -h localhost -p 5432 -U postgres -W

- вывода списка БД

postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)


- подключения к БД

\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                         connect to new database (currently "postgres")

postgres=# \c postgres

- вывода списка таблиц

\dt[S+] [PATTERN]      list tables

postgres=# \dtS+
                                        List of relations
   Schema   |          Name           | Type  |  Owner   | Persistence |    Size    | Description 
------------+-------------------------+-------+----------+-------------+------------+-------------
 pg_catalog | pg_aggregate            | table | postgres | permanent   | 56 kB      | 
 pg_catalog | pg_am                   | table | postgres | permanent   | 40 kB      | 
 pg_catalog | pg_amop                 | table | postgres | permanent   | 80 kB      | 
 pg_catalog | pg_amproc               | table | postgres | permanent   | 64 kB      | 
 pg_catalog | pg_attrdef              | table | postgres | permanent   | 8192 bytes | 
.............................. 
........skipped...............
..............................
 pg_catalog | pg_ts_template          | table | postgres | permanent   | 40 kB      | 
 pg_catalog | pg_type                 | table | postgres | permanent   | 120 kB     | 
 pg_catalog | pg_user_mapping         | table | postgres | permanent   | 8192 bytes | 
(62 rows)

- вывода описания содержимого таблиц

\d[S+]  NAME           describe table, view, sequence, or index

postgres=#  \dS+ pg_user_mapping
                             Table "pg_catalog.pg_user_mapping"
  Column   |  Type  | Collation | Nullable | Default | Storage  | Stats target | Description 
-----------+--------+-----------+----------+---------+----------+--------------+-------------
 oid       | oid    |           | not null |         | plain    |              | 
 umuser    | oid    |           | not null |         | plain    |              | 
 umserver  | oid    |           | not null |         | plain    |              | 
 umoptions | text[] | C         |          |         | extended |              | 
Indexes:
    "pg_user_mapping_oid_index" UNIQUE, btree (oid)
    "pg_user_mapping_user_server_index" UNIQUE, btree (umuser, umserver)
Access method: heap

- выхода из psql

\q                     quit psql

postgres=# \q
root@d8396cbc8d20:/# 
```
## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

### Ответ
```
postgres=# CREATE DATABASE test_database;
CREATE DATABASE

igord@ubuntu:~/devops-netology/devops-netology/6-4-PostgreSQL$ sudo docker exec -i postgre_6-4 bash -c "PGPASSWORD=postgres psql --username postgres test_database" < test_dump.sql
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

igord@ubuntu:~/devops-netology/devops-netology/6-4-PostgreSQL$ sudo docker exec -it postgre_6-4 bash
root@d8396cbc8d20:/# psql -h localhost -p 5432 -U postgres -W
psql (13.8 (Debian 13.8-1.pgdg110+1))
Type "help" for help.
postgres=# \c test_database
You are now connected to database "test_database" as user "postgres".
test_database=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner   
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)

test_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE

test_database=# select avg_width from pg_stats where tablename='orders';
 avg_width 
-----------
         4
        16
         4
(3 rows)

test_database=# 
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

### Ответ
```
test_database=# CREATE TABLE gre_499 (CHECK (price > 499)) INHERITS (orders);
CREATE TABLE
test_database=# CREATE TABLE eq_le_499 (CHECK (price <= 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO gre_499 SELECT * FROM orders WHERE price > 499;
INSERT 0 3
test_database=# INSERT INTO eq_le_499 SELECT * FROM orders WHERE price <= 499;
INSERT 0 5
test_database=# DELETE FROM ONLY orders;
DELETE 8
test_database=# \dt
           List of relations
 Schema |   Name    | Type  |  Owner   
--------+-----------+-------+----------
 public | eq_le_499 | table | postgres
 public | gre_499   | table | postgres
 public | orders    | table | postgres
(3 rows)

Можно было бы заранее использовать партиционирование таблиц.
Партиционирование в PostgreSQL — это разбиение таблиц, содержащих большое количество записей, 
на логические части для повышения скорости и удобства выполнения запросов.

В PostgreSQL встроена поддержка следующих видов партиционирования:

Партиционирование по интервалам- Таблица разбивается на интервалы, задаваемые ключевой колонкой или множеством колонок. 
Интервалы для каждой партиции не пересекаются. Например, таблица может разбиваться на интервалы по датам или идентификаторам конкретных объектов 
в зависимости от предметной области и характера хранимых в таблице данных.
Партиционирование по списку. Таблица разбивается при помощи явного перечисления для каждого ключа, в какой партиции содержится значение.

В нашем случае- cоздадим таблицу заказов как партиционированную таблицу, воспользовавшись условием PARTITION BY. 
Оно содержит метод партиционирования (в нашем случае, RANGE) и список колонок, используемых в качестве ключа партиционирования:

test_database=# CREATE TABLE orders_partitioned (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
) PARTITION BY RANGE (price);
CREATE TABLE

Создание партиций: Определение каждой партиции должно содержать границы, которые соответствуют методу и ключу партиционирования родителя.

test_database=# CREATE TABLE equal_less_499 PARTITION OF orders_partitioned
    FOR VALUES FROM (0) TO (499);
CREATE TABLE
test_database=# CREATE TABLE greater_499 PARTITION OF orders_partitioned
    FOR VALUES FROM (499) TO (99999999);
CREATE TABLE

Созданные таким образом партиции являются, в любом случае, обычными таблицами PostgreSQL. 
Для каждой партиции отдельно можно задавать пространство таблиц и параметры хранилища.
```

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

### Ответ
```
root@d8396cbc8d20:/# pg_dump -U postgres -d test_database > test_database_backup.sql

Т.к. test_database_backup.sql содержит информацию о таблицах, его можно открыть текстовым редактором и в таблицах значению столбцов title добавить свойство UNIQUE:

title character varying(80) NOT NULL UNIQUE
```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

