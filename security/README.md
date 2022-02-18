1.
![bitwarden](https://user-images.githubusercontent.com/26553608/154417456-5cad85a5-61cf-48f5-bd14-ac12633a6204.JPG)  

2.

![bitwarden2](https://user-images.githubusercontent.com/26553608/154421454-09ea768f-1996-4ed8-aaca-c8bdd0ce15a7.JPG)  
![bitwarden3](https://user-images.githubusercontent.com/26553608/154421484-1f54c6cc-3ad9-499b-9688-a1156b4c3762.JPG)  

3.

![cert](https://user-images.githubusercontent.com/26553608/154549084-b20f23fa-d7f7-4f60-9f66-a79076fc9974.jpg)  

4. Проверил несколько сайтов, уязвимостей не нашел

![testssl](https://user-images.githubusercontent.com/26553608/154639172-671cbbef-113d-4691-8780-719e13f3c18f.JPG)  

5. Сгенерировал ключ:    
   ![ssl1](https://user-images.githubusercontent.com/26553608/154654601-00ee4ab7-5539-4d32-8ff8-e0f3a73be60b.JPG)  
   
   Скопировал на удаленный сервер:  
   ![ssl2](https://user-images.githubusercontent.com/26553608/154654780-186bb86c-a4c7-443f-b9c9-65854134946d.JPG)  
   
   Подключился по ssh ключу:  
   ![ssl3](https://user-images.githubusercontent.com/26553608/154655000-314151c0-1320-4965-91f7-31e9f059ddc9.JPG)  
   
 6. Создал ssh конфиг с указанием переименованных ключей:  
    ![ssl4](https://user-images.githubusercontent.com/26553608/154684255-b64cfa3d-1ce4-4298-9b45-fe7a03ca2995.JPG)  
    Добавил в /etc/hosts сопаставление реального Ip с хостом, подключаемся по имени:  
    ![ssl5](https://user-images.githubusercontent.com/26553608/154684577-a1e441ba-715d-4804-bb6a-f2931956e408.JPG)  
    
  7. Собираем сто покетов в файл:
     ```
     root@vagrant:~# tcpdump -i any -c 100 -w 0001.pcap
     tcpdump: listening on any, link-type LINUX_SLL (Linux cooked v1), capture size 262144 bytes
     100 packets captured
     107 packets received by filter
     0 packets dropped by kernel
     ```
     Закидываю в шару и открываю в Wireshark в windows:  
     ![ssl6](https://user-images.githubusercontent.com/26553608/154690345-cbe90331-ba1c-44a5-aa2f-270e6fe8be49.JPG)



   
   


   







