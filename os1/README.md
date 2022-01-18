1.  **strace -e stat bash -c "cd /tmp" | tee /tmp/log**    

stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
stat("/usr/bin/bash", {st_mode=S_IFREG|0755, st_size=1183448, ...}) = 0  
**stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0**  

2. **/etc/magic**  
3. **cat /dev/null >| /proc/[pid]/fd/[дискриптор] или же без перенаправления потоков утилитой truncate -s 0 /proc/[pid]/fd/[дискриптор]
