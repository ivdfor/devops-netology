# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

Исправленный Json:
```
{ "info" : "Sample JSON output from our service\t",
   "elements" : [
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            },
            { "name" : "second",
             "type" : "proxy",
            "ip" : "71.78.22.43"
            } 
        ]
}
```
## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import ast
import json
import yaml

url_keys = ['drive.google.com', 'mail.google.com', 'google.com']
dict_dns = {}

with open('task4_dns.dic', 'r+') as f:
    str_dic = f.read()
    if str_dic:
       dict_dns = ast.literal_eval(str_dic)
    if dict_dns.get('google.com') == None:
        dict_dns = dict.fromkeys(url_keys)
        for key in dict_dns:
            current_ip = socket.gethostbyname(key)
            print('[ERROR] ', key, 'IP mismatch: ', dict_dns[key], current_ip)
            dict_dns[key] = current_ip
    else:
        for key in dict_dns:
            current_ip = socket.gethostbyname(key)
            if dict_dns[key] == current_ip:
                print(key, ' - ', dict_dns[key])
            else:
                print('[ERROR] ', key, 'IP mismatch: ', dict_dns[key], current_ip)
                dict_dns[key] = current_ip

with open('task4_dns.dic', 'w') as f:
    f.write(str(dict_dns))


with open('task4_dns.dic.js', 'w') as js, open('task4_dns.dic.yml', 'w') as yml:
    json.dump(dict_dns, js)
    yaml.dump(dict_dns, yml)
```

### Вывод скрипта при запуске при тестировании:
```
igord@ubuntu:~/devops-netology/devops-netology$ ./task4_python.py 
[ERROR]  drive.google.com IP mismatch:  64.233.162.194 74.125.205.194
[ERROR]  mail.google.com IP mismatch:  142.250.74.5 74.125.131.19
[ERROR]  google.com IP mismatch:  142.250.74.78 173.194.222.139
igord@ubuntu:~/devops-netology/devops-netology$ ./task4_python.py 
drive.google.com  -  74.125.205.194
[ERROR]  mail.google.com IP mismatch:  74.125.131.19 74.125.131.83
[ERROR]  google.com IP mismatch:  173.194.222.139 173.194.222.138

```

### json-файл(ы), который(е) записал ваш скрипт:
```json
igord@ubuntu:~/devops-netology/devops-netology$ cat task4_dns.dic.js
{"drive.google.com": "74.125.205.194", "mail.google.com": "74.125.131.83", "google.com": "173.194.222.138"}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
igord@ubuntu:~/devops-netology/devops-netology$ cat task4_dns.dic.yml
drive.google.com: 74.125.205.194
google.com: 173.194.222.138
mail.google.com: 74.125.131.83
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
???
```

### Пример работы скрипта:
???
