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

#with open('task4_dns.dic.js') as js, open('task4_dns.dic.yml') as yml:
#    print('\n', js.read(), '\n')
#    print(yml.read())


