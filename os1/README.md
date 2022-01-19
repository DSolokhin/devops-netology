1.  **strace -e stat bash -c "cd /tmp" | tee /tmp/log**    

stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
**stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0**  

2. **/etc/magic**  
3. **cat /dev/null >| /proc/[pid]/fd/[дискриптор] или же без перенаправления потоков утилитой truncate -s 0 /proc/[pid]/fd/[дискриптор]**  
4. Ресурсы памяти или процессора не занимают, но накапливание необрабатываемых зомби приводит к утечке ресурсов в виде накопления записей в таблице процессов. Обычно в таких случаях аппаратно перезапускают ОС.  
5.  /usr/local/share/dbus-1/system-services  
    /lib/dbus-1/system-services  
6. uname возвращает информацию о системе в структуру с адресом buf. Структура utsname определена в <sys/utsname.h>   
   Альтернативное местоположение /proc/version  
   **vagrant@vagrant:~$ cat /proc/version  
   Linux version 5.4.0-91-generic (buildd@lcy01-amd64-017) (gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)) #102-Ubuntu SMP Fri Nov 5 16:31:28 UTC 2021**    
   Строка 2583 /proc/sys/kernel/ostype and /proc/sys/kernel/osrelease  
              These files give substrings of /proc/version.  
              
   
  

