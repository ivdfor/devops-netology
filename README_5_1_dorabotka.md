Добрый день!

Полная аппаратная виртуализация- ядро гостевой ОС не требует каких-либо изменений, не модифицируется, и гостевая ОС считает, что напрямую управляет физическим устройством.

Системные вызовы перехватываются и выполняются внутри гипервизора, но для гостевой ОС это выглядит так, как будто они выполняются в ее режиме ядра, как должно быть при обычном выполнении инструкций в привелигированном режиме.

 

Паравиртуализация — ядро гостевой ОС модернизируется для доступа к физическим ресурсам с помощью посредника- хостовой ОС (гипервизор).

Гостевая ОС обменивается с гипервизором запросами через гостевой API для получения каких-либо ресурсов, "понимая", что она не обращается и не распоряжается ресурсами напрямую.



>Добрый день!

>Задание 1
>В чём разница при работе с ядром гостевой ОС для полной и паравиртуализации?

>С уважением,
>Алексей
