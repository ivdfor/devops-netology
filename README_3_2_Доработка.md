Добрый день,

Получилось-
Последовательность:

igord@igord-virtual-machine:~$ htop

[1]+  Stopped                 htop

igord@igord-virtual-machine:~$ bg
[1]+ htop &

igord@igord-virtual-machine:~$ jobs -l
[1]+  3923 Stopped (tty output)    htop

igord@igord-virtual-machine:~$ disown htop
bash: warning: deleting stopped job 1 with process group 3923


igord@igord-virtual-machine:~$ tmux 
[detached (from session 0)]

igord@igord-virtual-machine:~$ reptyr 3923

Результат выполнения htop появился в терминале

Спасибо,
С уважением,
Игорь

>Добрый день!

>Задание 13
>Не получилось выполнить?

>С уважением,
>Алексей
