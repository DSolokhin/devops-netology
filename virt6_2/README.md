**Задача 1**  
```
solo@solo-vm:~$ sudo docker pull postgres:12
solo@solo-vm:~$ sudo docker volume create pgvolume1
pgvolume1
solo@solo-vm:~$ sudo docker volume create pgvolume2
pgvolume2
solo@solo-vm:~$ sudo docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v pgvolume1:/var/lib/postgresql/data -v pgvolume2:/var/lib/postgresql postgres:12
solo@solo-vm:~$ sudo docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED              STATUS              PORTS                                       NAMES
b7264209b59d   postgres:12   "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   pg-docker
solo@solo-vm:~$ pgadmin3
```
![pg](https://user-images.githubusercontent.com/26553608/169488125-e609de76-76a6-4a6e-ae36-436b02ad6cb2.PNG)
