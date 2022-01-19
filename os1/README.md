1.  **strace -e stat bash -c "cd /tmp" | tee /tmp/log**    

stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
**stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0**  

2. /etc/magic**  Файл magic.mgc  
3. cat /dev/null >| /proc/[pid]/fd/[дискриптор] или же без перенаправления потоков утилитой truncate -s 0 /proc/[pid]/fd/[дискриптор]   
4. Ресурсы памяти или процессора не занимают, но накапливание необрабатываемых зомби приводит к утечке ресурсов в виде накопления записей в таблице процессов. Обычно в таких случаях аппаратно перезапускают ОС.  
5.  /proc/615/cgroup  
    /proc/386/cgroup  
    /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.procs  
    /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.threads  
    /var/run/utmp  
    /usr/local/share/dbus-1/system-services  
    /usr/share/dbus-1/system-services  
    /lib/dbus-1/system-services  
    /var/lib/snapd/dbus-1/system-services/  
6. uname возвращает информацию о системе в структуру с адресом buf. Структура utsname определена в <sys/utsname.h>   
   Альтернативное местоположение /proc/version  
   vagrant@vagrant:~$ cat /proc/version  
   Linux version 5.4.0-91-generic (buildd@lcy01-amd64-017) (gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)) 102-Ubuntu SMP Fri Nov 5 16:31:28 UTC 2021  
   Строка 2583 /proc/sys/kernel/ostype and /proc/sys/kernel/osrelease  
              These files give substrings of /proc/version.  
7. Если в командной строке стоит command1 && command2, то command2 выполняется в том, и только в том случае, если статус выхода из команды command1 равен нулю, что говорит об    успешном ее завершении. В данном случае (test -d /tmp/some_dir && echo Hi) command1 равен 1, так как при проверке каталога some_dir не существует. В случае test -d /tmp/some_dir; echo Hi команды выполняются поочереди независимо от условия первой команды.  Если применить set -e то && не нужно, так как флаг -e означает выйти немедленно, если команда завершается с ненулевым статусом.   
8. set -euxo pipefail состоит из:  
   e - Выйти немедленно, если команда завершается с ненулевым статусом.  
   u - Считать неустановленные переменные ошибкой при подстановке.   
   x - Печатать команды и их аргументы по мере их выполнения.  
   o - имя опции, pipefail - возвращаемое значение конвейера — это статус последней команды для выхода с ненулевым статусом, или ноль, если ни одна команда не завершилась с    ненулевым статусом. Этот параметр предотвращает маскирование ошибок в конвейере. В случае сбоя какой-либо команды в конвейере этот код возврата будет использоваться как код возврата для всего конвейера. По умолчанию конвейер возвращает код последней команды, даже если она выполнена успешно.
9. vagrant@vagrant:~$ ps axo stat  
   STAT  
   Ss  
   S  
   Дополнительные буквы статусов:  
   < - высокоприоритетный (не приятный для других пользователей)  
   N -низкоприоритетный (приятный для других пользователей)  
   L - имеет страницы, заблокированные в памяти (для ввода-вывода в реальном времени и пользовательского ввода-вывода)  
   s - является лидером сессии  
   l - является многопоточным  
   + - находится в группе процессов переднего плана.    
              
   
  

