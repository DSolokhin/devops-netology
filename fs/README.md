1. Разрежённый файл (англ. sparse file) — файл, в котором последовательности нулевых байтов заменены на информацию об этих последовательностях.  
fsutil file createnew test.nul 10000000000  
fsutil sparse setflag test.nul  
fsutil sparse setrange test.nul 0 10000000000  

2. 

3. 
