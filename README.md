Task 2.1

#
#В файле README.md опишите своими словами какие файлы будут проигнорированы в будущем благодаря добавленному .gitignore
#

# В данном случае мы игнорируем все вложенные каталоги, содержащие директорию /.terraform/ с любым содержимым этих подкатологов

**/.terraform/*

# В данном случае игнорируются все сущности, содержащие на конце имени .tfstate а так же любые файлы, содержащие внутри себя .tfstate.

*.tfstate
*.tfstate.*

# В данном случае игнорируются файлы с точным наименованием crash.log, а так же файлы, содержащие crash.<любой символ(ы)>.log 

crash.log
crash.*.log

# В данном случае игнорируются файлы, содержащие в конце имени .tfvars и .tfvars.json

*.tfvars
*.tfvars.json

# В данном случае игнорируются файлы с точным наименованием override.tf и override.tf.json, 
# а так же с любыми символом(символами) в позиции '*'  *_override.tf и *_override.tf.json

override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Отмена исключения для файлов с именем example_override.tf, несмотря на предыдущее правило, под которое
# подпадают файлы *_override.tf

!example_override.tf

# Игнорировать файлы с именами, строго соответствующими именам .terraformrc terraform.rc
 
.terraformrc
terraform.rc
