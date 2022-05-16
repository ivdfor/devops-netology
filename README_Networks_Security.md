Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"


1) Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.

Установил, скриншот доступен по адресу:



2) Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

Установил, скриншот доступен по адресу:

https://github.com/ivdfor/devops-netology/blob/main/Network%20Homeworks/jpeg-security/Task-2-security.jpg

3)Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

Ответ:

Настройка https и тестового сайта:

a) Создание ключа и ssl-сертификата

igord@ubuntu:~$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \

> -keyout /etc/ssl/private/apache-selfsigned.key \

> -out /etc/ssl/certs/apache-selfsigned.crt \

> -subj "/C=RU/ST=Moscow/L=Moscow/O=Company Name/OU=Org/CN=www.netology-test"

Generating a RSA private key

.......................................+++++

.............................................+++++

writing new private key to '/etc/ssl/private/apache-selfsigned.key'

-----

b) Создание нового конфигурационнго файла c директивами: 

igord@ubuntu:~$ sudo vim /etc/apache2/sites-available/192.168.28.131.conf

igord@ubuntu:~$ cat /etc/apache2/sites-available/192.168.28.131.conf

<VirtualHost *:443>

ServerName 192.168.28.131

DocumentRoot /var/www/192.168.28.131

SSLEngine on

SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt

SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

</VirtualHost>

с) Создаем стартовую страницу:

igord@ubuntu:~$ sudo mkdir /var/www/192.168.28.131

igord@ubuntu:~$ sudo vim /var/www/192.168.28.131/index.html

igord@ubuntu:~$ cat /var/www/192.168.28.131/index.html

<h1>HELLO WORLD</h1>

d) Активируем конфигурационный файл и тестируем его:

igord@ubuntu:~$ sudo a2ensite 192.168.28.131.conf

Enabling site 192.168.28.131.

To activate the new configuration, you need to run:

  systemctl reload apache2

igord@ubuntu:~$ sudo apache2ctl configtest

AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message

Syntax OK

e) Перезапускаем веб-сервер, проверяем в браузере доступность:

igord@ubuntu:~$ sudo systemctl reload apache2

https://192.168.28.131

Запускается.


4) Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).

Ответ:

Клонируем инструмент для проверки testssl.sh.git

igord@ubuntu:~$ git clone --depth 1 https://github.com/drwetter/testssl.sh.git

igord@ubuntu:~$ cd testssl.sh

Запускаем тестирование на известные уязвимости:

igord@ubuntu:~/testssl.sh$ ./testssl.sh -U --sneaky yahoo.com

Узучаем результаты вывода на присутствие потенциальных уязвимостей.

5) Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.

Ответ:

Устанавливаем, запускаем и добавляем в автозапуск ssh-сервер:

igord@ubuntu:~/testssl.sh$ sudo apt install openssh-server

igord@ubuntu:~/testssl.sh$ sudo systemctl start sshd.service

igord@ubuntu:~/testssl.sh$ sudo systemctl enable sshd.service

Генерируем ключи:

igord@ubuntu:~/testssl.sh$ ssh-keygen -t rsa

Generating public/private rsa key pair.

Enter file in which to save the key (/home/igord/.ssh/id_rsa):
                                                                                         
Created directory '/home/igord/.ssh'.

Enter passphrase (empty for no passphrase): 

Enter same passphrase again: 

Your identification has been saved in /home/igord/.ssh/id_rsa

Your public key has been saved in /home/igord/.ssh/id_rsa.pub

The key fingerprint is:

SHA256:pbJ3yX8FXivK8zr6/W4IfqIBTt7C6nbd1Wgf/jyt2Kc igord@ubuntu

The key's randomart image is:

+---[RSA 3072]----+

|                 |

|                 |

|          .      |

|         o    . .|

|      .oS    .oo.|

|      =oo. o =.+.|

|      .=ooB = =.o|

|     ..o.o.X.=.*o|

|    oo.  o+oX+E*=|

+----[SHA256]-----+


Пересылаем свой публичный ключ на другой сервер:

igord@ubuntu:~$ sudo ssh-copy-id -i ~/.ssh/id_rsa.pub igordv@192.168.28.132

/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/igord/.ssh/id_rsa.pub"

/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed

/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys

igordv@192.168.28.132's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'igordv@192.168.28.132'"

and check to make sure that only the key(s) you wanted were added.


Перезапускаем сервер:

igord@ubuntu:~$ sudo service sshd restart

Убеждаемся, что заходим на него:

igord@ubuntu:~$ ssh igordv@192.168.28.132

Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.13.0-41-generic x86_64)

 * Documentation:  https://help.ubuntu.com

 * Management:     https://landscape.canonical.com

 * Support:        https://ubuntu.com/advantage

281 updates can be applied immediately.

187 of these updates are standard security updates.

To see these additional updates run: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.

Last login: Mon May 16 05:14:12 2022 from 192.168.28.131

igordv@ubuntu:~$ 


6) Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

Ответ:

igord@ubuntu:~$ sudo mv ~/.ssh/id_rsa ~/.ssh/id_rsa_change_name

igord@ubuntu:~$ cat ~/.ssh/config

Host VM2

        HostName 192.168.28.132

        User igordv

        Port 22

        IdentityFile ~/.ssh/id_rsa_change_name


igord@ubuntu:~$ ssh VM2

Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.13.0-41-generic x86_64)

 * Documentation:  https://help.ubuntu.com

 * Management:     https://landscape.canonical.com

 * Support:        https://ubuntu.com/advantage

111 updates can be applied immediately.

To see these additional updates run: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.

*** System restart required ***

Last login: Mon May 16 05:15:42 2022 from 192.168.28.131

igordv@ubuntu:~$ 


7) Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

Ответ:

igord@ubuntu:~$ sudo tcpdump -i ens33 -c 100 -w traffic_100.pcap

tcpdump: listening on ens33, link-type EN10MB (Ethernet), capture size 262144 bytes

100 packets captured

118 packets received by filter

0 packets dropped by kernel

Сссылка на скриншот c Wireshark и traffic_100.pcap доступен по ссылке:

https://github.com/ivdfor/devops-netology/blob/main/Network%20Homeworks/jpeg-security/Task-7-security.jpg


