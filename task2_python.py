#!/usr/bin/env python3

import os


#bash_command = ["cd ~/devops-netology/devops-netology", "git status"]
user_path= 'cd ' + input('Enter the path for searching modified files: ')
bash_command = [user_path, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
#user_path= 'cd ' + input('Enter the path for searching modified files: ')
#print(user_path)
#bash_command = [user_path, "git status"]
print(bash_command)
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        prepare_path = bash_command[0].split()
        print('\n', prepare_path[1],':',prepare_result, '\n')
        
        
