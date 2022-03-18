1) Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.

igord@igord-virtual-machine:~/devops-netology/terraform$ git show aefea
commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Jun 18 10:29:58 2020 -0400

    Update CHANGELOG.md


Ответ-
полный хеш - aefead2207ef7e2aa5dc81a34aedf0cad4c32545
комментарий коммита - Update CHANGELOG.md


2) Какому тегу соответствует коммит 85024d3?

igord@igord-virtual-machine:~/devops-netology/terraform$ git show 85024d3
commit 85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23)


Ответ - tag: v0.12.23

3) Сколько родителей у коммита b8d720? Напишите их хеши.

igord@igord-virtual-machine:~/devops-netology/terraform$ git show -s --pretty=%P b8d720
56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b

либо

igord@igord-virtual-machine:~/devops-netology/terraform$ git log --pretty=%P -n 1 b8d720
56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b


Ответ - 2 коммита, их хеши:
56cd7859e05c36c06b56d013b55a252d0bb7e158 
9ea88f22fc6269854151c571162c5bcf958bee2b

4) Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24

igord@igord-virtual-machine:~/devops-netology/terraform$ git log --pretty=oneline v0.12.23..v0.12.24
33ff1c03bb960b332be3af2e333462dde88b279e (tag: v0.12.24) v0.12.24
b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links
3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md
6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location
06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md
d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows
4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md
dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md
225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release


Ответ - 

33ff1c03bb960b332be3af2e333462dde88b279e (tag: v0.12.24) v0.12.24
b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links
3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md
6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location
06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md
d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows
4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md
dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md
225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release

5) Найдите коммит в котором была создана функция func providerSource, 
ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).

igord@igord-virtual-machine:~/devops-netology/terraform$ git log -S "func providerSource(" --oneline
8c928e835 main: Consult local directories as potential mirrors of providers


Ответ -

8c928e835 main: Consult local directories as potential mirrors of providers

6) Найдите все коммиты в которых была изменена функция globalPluginDirs.

igord@igord-virtual-machine:~/devops-netology/terraform$ git log -L :providerSource:provider_source.go 
commit 5af1e6234ab6da412fb8637393c5a17a1b293663
...skipped...
commit 92d6a30bb4e8fbad0968a9915c6d90435a4a08f6
...skipped...
commit 8c928e83589d90a031f811fae52a81be7153e82f
...skipped...


Ответ -
commit 5af1e6234ab6da412fb8637393c5a17a1b293663
commit 92d6a30bb4e8fbad0968a9915c6d90435a4a08f6
commit 8c928e83589d90a031f811fae52a81be7153e82f


7) Кто автор функции synchronizedWriters?

igord@igord-virtual-machine:~/devops-netology/terraform$ git log -S "func synchronizedWriters(" --oneline
bdfea50cc remove unused
5ac311e2a main: synchronize writes to VT100-faker on Windows

igord@igord-virtual-machine:~/devops-netology/terraform$ git blame synchronized_writers.go 5ac311e2a
...skipped...
5ac311e2a9 (Martin Atkins 2017-05-03 16:25:41 -0700 15) func synchronizedWriters(targets ...io.Writer) []io.Writer {
...skipped...


Ответ -

Author: Martin Atkins 

















