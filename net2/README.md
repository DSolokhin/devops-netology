1. solo@solo-20424:~/net2$ ip -c -br li  
   lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP>   
   enp1s0           DOWN           1c:83:41:05:7c:a0 <NO-CARRIER,BROADCAST,MULTICAST,UP>   
   wlp2s0           UP             ac:d1:b8:f1:39:8b <BROADCAST,MULTICAST,UP,LOWER_UP>  
В старых дистрибутивах Linux использовалась команда ifconfig, аналогично в Windows ipconfig.  

2. Протокол обнаружения соседей (Neighbor Discovery Protocol, NDP) Этот протокол устанавливает пять различных типов пакета ICMPv6 (Router Discovery, обноружение мак адресов, дубликатов адресов). Одной из основных команда ARP - это апределение mac адреса ао IP.  
   solo@solo-20424:~/net2$ arp -a  
_gateway (192.168.0.1) at 28:ee:52:59:82:d4 [ether] on wlp2s0  

3.
