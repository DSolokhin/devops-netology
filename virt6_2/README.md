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

**Задача 2**  
![base](https://user-images.githubusercontent.com/26553608/169521074-eaa8872f-d8b7-4e82-a84b-97e85bcef80a.JPG)  

![describe](https://user-images.githubusercontent.com/26553608/169523793-3da56a13-53d5-4121-8bf8-737ee2363ff0.JPG)  

![users](https://user-images.githubusercontent.com/26553608/169524798-0d25efe2-2c59-4507-a5f1-70f561ddee49.JPG)  

**Задача 3**  

```
insert into orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
insert into clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
```
![row](https://user-images.githubusercontent.com/26553608/169805987-e1d9e54b-9250-47d4-893a-5f49115d5ad2.JPG)




