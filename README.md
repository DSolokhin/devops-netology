Answers on 02-git-04-tools
1. commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545  
   Получен командой git show aefea  
2. tag: v0.12.23  
3. Четыре родителя:  
   9ea88f22fc6269854151c571162c5bcf958bee2b  
   56cd7859e05c36c06b56d013b55a252d0bb7e158  
   ffbcf55817cb96f6d5ffe1a34abe963b159bf34e  
   58dcac4b798f0a2421170d84e507a42838101648  
   Получено командой git log b8d720
4. b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links  
3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md  
6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable  
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location  
06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md  
d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows  
4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md  
dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md  
225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release  
   Получено командой git log --pretty=oneline v0.12.23...v0.12.24
5. commit 5af1e6234ab6da412fb8637393c5a17a1b293663  
   Найдено с помощью:  
   git grep -n 'func providerSource'  
   git log -S 'func providerSource' --oneline  
   git show 5af1e6234
6. 35a058fb3 main: configure credentials from the CLI config file  
   c0b176109 prevent log output during init  
   8364383c3 Push plugin discovery down into command package  
   Получено с помощью: git log -S 'globalPluginDirs' --oneline
7. Author: Martin Atkins <mart@degeneration.co.uk>  
   Найдено с помощью:  
   git log -S 'synchronizedWriters' --oneline  
   git show 5ac311e2a  
