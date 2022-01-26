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
  
7. mdadm --create --verbose /dev/md1 -l 0 -n 2 /dev/sd{b2,c2}  
   ![fs7](https://user-images.githubusercontent.com/26553608/151127143-3306fd6c-6c42-426c-bf30-c37e59228cb6.JPG)

8. root@vagrant:~# pvcreate /dev/md0 /dev/md1  
  Physical volume "/dev/md0" successfully created.  
  Physical volume "/dev/md1" successfully created.  
  
9. vgcreate vg1 /dev/md0 /dev/md1     
![fs9](https://user-images.githubusercontent.com/26553608/151128937-f901fa58-3aaa-4db3-9b4c-7d16c792757b.JPG)  

10. root@vagrant:~# lvcreate -L 100M vg1 /dev/md1  
    Logical volume "lvol0" created.  
    
11. root@vagrant:~# mkfs.ext4 /dev/vg1/lvol0  
    mke2fs 1.45.5 (07-Jan-2020)  
    Creating filesystem with 25600 4k blocks and 25600 inodes  

    Allocating group tables: done  
    Writing inode tables: done  
    Creating journal (1024 blocks): done  
    Writing superblocks and filesystem accounting information: done  

12. root@vagrant:~# mkdir /tmp/new  
    root@vagrant:~# mount /dev/vg1/lvol0 /tmp/new  
    
13. ![fs13](https://user-images.githubusercontent.com/26553608/151130208-e7a2a9a0-5955-49f9-a514-483b49015e81.JPG)  

14. ![fs14](https://user-images.githubusercontent.com/26553608/151130512-7fc4d83e-8c4e-4a11-865c-717349c0d1a7.JPG)






   


