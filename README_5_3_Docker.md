# Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

## Задача 1

Сценарий выполения задачи:

создайте свой репозиторий на https://hub.docker.com;
выберете любой образ, который содержит веб-сервер Nginx;
создайте свой fork образа;
реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

### Ответ:

Ссылка:

https://hub.docker.com/repository/docker/ivdfor/nginx-netology

```
1) Логинюсь на docker.io

docker login   

2) Загружаю в локальное хранилище образ nginx

docker pull nginx:stable-alpine

3) Создаю index.html

vagrant@server1:~/ivdfor$ cat index.html 
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>

4) Создаю Dockerfile

vagrant@server1:~/ivdfor$ cat Dockerfile 
FROM nginx:stable-alpine
COPY index.html /usr/share/nginx/html/

5) Собираю Docker образ 

vagrant@server1:~/ivdfor$ docker build -t ivdfor/nginx-netology:v1 .
Sending build context to Docker daemon  3.584kB
Step 1/2 : FROM nginx:stable-alpine
 ---> c232c77bc4b8
Step 2/2 : COPY index.html /usr/share/nginx/html/
 ---> Using cache
 ---> 6990ac8799d2
Successfully built 6990ac8799d2
Successfully tagged ivdfor/nginx-netology:v1

vagrant@server1:~/ivdfor$ docker images
REPOSITORY              TAG             IMAGE ID       CREATED             SIZE
ivdfor/nginx-netology   v1              6990ac8799d2   About an hour ago   23.5MB
nginx                   stable-alpine   c232c77bc4b8   2 weeks ago         23.5MB
hello-world             latest          feb5d9fea6a5   9 months ago        13.3kB

6) Запускаю созданый образ

vagrant@server1:~/ivdfor$ docker run --name nginx-Task5.3.1 -p 8080:80 -d ivdfor/nginx-netology:v1
524d6cbba486597aa0a1b60aecd60f2682031924f5f665a7beb2471927e3b101

7) Проверяю успешность запуска и открытие кастомного index.html

vagrant@server1:~/ivdfor$ curl http://localhost:8080
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>

8) Загружаю созданный образ на удаленный репозиторий hub.docker.com

vagrant@server1:~/ivdfor$ docker push ivdfor/nginx-netology:v1
The push refers to repository [docker.io/ivdfor/nginx-netology]
2bc9d8c3e062: Pushed 
d5b0419f251d: Mounted from library/nginx 
2f0fce789923: Mounted from library/nginx 
28def5cfb9ad: Mounted from library/nginx 
8b3510de6162: Mounted from library/nginx 
c57b67e296a6: Mounted from library/nginx 
24302eb7d908: Mounted from library/nginx 
v1: digest: sha256:b01221d3c0420c084b8373dbc123bc1b3fa190c45dd73c94214b74f497ae9264 size: 1775

```

## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

Сценарий:

Высоконагруженное монолитное java веб-приложение;
Nodejs веб-приложение;
Мобильное приложение c версиями для Android и iOS;
Шина данных на базе Apache Kafka;
Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
Мониторинг-стек на базе Prometheus и Grafana;
MongoDB, как основное хранилище данных для java-приложения;
Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

### Ответ:
```
Высоконагруженное монолитное java веб-приложение- 

Видимо, лучше использовать виртуальные/физические машины, так как высоконагруженное монолитное приложение обычно выполняет одновременно несколько процессов, 
ресурсоемко, долго запускается, а так же имеет зависимости, которые могут повлиять на работу других контейнеров. 

Nodejs веб-приложение-

Лучше использовать Docker, т.к. это обычное веб приложение, оно быстро запускается, толерантно к ресурсам, легко масштабируется. 

Мобильное приложение c версиями для Android и iOS- 

Поиск дает некоторые ссылки на статьи, описывающие использование Docker для развертывания инструментов для разработки приложений Android/iOS, 
но, однако, это скорее частные опыты авторов статей, четкая работоспособность разработанных приложений под докером приложений так же не очевидна. 
В целом, наиболее оптимальным является традиционное использование полноценных ВМ с инструментами разработки.

Шина данных на базе Apache Kafka-

Docker- существуют готовые образы Apache Kafka, активно используется, в интернете много информации по развертыванию посредством Docker, плюсом так же является возможность
быстрого отката к стабильной версии и изолированость приложений. 

Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana-

В зависимости от задачи развертывания, возможно использование как Docker, так и ВМ- активно используются оба варинта развертывания,
существуют образы Docker, вариант удобен масштабируемостью, быстрым развертыванием и откатом, но, на высоконагруженных системах, 
при ведении, например, большого обьема логов с требованием быстрого поиска по ним- предпочтительнее отдельная ВМ или физическая машина. 

Мониторинг-стек на базе Prometheus и Grafana-

Удобно разворачивать в Docker по тем же причинам- готовые образы для Docker, удобен масштабируемостью, быстрым развертыванием и быстрым откатом к другим версиям.

MongoDB, как основное хранилище данных для java-приложения-

С одной стороны, существуют готовые образы для Docker, в вопросе нет критериев высокодоступности либо высоконагруженности, с другой- 
развертывание DB с критичными данными в контейнере достаточно опасно потерей данных, по возможности все же надежнее использовать ВМ, либо физический хост.

Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry-

Виртуальные либо физич.сервера будут надежнее, с точки зрения выполнения CI/CD процессов и, соотвественно, безопасного хранения часто изменяемых версий, 
в случае проблем с контейнером возможна потеря критических данных, а ВМ легко мигрировать и делать бекапы.
```

## Задача 3

Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data;
Добавьте еще один файл в папку /data на хостовой машине;
Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.

### Ответ
```
vagrant@server1:~$ docker run -v $(pwd)/data:/data -dt --name centos dinesh9999/centos-alpine
8e8339936926c8c3c56b6763f00df8923bf0bf3f4a85bb302edffd6392c5bbd8

Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;

vagrant@server1:~$ docker run -v $(pwd)/data:/data -dt --name debian debian
78eb6bd0d34321a5a5cef4c3e92fbcb149883f5862e2c1f55dbddd347bd359ed

Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data;

vagrant@server1:~$ docker exec -it centos /bin/bash
[root@8e8339936926 /]# echo 'Hello Centos!' >> data/hello-centos
[root@8e8339936926 /]# cat data/hello-centos 
Hello Centos!

Добавьте еще один файл в папку /data на хостовой машине;

vagrant@server1:~$ cat data/hello-host 
Hello World! I`m The Host!

Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.

vagrant@server1:~$ docker exec -it debian bash
root@78eb6bd0d343:/# 
root@78eb6bd0d343:/# ls -l data/
total 8
-rw-r--r-- 1 root root 14 Jul 13 22:24 hello-centos
-rw-rw-r-- 1 1000 1000 27 Jul 13 21:38 hello-host
root@78eb6bd0d343:/# 
root@78eb6bd0d343:/# cat data/hello-centos 
Hello Centos! 
root@78eb6bd0d343:/# cat data/hello-host   
Hello World! I`m The Host!
root@78eb6bd0d343:/# 
```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

### Ответ
```
https://hub.docker.com/repository/docker/ivdfor/ansible
```



