1. solo@solo-20424:~/net2$ ip -c -br li  
   lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP>   
   enp1s0           DOWN           1c:83:41:05:7c:a0 <NO-CARRIER,BROADCAST,MULTICAST,UP>   
   wlp2s0           UP             ac:d1:b8:f1:39:8b <BROADCAST,MULTICAST,UP,LOWER_UP>  
В старых дистрибутивах Linux использовалась команда ifconfig, аналогично в Windows ipconfig.  

2. Протокол обнаружения соседей (Neighbor Discovery Protocol, NDP) Этот протокол устанавливает пять различных типов пакета ICMPv6 (Router Discovery, обнаружение мак адресов, дубликатов адресов). Одной из основных команда ARP -  определение mac адреса ао IP.  
   solo@solo-20424:~/net2$ arp -a  
_gateway (192.168.0.1) at 28:ee:52:59:82:d4 [ether] on wlp2s0  

3. VLAN - виртуальное разделение коммутатора. В linux устанавливается пакет vlan.  
   vi /etc/network/interfaces  
   auto vlan1400  
   iface vlan1400 inet static  
      address 192.168.1.1  
      netmask 255.255.255.0  
      vlan_raw_device eth0  
      
4. LAG – агрегация портов (bond).  
   /etc/network/interfaces  
   auto bond0  

iface bond0 inet static  
    address 10.31.1.5  
    netmask 255.255.255.0  
    network 10.31.1.0  
    gateway 10.31.1.254  
    bond-slaves eth0 eth1  
    bond-mode active-backup  
    bond-miimon 100  
    bond-downdelay 200  
    bond-updelay 200  
    
 5. 
   
