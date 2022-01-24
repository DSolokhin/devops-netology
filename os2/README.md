1. Проверяю запуск службы после перезагрузки, скриншоты '''systemctl start (stop, restart) node_exporter''' не делал, так как поднялось с ос:  
![alt text](https://github.com/DSolokhin/devops-netology/blob/master/os2/nodw_exporter.JPG)  

Внешний файл для опций это EnvironmentFile для юнитов systemd  
EnvironmentFile=-/etc/default/cron  #внешний файл  
ExecStart=/usr/sbin/cron -f -P $EXTRA_OPTS #переменная для дополнительных опций.

![EnvironmentFile](https://user-images.githubusercontent.com/26553608/150527297-6b219ebf-384b-4fd2-8ab1-200224c7bfaa.JPG)  

2.  curl -s localhost:9100/metrics    
    CPU:  node_cpu_guest_seconds_total  
          process_cpu_seconds_total
    MEM: process_virtual_memory_bytes  
    HDD: node_filesystem_avail_bytes  
    NETWORK: node_network_receive_bytes  
             node_network_receive_packets_total  
 
 3.
 ![netdata](https://user-images.githubusercontent.com/26553608/150738217-83723776-036f-4455-b0d9-99054d5154e3.JPG)  
 
 4. dmesg -T  
    systemd[1]: Detected virtualization oracle.  
    [Mon Jan 24 07:11:43 2022] systemd[1]: Detected architecture x86-64.  
    [Mon Jan 24 07:11:43 2022] systemd[1]: Set hostname to <vagrant>.  
    
 5. fs.nr_open - это системное значение лимит на количество открытых дескрипторов, по умолчанию:  
     vagrant@vagrant:~$ /sbin/sysctl -n fs.nr_open  
     1048576   
    Соответствует файл /proc/sys/fs/nr_open  
    
 6. 
    

    
     
    
    
 



