1. Не удолось подключиться ни к одному публичному маршрутизатору, пробовал даже напрямую с микротика.  
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
   

Статические маршруты на примере Cloud интервейсов в Еве
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


   
