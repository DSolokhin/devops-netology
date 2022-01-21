1. Проверяю запуск службы после перезагрузки, скриншоты '''systemctl start (stop, restart) node_exporter''' не делал, так как поднялось с ос:  
![alt text](https://github.com/DSolokhin/devops-netology/blob/master/os2/nodw_exporter.JPG)  

Внешний файл для опций это EnvironmentFile для юнитов systemd 

![EnvironmentFile](https://user-images.githubusercontent.com/26553608/150527297-6b219ebf-384b-4fd2-8ab1-200224c7bfaa.JPG)  

2.  CPU: Seconds the CPUs spent in guests (VMs) for each mode.  
    node_cpu_guest_seconds_total{cpu="0",mode="nice"} 0  
    node_cpu_guest_seconds_total{cpu="0",mode="user"} 0  
    node_cpu_guest_seconds_total{cpu="1",mode="nice"} 0  
    node_cpu_guest_seconds_total{cpu="1",mode="user"} 0  
 



