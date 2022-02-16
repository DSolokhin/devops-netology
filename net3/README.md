1. Не удалось подключиться ни к одному публичному маршрутизатору, пробовал даже напрямую с микротика.  
```
[solo@CentralOffice] > system telnet route-views.routeviews.org
Connecting to 128.223.51.103
telnet: connect() failed:  Connection timed out

Welcome back!
[solo@CentralOffice] > system telnet 172.16.1.1                
Connecting to 172.16.1.1
Connected to 172.16.1.1
Login: solo
Password: 

```

2. ```
   sudo modprobe -v dummy
   lsmod | grep dummy
   ifconfig -a | grep dummy
   ip addr add 192.168.1.150/24 dev dummy0
   ```
   ![route](https://user-images.githubusercontent.com/26553608/154031792-4f650907-39e9-4740-a3b0-cfaa766703a6.JPG)  
   

Статические маршруты на примере Cloud интерфейсов в Еве
```
/etc/network/interfaces
iface eth8 inet manual
auto pnet8
iface pnet8 inet static
    address 192.168.250.1
    netmask 255.255.255.0
    bridge_ports eth8
    bridge_stp off

iface eth9 inet manual
auto pnet9
iface pnet9 inet static
    address 192.168.255.1
    netmask 255.255.255.0
    bridge_ports eth9
    bridge_stp off
```
![r2](https://user-images.githubusercontent.com/26553608/154044161-c8613a57-51bd-4710-9918-873f1d47df33.JPG)

3. ![3](https://user-images.githubusercontent.com/26553608/154046573-b0daa80e-1322-4163-bb4f-51863a5aa9e6.JPG)  
У меня в данно примере используют протоколы tcp приложения:  
Вебсервер Apache на 80 порту (http), СУБД (MySQL) на 3306, протокол (VNC) порт 32769, ssh подключение на 22 порту.  

4.  ss -lu  
    У меня по протоколу UDP на 123 порту NTP сервер времени.  
    
5. Небольшая схема моей домашней сети:  

![My_home](https://user-images.githubusercontent.com/26553608/154059728-2bca314d-db06-404b-9525-ecb3ae5f4e96.jpg)  

В качестве доп задания установил себе на работе Netbox:

![netbox](https://user-images.githubusercontent.com/26553608/154238056-b3723841-0be6-4541-a883-bca0e04c73fd.JPG)







   
