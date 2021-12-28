1.  Установил Oracle VM VirtualBox  

![1](https://user-images.githubusercontent.com/26553608/147535169-20807114-fb7c-43a7-9983-b57fdcdd1b31.PNG)

2, 3. Установил Vagrant, в терминале проверил установку:

![2](https://user-images.githubusercontent.com/26553608/147536987-5700f5e6-e34a-478e-9d4a-25d6114ba848.PNG)

4. Создал дерикторию *mkdir vagrant*, инициализирую *cd vagrant*, *vagrant init* и редактирую появившийся конфиг Vagrantfile  
![4](https://user-images.githubusercontent.com/26553608/147545431-bc000d49-f2e3-43c2-99e3-00184c2c2f5f.PNG)

Запускаю конфиг *vagrant up*, выкачивается образ, но при запуске vm ошибка. Отключаю диспетчер Hyper-V и все что связано с ним.  
Виртуальная машина работает:  
![4_1](https://user-images.githubusercontent.com/26553608/147545799-94fd464d-13c6-4467-a4a2-c6d0d617bb8f.PNG)
Выключаю vm *vagrant suspend*, в VirtualBox наблюдаю, как сохраняется состояние.  

5. Выделено по умолчанию: 1гб озу, 4 мб видеопамяти, 2 ядра процессора, а также виртуальный диск 64 гб и виртаульный сетевой адаптер с NAT.  
![5](https://user-images.githubusercontent.com/26553608/147548778-87bf0b28-ed1c-425e-9238-7249b8be1ab5.PNG)  

6. Добавить оперативной памяти или изменить коль-во ядер процессора можно путем редактирования конфигурационного файла Vagrantfile  
   Раскомментируем или добавим параметры:  
       *config.vm.provider "virtualbox" do |v|*  
         *v.memory = 2048*  
         *v.cpus = 4*   
       *end*  
   Судя по опыту с Hyper-v это нужно делать сразу перед соданием vm.
