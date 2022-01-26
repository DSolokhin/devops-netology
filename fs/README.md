1. Разрежённый файл (англ. sparse file) — файл, в котором последовательности нулевых байтов заменены на информацию об этих последовательностях.  
fsutil file createnew test.nul 10000000000  
fsutil sparse setflag test.nul  
fsutil sparse setrange test.nul 0 10000000000  

2. Файлы с жесткими ссылками имеют ту же информацию inode и набор разрешений что и у исходного файла, права на хард ссылки изменяются при изменении прав исходного файла.    

3. ![alt text](https://github.com/DSolokhin/devops-netology/blob/master/fs/fs3.JPG)  

4. ![fs4](https://user-images.githubusercontent.com/26553608/151122158-d4173d89-8a8f-4eaa-adc9-1da741dcfd4a.JPG)

5. sfdisk -d /dev/sdb | sfdisk /dev/sdc  
   ![fs5](https://user-images.githubusercontent.com/26553608/151122367-fd83559d-0a17-4973-bd41-1c7ab577f222.JPG)

   
6. mdadm --create --verbose /dev/md0 -l 1 -n 2 /dev/sd{b1,c1}     
  ![fs6](https://user-images.githubusercontent.com/26553608/151126009-bb09d6ba-8891-4ca4-9566-0f8fe8f6a59a.JPG)

   


