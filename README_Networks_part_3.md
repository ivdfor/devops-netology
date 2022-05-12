Домашнее задание по лекции "Компьютерные сети (лекция 3)"

1) Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP

telnet route-views.routeviews.org

Username: rviews

show ip route x.x.x.x/32

show bgp x.x.x.x/32

Ответ:

route-views>sho ip route 37.144.209.96

Routing entry for 37.144.0.0/14

  Known via "bgp 6447", distance 20, metric 0

  Tag 3356, type external

  Last update from 4.68.4.46 1w2d ago

  Routing Descriptor Blocks:

  * 4.68.4.46, from 4.68.4.46, 1w2d ago

      Route metric is 0, traffic share count is 1

      AS Hops 2
 
      Route tag 3356

      MPLS label: none

route-views>show bgp 37.144.209.96/32

% Network not in table

route-views>show bgp 37.144.209.96

BGP routing table entry for 37.144.0.0/14, version 2248535172

Paths: (24 available, best #8, table default)

  Not advertised to any peer

  Refresh Epoch 1

  7018 3356 8402

    12.0.1.63 from 12.0.1.63 (12.0.1.63)

      Origin IGP, localpref 100, valid, external

      Community: 7018:5000 7018:37232

      path 7FE119106D88 RPKI State not found

      rx pathid: 0, tx pathid: 0
	
................поскипал дальнейший вывод...............
    

2) Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

Ответ:

vagrant@vagrant:~$ sudo ip link add dev dum0 type dummy

vagrant@vagrant:~$ sudo ip address add 10.10.10.1/32 dev dum0

vagrant@vagrant:~$ sudo ip link set dev dum0 up

vagrant@vagrant:~$ ip address show dum0

3: dum0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000

    link/ether b2:1b:00:c9:6e:8d brd ff:ff:ff:ff:ff:ff

    inet 10.10.10.1/32 scope global dum0

       valid_lft forever preferred_lft forever

    inet6 fe80::b01b:ff:fec9:6e8d/64 scope link

       valid_lft forever preferred_lft forever

vagrant@vagrant:~$ sudo ip route add 8.8.8.8/32 via 10.0.2.2

vagrant@vagrant:~$ sudo ip route add 8.8.4.4/32 dev eth0

vagrant@vagrant:~$ sudo ip route add 2.2.2.2/32 dev dum0 metric 55

vagrant@vagrant:~$ ip route


default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100

2.2.2.2 dev dum0 scope link metric 55

8.8.4.4 dev eth0 scope link

8.8.8.8 via 10.0.2.2 dev eth0

10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15

10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100


3) Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

Ответ:

Т.к. на моей отсутствуют какие-либо сервисы, ВМ создана под курс, то прослушивается минимум tcp-портов:

igord@ubuntu:~$ ss -ltpn

State    Recv-Q   Send-Q     Local Address:Port     Peer Address:Port  Process  

LISTEN   0        4096       127.0.0.53%lo:53            0.0.0.0:*              

LISTEN   0        5              127.0.0.1:631           0.0.0.0:*  
            
LISTEN   0        5                  [::1]:631              [::]:*      
        
LISTEN   0        4096                   *:9100                *:*           

127.0.0.53 - адрес, использумый Ubuntu для локального кешинга dns-записей, по нему прослушиваются dns-запросы по tcp порту 53

127.0.0.1 - локальная петля, свой собственный адрес, слушает tcp порт 631, используемый IPP (Internet Printing Protocol) - предназначенный для прослушивания задач коммуникации q:между ПК и принтерами

Далее, tcp-порт 9100 используется Printer PDL Data Stream для удаленного обслуживания принтеров- проверки, закачки обновлений


4) Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

Ответ:

igord@ubuntu:~$ ss -lupn

State                   Recv-Q                  Send-Q                                   Local Address:Port                                    Peer Address:Port  
                Process                  
UNCONN                  0                       0                                        127.0.0.53%lo:53                                           0.0.0.0:*
                                              
UNCONN                  0                       0                                              0.0.0.0:5353                                         0.0.0.0:*
                                              
UNCONN                  0                       0                                              0.0.0.0:44453                                        0.0.0.0:*    
                                          
UNCONN                  0                       0                                              0.0.0.0:631                                          0.0.0.0:*    
                                          
UNCONN                  0                       0                                                 [::]:48322                                           [::]:* 
                                             
UNCONN                  0                       0                                                 [::]:5353                                            [::]:*   

udp-порт 5353 - Multicast DNS
udp-порт 44453 - Unassigned
udp-порт 631 -  IPP (Internet Printing Protocol)
udp-порт 48322 - Unassigned
                                           

5) Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

Ответ:

Диаграмма доступна по ссылке:

https://github.com/ivdfor/devops-netology/blob/main/jpg/%D0%94%D0%97%20%D0%9A%D0%BE%D0%BC%D0%BF%D1%8C%D1%82%D0%B5%D1%80%D0%BD%D1%8B%D0%B5%20%D1%81%D0%B5%D1%82%D0%B8%203/diagram.drawio


