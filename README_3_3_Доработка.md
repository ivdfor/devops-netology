
>Добрый день!

>Задание 1
>Предлагаю уточнить как именно в службу будут передаваться дополнительные опции. Примеры можно посмотреть вот здесь:
>https://www.freedesktop.org/software/systemd/man/systemd.service.html#ExecStart=
>https://unix.stackexchange.com/questions/323914/dynamic-variables-in-systemd-service-unit-files
>https://stackoverflow.com/questions/48843949/systemd-use-variables-in-a-unit-file
>Замечу, что речь идёт не о переменных окружения, а об опциях (параметрах) запуска службы.

>С уважением,
>Алексей

Добрый день!

Допустим, мы хотим передать опцию, изменяющую номер порта, на котором работает node_exporter.
Для этого необходимо службе передать опцию --web.listen-address=:[номер порта]
Сделать это через внешний файл можно передачей опции таким образом:

[Service]

ExecStart=/usr/local/bin/node_exporter $Change_Port

EnvironmentFile=/etc/default/node_exporter

Где Change_Port - имя пользовательской опции.
В данном случае это равносильно передаче опции напрямую, которая бы выглядела как:
ExecStart=/usr/local/bin/node_exporter --web.listen-address=:9199


Далее, редактируем файл /etc/default/node_exporter, добавив в него нашу пользовательскую опцию Change_Port с измененным значением порта:

Change_Port = "--web.listen-address=:9199"

после перезапуска видим, что прослушивается порт 9199:

vagrant@vagrant:~$ sudo systemctl status node_exporter
skipped....
Apr 26 22:32:32 vagrant node_exporter[2271]: time="2022-04-26T22:32:32Z" level=info msg="Listening on :9199" source="node_exporter.go:170"
 

