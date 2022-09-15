# Домашнее задание к занятию "6.3. MySQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.
### Ответ
```
igord@ubuntu:~/devops-netology/devops-netology/6-3-MySQL$ cat docker-compose.yml 
version: '3.6'

services:
  mysql:
    image: mysql:8.0
    container_name: mysql
    ports:
      - 3306:3306
    volumes:
      - ./data:/var/lib/mysql
    environment:
      - MYSQL_DATABASE=mysql_db
      - MYSQL_ROOT_PASSWORD=test
      - MYSQL_PASSWORD=test
      - MYSQL_USER=admin


igord@ubuntu:~/devops-netology/devops-netology/6-3-MySQL$ sudo docker ps
CONTAINER ID   IMAGE       COMMAND                  CREATED          STATUS          PORTS                                                  NAMES
822cd07d0dad   mysql:8.0   "docker-entrypoint.s…"   10 minutes ago   Up 10 minutes   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql
```

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h` получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

### Ответ
```
igord@ubuntu:~/devops-netology/devops-netology/6-3-MySQL$ sudo docker cp test_dump.sql mysql:/tmp
igord@ubuntu:~/devops-netology/devops-netology/6-3-MySQL$ sudo docker exec -it mysql bash
bash-4.4# mysql -u root -p mysql_db < /tmp/test_dump.sql
bash-4.4# mysql -u root -p
mysql> \s
Server version:		8.0.30 MySQL Community Server - GPL
```

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

В следующих заданиях мы будем продолжать работу с данным контейнером.

### Ответ
```
mysql> USE mysql_db;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> 
mysql> 
mysql> SHOW TABLES;
+--------------------+
| Tables_in_mysql_db |
+--------------------+
| orders             |
+--------------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(*) FROM orders WHERE price > 300;
+----------+
| COUNT(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.
    
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.

### Ответ
```
mysql> CREATE USER 'test'@'localhost'
    -> IDENTIFIED WITH mysql_native_password BY 'test-pass'
    -> WITH MAX_CONNECTIONS_PER_HOUR 100
    -> PASSWORD EXPIRE INTERVAL 180 DAY
    -> FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2
    -> ATTRIBUTE '{"first_name":"James", "last_name":"Pretty"}';
Query OK, 0 rows affected (0.01 sec)

mysql> GRANT SELECT ON test_db.* TO test@localhost;
Query OK, 0 rows affected, 1 warning (0.01 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER = 'test';
+------+-----------+------------------------------------------------+
| USER | HOST      | ATTRIBUTE                                      |
+------+-----------+------------------------------------------------+
| test | localhost | {"last_name": "Pretty", "first_name": "James"} |
+------+-----------+------------------------------------------------+
1 row in set (0.00 sec)
```

## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`

### Ответ
```
mysql> SELECT table_schema,table_name,engine FROM information_schema.tables WHERE table_schema = DATABASE();
+--------------+------------+--------+
| TABLE_SCHEMA | TABLE_NAME | ENGINE |
+--------------+------------+--------+
| mysql_db     | orders     | InnoDB |
+--------------+------------+--------+
1 row in set (0.00 sec)

mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW PROFILES;
+----------+------------+------------------------------------+
| Query_ID | Duration   | Query                              |
+----------+------------+------------------------------------+
|        1 | 0.01811875 | ALTER TABLE orders ENGINE = MyISAM |
|        2 | 0.02126425 | ALTER TABLE orders ENGINE = InnoDB |
+----------+------------+------------------------------------+
2 rows in set, 1 warning (0.00 sec)
```

## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.

### Ответ
```
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

#Значение “0” даст наибольшую производительность. 
#В этом случае буфер будет сбрасываться в лог файл независимо от транзакций. В этом случае риск потери данных возрастает.

innodb_flush_log_at_trx_commit = 0

#Формат файлов Barracuda — самый «новый» и поддерживает компрессию (ROW_FORMAT=COMPRESSED). 
#Это позволяет экономить место и снижать нагрузку на жесткие диски путём использования сжатия. 

innodb_file_format=Barracuda

#Это размер буфера транзакций, которые не были еще закомичены. 
#Значение этого параметра стоит менять в случаях, если вы используете большие поля вроде BLOB или TEXT.

innodb_log_buffer_size  = 1M

#Параметр key_buffer_size задаёт размер памяти, выделяемый под хранение индексных блоков для таблиц типа MyISAM, 
#которые могут быть считаны из памяти, вместо того, что бы обращаться к диску для чтения.
#key_buffer_size – один из наиболее важных параметров в настройке производительности MySQL. 
#Данный буфер является общим для всех пользовательских процессов.

key_buffer_size = 2448М

#параметр определяет размер файла бинлога, который используется при репликации. 
#Mysql создаст новый файл, когда размер текущего файла достигнет лимита.

max_binlog_size = 100M
```
---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
