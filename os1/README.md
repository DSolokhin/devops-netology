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
