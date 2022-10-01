**Задача 1**  

В режиме global сервис запускается на всех нодах. Если используется режим replication, то указывается количество реплик используемых для сервиса.  

Для управления глобальным состоянием кластера используется протокол Raft, данным протоколом происходит выбор лидера путем голосования.  

Используется для связи контейнеров расположенных на разных хостах. При построении используется уже существующая сеть и технология vxlan.  

**Задача 2**  

![node](https://user-images.githubusercontent.com/26553608/168236002-b2f159a6-4855-4ccd-8672-2d94c68501dd.PNG)  

**Задача 3**  

![services](https://user-images.githubusercontent.com/26553608/168236859-750d2411-beb0-4f10-ab4d-bbcc4db2df42.PNG)  

**Задача 4**  

```
[centos@node01 ~]$ sudo -i
[root@node01 ~]# docker swarm update --autolock=true
Swarm updated.
To unlock a swarm manager after it restarts, run the `docker swarm unlock`
command and provide the following key:

    SWMKEY-1-XAQhe6lA0wlWIroUx7nHWggeVBCzj9fnezlyUpHwxzs

Please remember to store this key in a password manager, since without it you
will not be able to restart the manager.
```
Это docker secret для доступа к логам swarm, команда автоблокировка по умолчанию, для анлока потребуется этот ключ и его нужно сохранить.  







