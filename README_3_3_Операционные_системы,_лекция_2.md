Домашнее задание к занятию "3.4. Операционные системы, лекция 2"

1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. 
Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. 
Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:

поместите его в автозагрузку, предусмотрите возможность добавления опций к запускаемому процессу 
через внешний файл (посмотрите, например, на systemctl cat cron),
удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, 
а после перезагрузки автоматически поднимается.

Ответ:

	a) Создал unit-файл для node_exporter, добавил возможность добавления опций  
	через внешний файл EnvironmentFile=/etc/default/node_exporter:

vagrant@vagrant:~$ cat /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/local/bin/node_exporter
EnvironmentFile=/etc/default/node_exporter

[Install]
WantedBy=multi-user.target

	b) Перезапустил сервис, проверил статус, убедился что статус active (running):

vagrant@vagrant:~$ sudo systemctl daemon-reload
vagrant@vagrant:~$ sudo systemctl start node_exporter
vagrant@vagrant:~$ sudo systemctl status node_exporter

	c) Добавил в автозагрузку:

vagrant@vagrant:~$ sudo systemctl enable

2. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. 
Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

Ответ:

Ознакомился с опциями, выбрал:

vagrant@vagrant:~$ curl http://localhost:9100/metrics

# HELP node_cpu_seconds_total Seconds the cpus spent in each mode.
# TYPE node_cpu_seconds_total counter
node_cpu_seconds_total{cpu="0",mode="idle"} 6852.27
node_cpu_seconds_total{cpu="0",mode="iowait"} 13.75
node_cpu_seconds_total{cpu="0",mode="irq"} 0
node_cpu_seconds_total{cpu="0",mode="nice"} 0.01
node_cpu_seconds_total{cpu="0",mode="softirq"} 0.71
node_cpu_seconds_total{cpu="0",mode="steal"} 0
node_cpu_seconds_total{cpu="0",mode="system"} 8.8

# TYPE node_memory_MemAvailable_bytes gauge
node_memory_MemAvailable_bytes 3.60470528e+09
# TYPE node_memory_MemFree_bytes gauge
node_memory_MemFree_bytes 2.834587648e+09
# TYPE node_memory_MemTotal_bytes gauge
node_memory_MemTotal_bytes 4.126908416e+09

# TYPE node_disk_io_time_seconds_total counter
node_disk_io_time_seconds_total{device="dm-0"} 95.428
node_disk_io_time_seconds_total{device="sda"} 99.516
# TYPE node_disk_read_bytes_total counter
node_disk_read_bytes_total{device="dm-0"} 4.64823296e+08
node_disk_read_bytes_total{device="sda"} 4.78025728e+08
# TYPE node_disk_read_time_seconds_total counter
node_disk_read_time_seconds_total{device="dm-0"} 17.048000000000002
node_disk_read_time_seconds_total{device="sda"} 12.982000000000001

# TYPE node_network_receive_bytes_total counter
node_network_receive_bytes_total{device="eth0"} 8.2748914e+07
# TYPE node_network_receive_drop_total counter
node_network_receive_drop_total{device="eth0"} 0
# TYPE node_network_receive_errs_total counter
node_network_receive_errs_total{device="eth0"} 0

3. Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). 
После успешной установки:
в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0, 
добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер 
и сделайте vagrant reload: config.vm.network "forwarded_port", guest: 19999, host: 19999 
После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на localhost:19999. 
Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.

Ответ:

Netdata установил, в Vagrantfile изменил, зашел с ПК на localhost:19999. Скришот доступен по ссылке:

https://github.com/ivdfor/devops-netology/blob/main/Netdata.jpg

4. Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

Ответ:

Да, можно:

vagrant@vagrant:~$ dmesg -H -T | grep -i virtual
[Sun Apr 24 20:04:27 2022] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[Sun Apr 24 20:04:27 2022] CPU MTRRs all blank - virtualized system.
[Sun Apr 24 20:04:27 2022] Booting paravirtualized kernel on KVM
[Sun Apr 24 20:04:27 2022] Performance Events: PMU not available due to virtualization, using software events only.
[Sun Apr 24 20:04:33 2022] systemd[1]: Detected virtualization oracle.

5. Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. 
Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

Ответ:

nr_open - Системное жесткое ограничение максимального значения открытых файловых дескрипторов одним процессом, 
значение по умолчанию 
1024*1024 (1048576)

vagrant@vagrant:~$ sysctl -n fs.nr_open
1048576

Значение изменяемое, для изменения необходимо увеличить значение nr_open 
(воспользовавшись: sysctl -w fs.nr_open = 100000000) или записать его непосредственно в файл sysctl.conf).

ulimit предоставляет контроль над ресурсами, доступными ядру и запущенным процессам.
ulimit -Sn (он же -n)- предоставит информацию о "мягком (soft)" допустимом максимальном количестве открытых файловых дескрипторов. 
Может быть увеличен, но не более значения "жесткого (hard)" лимита.
ulimit -Hn - предоставит информацию о "жестком (hard)" допустимом максимальном количестве открытых файловых дескрипторов. 
Не может быть увеличен, только уменьшен.

vagrant@vagrant:~$ ulimit -Sn
1024

vagrant@vagrant:~$ ulimit -Hn
1048576

6. Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) 
в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. 
Для простоты работайте в данном задании под root (sudo -i). 
Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

Ответ:

При выполнении:
root@ubuntu:/home/igord# unshare -f --pid --mount-proc sleep 2m

В другом окне терминала получаем:

root@ubuntu:/home/igord# ps -e | grep sleep
  78053 pts/1    00:00:00 sleep 

root@ubuntu:/home/igord# nsenter --target 78053 --mount --uts --ipc --net --pid ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   8084   520 pts/1    S+   05:12   0:00 sleep 2m
root           2  0.0  0.1  11496  3212 pts/2    R+   05:13   0:00 ps aux


7. Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 
(это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – 
ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. 
Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

Ответ:

:(){ :|:& };: - это fork-bomb, bash рекурсивная функция, которая параллельно запускает два своих экземпляра. 
Каждый запускает ещё по два и т.д. 
При отсутствии лимита на число процессов машина быстро исчерпывает физическую память.
Ограничения процессов Linux можно настроить через /etc/security/limits.conf и PAM, чтобы избежать bash fork-bomb.

Можно привести функцию к более понятному виду:

bomb() { 
 bomb | bomb &
}; bomb

Правильно сконфигурированные Linux/Unix системы должны быть обезопасены от поведения такого рода fork() bomb.
При выполнении dmesg обнаруживаем:
[58679.778420] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-19.scope

Ресурсы ядра и процессов, выделенных пользователю, по умолчанию ограничены, значения ограничений можно посмотреть

vagrant@vagrant:~$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 15389
max locked memory       (kbytes, -l) 65536
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 15389
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited  

Таким образом, при достижении пороговых максимально разрешенных значений, дальнейшее исчерпание ресурсов прекращается, 
и в результате, выполнение fork() bomb не приводит к фатальным последствиям в виде полного исчерпания ресурсов 
с необходимостью перезагрузки ОС.







