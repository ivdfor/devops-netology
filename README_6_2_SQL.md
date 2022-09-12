# Домашнее задание к занятию "6.2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

## Ответ

```
igord@ubuntu:~/devops-netology/devops-netology/6.2.SQL$ cat docker-compose.yml 
version: '3.6'

volumes:
  data: {}
  backup: {}

services:

  postgres:
    image: postgres:12
    container_name: psql
    ports:
      - "0.0.0.0:5432:5432"
    volumes:
      - ./data:/var/lib/postgresql/data
      - ./backup:/var/lib/postgresql/backup
    environment:
      POSTGRES_USER: "test-admin-user"
      POSTGRES_PASSWORD: "test"
      POSTGRES_DB: "test_db"
    restart: always

igord@ubuntu:~/devops-netology/devops-netology/6.2.SQL$ sudo docker exec -it psql bash
root@4ac5d9aab0d0:/# export PGPASSWORD=test && psql -h localhost -U test-admin-user test_db
psql (12.12 (Debian 12.12-1.pgdg110+1))
Type "help" for help.

test_db=# 
```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db

## Ответ
```
Т.к. создал в docker-compose.yml, то результат повторного создания такой:

test_db=# CREATE USER "test-admin-user";
ERROR:  role "test-admin-user" already exists
test_db=# CREATE DATABASE test_db;
ERROR:  database "test_db" already exists
```

- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

## Ответ
```
test_db=# CREATE TABLE orders (
    id SERIAL,
    наименование VARCHAR,
    цена INTEGER,
    PRIMARY KEY (id)
);
CREATE TABLE

test_db=# CREATE TABLE clients (
    id SERIAL,
    фамилия VARCHAR,
    "страна проживания" VARCHAR,
    заказ INTEGER,
    PRIMARY KEY (id),
    CONSTRAINT fk_заказ
      FOREIGN KEY(заказ)
            REFERENCES orders(id)
);
CREATE TABLE

test_db=# CREATE INDEX ON clients("страна проживания");
CREATE INDEX

test_db=# GRANT ALL ON TABLE orders, clients TO "test-admin-user";
GRANT

test_db=# CREATE USER "test-simple-user" WITH PASSWORD 'netology';
CREATE ROLE
test_db=# GRANT CONNECT ON DATABASE test_db TO "test-simple-user";
GRANT
test_db=# GRANT USAGE ON SCHEMA public TO "test-simple-user";
GRANT
test_db=# GRANT SELECT, INSERT, UPDATE, DELETE ON orders, clients TO "test-simple-user";
GRANT
```

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

## Ответ
```
test_db=# \l+
                                                                               List of databases
   Name    |      Owner      | Encoding |  Collate   |   Ctype    |            Access privileges            |  Size   | Tablespace |                Description                 
-----------+-----------------+----------+------------+------------+-----------------------------------------+---------+------------+--------------------------------------------
 postgres  | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 |                                         | 7969 kB | pg_default | default administrative connection database
 template0 | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 | =c/"test-admin-user"                   +| 7825 kB | pg_default | unmodifiable empty database
           |                 |          |            |            | "test-admin-user"=CTc/"test-admin-user" |         |            | 
 template1 | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 | =c/"test-admin-user"                   +| 7825 kB | pg_default | default template for new databases
           |                 |          |            |            | "test-admin-user"=CTc/"test-admin-user" |         |            | 
 test_db   | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/"test-admin-user"                  +| 8121 kB | pg_default | 
           |                 |          |            |            | "test-admin-user"=CTc/"test-admin-user"+|         |            | 
           |                 |          |            |            | "test-simple-user"=c/"test-admin-user"  |         |            | 
(4 rows)

test_db=# \d+ clients
                                                           Table "public.clients"
      Column       |       Type        | Collation | Nullable |               Default               | Storage  | Stats target | Description 
-------------------+-------------------+-----------+----------+-------------------------------------+----------+--------------+-------------
 id                | integer           |           | not null | nextval('clients_id_seq'::regclass) | plain    |              | 
 фамилия           | character varying |           |          |                                     | extended |              | 
 страна проживания | character varying |           |          |                                     | extended |              | 
 заказ             | integer           |           |          |                                     | plain    |              | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_страна проживания_idx" btree ("страна проживания")
Foreign-key constraints:
    "fk_заказ" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

test_db=# \d+ orders
                                                        Table "public.orders"
    Column    |       Type        | Collation | Nullable |              Default               | Storage  | Stats target | Description 
--------------+-------------------+-----------+----------+------------------------------------+----------+--------------+-------------
 id           | integer           |           | not null | nextval('orders_id_seq'::regclass) | plain    |              | 
 наименование | character varying |           |          |                                    | extended |              | 
 цена         | integer           |           |          |                                    | plain    |              | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "fk_заказ" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap


test_db=# SELECT 
    grantee, table_name, privilege_type
test_db-# FROM 
    information_schema.table_privileges
test_db-# WHERE 
    grantee in ('test-admin-user','test-simple-user')
    and table_name in ('clients','orders')
test_db-# order by 
    1,2,3;
     grantee      | table_name | privilege_type 
------------------+------------+----------------
 test-admin-user  | clients    | DELETE
 test-admin-user  | clients    | INSERT
 test-admin-user  | clients    | REFERENCES
 test-admin-user  | clients    | SELECT
 test-admin-user  | clients    | TRIGGER
 test-admin-user  | clients    | TRUNCATE
 test-admin-user  | clients    | UPDATE
 test-admin-user  | orders     | DELETE
 test-admin-user  | orders     | INSERT
 test-admin-user  | orders     | REFERENCES
 test-admin-user  | orders     | SELECT
 test-admin-user  | orders     | TRIGGER
 test-admin-user  | orders     | TRUNCATE
 test-admin-user  | orders     | UPDATE
 test-simple-user | clients    | DELETE
 test-simple-user | clients    | INSERT
 test-simple-user | clients    | SELECT
 test-simple-user | clients    | UPDATE
 test-simple-user | orders     | DELETE
 test-simple-user | orders     | INSERT
 test-simple-user | orders     | SELECT
 test-simple-user | orders     | UPDATE
(22 rows)
```
## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

## Ответ
```
test_db=# INSERT INTO orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
INSERT 0 5
test_db=# INSERT INTO clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
INSERT 0 5
test_db=# select count (*) from orders;
 count 
-------
     5
(1 row)

test_db=# select count (*) from clients;
 count 
-------
     5
(1 row)
```
## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.

## Ответ
```
test_db=# UPDATE clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Книга') WHERE "фамилия"='Иванов Иван Иванович';
UPDATE 1
test_db=# UPDATE clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Монитор') WHERE "фамилия"='Петров Петр Петрович';
UPDATE 1
test_db=# UPDATE clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Гитара') WHERE "фамилия"='Иоганн Себастьян Бах';
UPDATE 1
test_db=# SELECT c.* FROM clients c JOIN orders o ON c.заказ = o.id;
 id |       фамилия        | страна проживания | заказ 
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |     3
  2 | Петров Петр Петрович | Canada            |     4
  3 | Иоганн Себастьян Бах | Japan             |     5
(3 rows)
```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

## Ответ
```
test_db=# EXPLAIN SELECT c.* FROM clients c JOIN orders o ON c.заказ = o.id;
                               QUERY PLAN                               
------------------------------------------------------------------------
 Hash Join  (cost=37.00..57.24 rows=810 width=72)
   Hash Cond: (c."заказ" = o.id)
   ->  Seq Scan on clients c  (cost=0.00..18.10 rows=810 width=72)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=4)
         ->  Seq Scan on orders o  (cost=0.00..22.00 rows=1200 width=4)
(5 rows)

EXPLAIN - Эта команда отображает план выполнения, созданный планировщиком PostgreSQL для указанного оператора. План выполнения показывает, как будет сканироваться таблица, 
какие алгоритмы будут использоваться для объединения требуемых строк каждой таблицы. В результате выполнения команды планировщик высчитывает по времени
предполагаемую стоимость выполнения инструкции. Отображаются 2 числа- стоимость выполнения первой записи и выполнения всей выборки.
В нашем случае-
Считываются таблицы clients и orders, проверяется соответствие строк "заказ" таблицы clients c таблицей orders, в результате формируется полученный вывод.   
В выводе мы видим, что расчетные значения стоимости(cost) равны- для первой записи...выполнения всей выборки, а так же
расчетное количество строк(raw) и расчетная средняя длина строк(width).
```

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

## Ответ
```
root@ubuntu:/home/igord/devops-netology/devops-netology/6.2.SQL# docker exec -t psql pg_dumpall -c -U test-admin-user > backup/test_db.sql
root@ubuntu:/home/igord/devops-netology/devops-netology/6.2.SQL# docker compose down
[+] Running 2/2
 ⠿ Container psql         Removed                                                                                                                                                                     0.2s
 ⠿ Network 62sql_default  Removed 
root@ubuntu:/home/igord/devops-netology/devops-netology/6.2.SQL# docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
oot@ubuntu:/home/igord/devops-netology/devops-netology/6.2.SQL# docker run --rm -d -e POSTGRES_USER=test-admin-user -e POSTGRES_PASSWORD=test -e POSTGRES_DB=test_db -v /backup --name psql_backup postgres:12
b6bc16db364b827c345de4cb2db7b183a2d5458f710a3cec5eedab26ee75a785
root@ubuntu:/home/igord/devops-netology/devops-netology/6.2.SQL# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS         PORTS      NAMES
b6bc16db364b   postgres:12   "docker-entrypoint.s…"   4 seconds ago   Up 4 seconds   5432/tcp   psql_backup

root@ubuntu:/home/igord/devops-netology/devops-netology/6.2.SQL# cat backup/test_db.sql | docker exec -i psql_backup psql -U test-admin-user test_db

root@ubuntu:/home/igord/devops-netology/devops-netology/6.2.SQL#  docker exec -it psql_backup  bash
root@b6bc16db364b:/# psql -h localhost -U test-admin-user test_db
psql (12.12 (Debian 12.12-1.pgdg110+1))
Type "help" for help.

test_db=# \d+ clients
                                                           Table "public.clients"
      Column       |       Type        | Collation | Nullable |               Default               | Storage  | Stats target | Description 
-------------------+-------------------+-----------+----------+-------------------------------------+----------+--------------+-------------
 id                | integer           |           | not null | nextval('clients_id_seq'::regclass) | plain    |              | 
 фамилия           | character varying |           |          |                                     | extended |              | 
 страна проживания | character varying |           |          |                                     | extended |              | 
 заказ             | integer           |           |          |                                     | plain    |              | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_страна проживания_idx" btree ("страна проживания")
Foreign-key constraints:
    "fk_заказ" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

test_db=# \d+ orders
                                                        Table "public.orders"
    Column    |       Type        | Collation | Nullable |              Default               | Storage  | Stats target | Description 
--------------+-------------------+-----------+----------+------------------------------------+----------+--------------+-------------
 id           | integer           |           | not null | nextval('orders_id_seq'::regclass) | plain    |              | 
 наименование | character varying |           |          |                                    | extended |              | 
 цена         | integer           |           |          |                                    | plain    |              | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "fk_заказ" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

test_db=# 

```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
