1. Разрежённый файл (англ. sparse file) — файл, в котором последовательности нулевых байтов заменены на информацию об этих последовательностях.  
fsutil file createnew test.nul 10000000000  
fsutil sparse setflag test.nul  
fsutil sparse setrange test.nul 0 10000000000  

2. Файлы с жесткими ссылками имеют ту же информацию inode и набор разрешений что и у исходного файла, права на хард ссылки изменяются при изменении прав исходного файла.    

3. ![alt text](https://github.com/DSolokhin/devops-netology/blob/master/fs/fs3.JPG)  

4. ![fs4](https://user-images.githubusercontent.com/26553608/151120030-27328589-5577-47ab-bb55-bccd29f6f50c.JPG)

5. 


