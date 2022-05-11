**Задача 1**  
![docernginx](https://user-images.githubusercontent.com/26553608/167848959-491de486-f451-474b-81b3-c116ab60298b.JPG)

https://hub.docker.com/r/dsolokhin/webserver  

**Задача 2**  

Высоконагруженное монолитное java веб-приложение - монолитное веб-приложение предполагает сборку frontend, backend. Так как монолитное веб-приложение высоконагруженное, то стоит размещать на отдельном физическом сервере.    
Nodejs веб-приложение - контейнеризация подойдет, node.js - это env для javascript для построения логики работы веб-приложения, является его частью, модулем.    
Мобильное приложение c версиями для Android и iOS - предполагается, что приложение имеет своего потребителя, а значит необходим UI для взаимодействия с пользователем. По моему мнению, правильнее использовать виртуализацию.  
Шина данных на базе Apache Kafka - это сервис по трансляции данных из одного формата данных одного приложения в другое. По моему мнению хорошо применить контейнеризацию,  достигается простота масштабирования и управления. В данном случае необходимо организация отказоустойчивости.    
Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana - для упомянутых продуктов есть контейнеры на docker hub. В силу возможности реализации подходов IaaC, контейнеризация в данном случае помогает получить предсказуемый результат.  
Мониторинг-стек на базе Prometheus и Grafana - по моему мнению также как и пример с ELK, скорее всего с течением времени будут вноситься изменения в систему мониторинга и не один раз, будут добавляется метрики, так как точки мониторинга будут меняться - добавляться новый функционал, было бы не плохо применить IaaC и контейнеризация помогает этого добиться.    
MongoDB, как основное хранилище данных для java-приложения - либо виртуализация, либо контейнеризация, все зависит от реализации архитектуры приложения.
Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry - отдельный физический сервер или виртуализация, если сервер есть в наличии использовал бы его.   

**Задача 3**  

```
solo@solo-vm:~$ sudo docker run -d -v /data:/data centos sleep infinity
Unable to find image 'centos:latest' locally
latest: Pulling from library/centos
a1d0c7532777: Pull complete 
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
5e18d391c0468d87d30805de3018ea9babf82de3f3a4fec3431cd82da61a9558
solo@solo-vm:~$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND            CREATED          STATUS          PORTS     NAMES
5e18d391c046   centos    "sleep infinity"   29 seconds ago   Up 27 seconds             focused_haslett
solo@solo-vm:~$ sudo docker exec -it 5e18d391c046 bash
[root@5e18d391c046 /]# ll
[root@5e18d391c046 /]# ls -lhs
total 52K
   0 lrwxrwxrwx   1 root root    7 Nov  3  2020 bin -> usr/bin
4.0K drwxr-xr-x   2 root root 4.0K May 11 12:49 data
   0 drwxr-xr-x   5 root root  340 May 11 12:49 dev
4.0K drwxr-xr-x   1 root root 4.0K May 11 12:49 etc
4.0K drwxr-xr-x   2 root root 4.0K Nov  3  2020 home
   0 lrwxrwxrwx   1 root root    7 Nov  3  2020 lib -> usr/lib
   0 lrwxrwxrwx   1 root root    9 Nov  3  2020 lib64 -> usr/lib64
4.0K drwx------   2 root root 4.0K Sep 15  2021 lost+found
4.0K drwxr-xr-x   2 root root 4.0K Nov  3  2020 media
4.0K drwxr-xr-x   2 root root 4.0K Nov  3  2020 mnt
4.0K drwxr-xr-x   2 root root 4.0K Nov  3  2020 opt
   0 dr-xr-xr-x 305 root root    0 May 11 12:49 proc
4.0K dr-xr-x---   2 root root 4.0K Sep 15  2021 root
4.0K drwxr-xr-x  11 root root 4.0K Sep 15  2021 run
   0 lrwxrwxrwx   1 root root    8 Nov  3  2020 sbin -> usr/sbin
4.0K drwxr-xr-x   2 root root 4.0K Nov  3  2020 srv
   0 dr-xr-xr-x  13 root root    0 May 11 12:49 sys
4.0K drwxrwxrwt   7 root root 4.0K Sep 15  2021 tmp
4.0K drwxr-xr-x  12 root root 4.0K Sep 15  2021 usr
4.0K drwxr-xr-x  20 root root 4.0K Sep 15  2021 var
[root@5e18d391c046 /]# exit
exit
solo@solo-vm:~$ sudo docker run -d -v /data:/data debian sleep infinity
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
67e8aa6c8bbc: Pull complete 
Digest: sha256:6137c67e2009e881526386c42ba99b3657e4f92f546814a33d35b14e60579777
Status: Downloaded newer image for debian:latest
6cc28e91c545b0dfb2a3bb94c426e0152becc665687d42f11a291bd9de90221a
solo@solo-vm:~$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND            CREATED          STATUS          PORTS     NAMES
6cc28e91c545   debian    "sleep infinity"   8 seconds ago    Up 6 seconds              jolly_swartz
5e18d391c046   centos    "sleep infinity"   15 minutes ago   Up 15 minutes             focused_haslett
solo@solo-vm:~$ sudo docker exec -it 5e18d391c046 bash
[root@5e18d391c046 /]# echo '' > /data/centos.txt
[root@5e18d391c046 /]# ls /data
centos.txt
solo@solo-vm:/data$ sudo touch host.txt
solo@solo-vm:/data$ ll
итого 12
drwxr-xr-x  2 root root 4096 мая 11 16:18 ./
drwxr-xr-x 21 root root 4096 мая 11 15:49 ../
-rw-r--r--  1 root root    1 мая 11 16:12 centos.txt
-rw-r--r--  1 root root    0 мая 11 16:18 host.txt
solo@solo-vm:/data$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND            CREATED          STATUS          PORTS     NAMES
6cc28e91c545   debian    "sleep infinity"   15 minutes ago   Up 14 minutes             jolly_swartz
5e18d391c046   centos    "sleep infinity"   30 minutes ago   Up 30 minutes             focused_haslett
solo@solo-vm:/data$ sudo docker exec -it 6cc28e91c545 bash
root@6cc28e91c545:/# ls /data
centos.txt  host.txt
root@6cc28e91c545:/# 
```
