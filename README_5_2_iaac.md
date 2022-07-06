# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

## Задача 1

Опишите своими словами основные преимущества применения на практике IaaC паттернов.
Какой из принципов IaaC является основополагающим?

### Ответ:
```
IaaC паттерны позволяют автоматизировать и систематизировать конфигурирование инфраструктуры,
что ускоряет процесс развертывания, обеспечивает его унификацию, стабильность, масштабирование и безопасность, 
позволяет избегать проблем, связанных с элементарными ошибками ручного конфигурирования, дрейфом конфигураций,
приводит к стандартизации процесса, обеспечивает быстрое аварийное восстановление при нештатных ситуациях и сбоях 
за счет отката к последнему работоспособному состоянию.

Основополагающим принципом IaaC является идемпотентность- принцип, который позволяет быть однозначно уверенным в том,
что сколько раз бы не проводилось некое событие, результат его выполнения будет однозначно один и тот же.
```

### Задача 2

Чем Ansible выгодно отличается от других систем управление конфигурациями?
Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

### Ответ:
```
Ansible - достаточно прост, популярен (а значит, при его использовании не будет проблем с документацией и поиском квалифицированных кадров),
использует метод push, что не требует установки каких-либо агентов, для подключения к оборудованию использует стандартный ssh, что упрощает 
процесс подключения к устройствам в уже существующей инфраструктуре,
плейбуки в Ansible- это файл в формате YAML- легко читаемый, понимаемый и редактируемый даже для новичков.

Наиболее надежен гибридный метод. Он позволяет при необходимости использовать достоинства обоих методов- например, в стандартной ситуации использовать
метод pull, как более стабильный, не приводящий, в отличие от push, к пиковым нагрузкам на инфраструктуру в части аппаратных ресурсов и ресурсов сети
при одновременном изменении конфигурации на десятках или сотнях серверов.
Однако, гибридный метод позволяет, в свою очередь, при необходимости использовать и метод push- например, в случаях необходимости применения срочных 
критичных обновлений либо при аварийных ситуациях, откатах к предыдущим стабильным работоспособным состояниям.
```

## Задача 3

Установить на личный компьютер:

VirtualBox
Vagrant
Ansible
Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.

### Ответ:
```
### VirtualBox

igord@ubuntu:~$ vboxmanage --version
6.1.34_Ubuntur150636

### Vagrant

igord@ubuntu:~$ vagrant --version
Vagrant 2.2.19

### Ansible

igord@ubuntu:~$ ansible --version
ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/igord/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Mar 15 2022, 12:22:08) [GCC 9.4.0]

```

##Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Создать виртуальную машину.
Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды

docker ps

###Ответ:
```
vagrant@server1:~$ service docker status
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2022-07-05 21:48:35 UTC; 44min ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 14905 (dockerd)
      Tasks: 7
     Memory: 34.8M
     CGroup: /system.slice/docker.service
             └─14905 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

Jul 05 21:48:34 server1 dockerd[14905]: time="2022-07-05T21:48:34.483782982Z" level=warning msg="Your kernel does not support CPU realtime scheduler"
Jul 05 21:48:34 server1 dockerd[14905]: time="2022-07-05T21:48:34.484036133Z" level=warning msg="Your kernel does not support cgroup blkio weight"
Jul 05 21:48:34 server1 dockerd[14905]: time="2022-07-05T21:48:34.484151828Z" level=warning msg="Your kernel does not support cgroup blkio weight_device"
Jul 05 21:48:34 server1 dockerd[14905]: time="2022-07-05T21:48:34.485610481Z" level=info msg="Loading containers: start."
Jul 05 21:48:34 server1 dockerd[14905]: time="2022-07-05T21:48:34.704836608Z" level=info msg="Default bridge (docker0) is assigned with an IP address 172.17.0.0/16. Daemon option --bip can be used to se>
Jul 05 21:48:34 server1 dockerd[14905]: time="2022-07-05T21:48:34.877962916Z" level=info msg="Loading containers: done."
Jul 05 21:48:35 server1 dockerd[14905]: time="2022-07-05T21:48:35.110545087Z" level=info msg="Docker daemon" commit=a89b842 graphdriver(s)=overlay2 version=20.10.17
Jul 05 21:48:35 server1 dockerd[14905]: time="2022-07-05T21:48:35.111273767Z" level=info msg="Daemon has completed initialization"
Jul 05 21:48:35 server1 systemd[1]: Started Docker Application Container Engine.
Jul 05 21:48:35 server1 dockerd[14905]: time="2022-07-05T21:48:35.206826901Z" level=info msg="API listen on /run/docker.sock"
lines 1-21/21 (END)

```
