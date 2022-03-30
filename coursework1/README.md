1. Создал виртуальную машину Ubuntu:  

![1_0](https://user-images.githubusercontent.com/26553608/160563349-06eb7634-6a9e-4d58-af2e-61b4c48a3f4f.JPG)


2. Настроил брандмауэр (ufw у меня уже был предустановлен):

![1](https://user-images.githubusercontent.com/26553608/160374601-8665ccae-3d2c-41fa-8259-2ed51ff32eff.JPG)  

3. Архив hashicorp vault пришлось качать через vpn:

![2](https://user-images.githubusercontent.com/26553608/160399106-b680c826-2e1f-4a87-b95b-44d51c1773a7.JPG)  

Запускаю сервер:    
![vault_run](https://user-images.githubusercontent.com/26553608/160794593-22d758ac-a42d-4dc9-afa6-fe744e7f154e.JPG)

 

4. Создал центр сертификации, настройка PKI, корневой сертификат, промежуточный, роль для серверов, генерация сертификата на 30 дней (720 часов)  для домена vault.example.com (jq уже установлена):  

```
solo@solo:~$ export VAULT_ADDR=http://127.0.0.1:8200
solo@solo:~$ export PATH=$PATH:/home/solo
solo@solo:~$ vault secrets enable \
>     -path=pki_root_ca \
>     -description="PKI Root CA" \
>     -max-lease-ttl="262800h" \
>     pki
Success! Enabled the pki secrets engine at: pki_root_ca/
solo@solo:~$ vault write -format=json pki_root_ca/root/generate/internal \
>     common_name="Root Certificate Authority" \
>     country="RF" \
>     locality="Ramenskoe" \
>     street_address="Red Square 1" \
>     postal_code="140126" \
>     organization="Horns and Hooves LLC" \
>     ou="IT" \
>     ttl="262800h" > pki-root-ca.json
solo@solo:~$ cat pki-root-ca.json | jq -r .data.certificate > rootCA.pem
solo@solo:~$ vault write pki_root_ca/config/urls \
>     issuing_certificates="http://localhost:8200/v1/pki_root_ca/ca" \
>     crl_distribution_points="http://localhost:8200/v1/pki_root_ca/crl"
Success! Data written to: pki_root_ca/config/urls
solo@solo:~$ vault secrets enable \
>     -path=pki_int_ca \
>     -description="PKI Intermediate CA" \
>     -max-lease-ttl="175200h" \
>     pki
Success! Enabled the pki secrets engine at: pki_int_ca/
solo@solo:~$ vault write -format=json pki_int_ca/intermediate/generate/internal \
>    common_name="Intermediate CA" \
>    country="RF" \
>    locality="Ramenskoe" \
>    street_address="
> Red Square 1
> " \
>    postal_code="140126" \
>    organization="
> Horns and Hooves LLC
> " \
>    ou="IT" \
>    ttl="175200h" | jq -r '.data.csr' > pki_intermediate_ca.csr
solo@solo:~$ vault write -format=json pki_root_ca/root/sign-intermediate csr=@pki_intermediate_ca.csr \
>    country="RF" \
>    locality="Ramenskoe" \
>    street_address="
> Red Square 1
> " \
>    postal_code="101000" \
>    organization="
> Horns and Hooves LLC
> " \
>    ou="IT" \
>    format=pem_bundle \
>    ttl="175200h" | jq -r '.data.certificate' > intermediateCA.cert.pem
solo@solo:~$ vault write pki_int_ca/intermediate/set-signed \
>     certificate=@intermediateCA.cert.pem
Success! Data written to: pki_int_ca/intermediate/set-signed
solo@solo:~$ vault write pki_int_ca/config/urls \
>     issuing_certificates="http://localhost:8200/v1/pki_int_ca/ca" \
>     crl_distribution_points="http://localhost:8200/v1/pki_int_ca/crl"
Success! Data written to: pki_int_ca/config/urls
solo@solo:~$ vault write pki_int_ca/roles/example-dot-com-server \
>     country="RF" \
>     locality="Ramenskoe" \
>     street_address="
> Red Square 1
> " \
>     postal_code="140126" \
>     organization="
> Horns and Hooves LLC
> " \
>     ou="IT" \
>     allowed_domains="example.com" \
>     allow_subdomains=true \
>     max_ttl="87600h" \
>     key_bits="2048" \
>     key_type="rsa" \
>     allow_any_name=false \
>     allow_bare_domains=false \
>     allow_glob_domain=false \
>     allow_ip_sans=true \
>     allow_localhost=false \
>     client_flag=false \
>     server_flag=true \
>     enforce_hostnames=true \
>     key_usage="DigitalSignature,KeyEncipherment" \
>     ext_key_usage="ServerAuth" \
>     require_cn=true
Success! Data written to: pki_int_ca/roles/example-dot-com-server
solo@solo:~$ vault write -format=json pki_int_ca/issue/example-dot-com-server \
>     common_name="vault.example.com" \
>     alt_names="vault.example.com" \
>     ttl="720h" > vault.example.com.crt
solo@solo:~$ cat vault.example.com.crt | jq -r .data.certificate > vault.example.com.crt.pem
solo@solo:~$ cat vault.example.com.crt | jq -r .data.issuing_ca >> vault.example.com.crt.pem
solo@solo:~$ cat vault.example.com.crt | jq -r .data.private_key > vault.example.com.crt.key
```

5. Сохраняю корневой сертификат по опубликованной ранее ссылке:  
```
solo@solo:~$ curl -O localhost:8200/v1/pki_root_ca/ca
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1095  100  1095    0     0  60833      0 --:--:-- --:--:-- --:--:-- 60833
```

Добавляю корневой в доверенные центры на хосте:  

![5](https://user-images.githubusercontent.com/26553608/160559794-93451435-1826-408b-81ab-d56df3105700.JPG)  

6. Установил nginx:  

![6](https://user-images.githubusercontent.com/26553608/160567806-9215e644-a9a3-4cfe-875c-1e7585b96dc9.JPG)  

7. Настраиваю https на примере созданного виртуального хоста vault.example.com в nginx:  

```
$ sudo mkdir -p /var/www/vault.example.com/html
$ sudo chown -R $USER:$USER /var/www/vault.example.com/html
$ sudo chmod -R 755 /var/www/vault.example.com
$ sudo nano /var/www/vault.example.com/html/index.html
$ sudo nano /etc/nginx/sites-available/vault.example.com
```
Сам конфиг:  

![7_1](https://user-images.githubusercontent.com/26553608/160606753-aa4640c7-c392-46d6-94ef-fbe25762f312.JPG)  

Делаю ссылку на на новый домен:  
```
$ sudo ln -s /etc/nginx/sites-available/vault.example.com /etc/nginx/sites-enabled/

```
В nginx.conf раскомментировал server_names_hash_bucket_size  
```
$ sudo nginx -t
$ sudo systemctl restart nginx
```
8. Открываем домен в брузере на хостовой машине:  

![8](https://user-images.githubusercontent.com/26553608/160633481-677cb259-5ac1-424b-a29e-e8401037e00e.JPG)  

9. Скрипт для генерации сертификата на 30 дней, токен можно спрятать в переменную:  
 ![script](https://user-images.githubusercontent.com/26553608/160853091-c69f68d8-e498-47cf-8775-2679afdaa5fa.JPG)

  
![gen](https://user-images.githubusercontent.com/26553608/160825285-8559ec88-678b-4081-975f-ab304a8b5720.JPG)
![host](https://user-images.githubusercontent.com/26553608/160825310-e825fd40-7b34-4e1c-873c-07a71d2b6537.JPG)



10. Для проверки скрипта добавил в крон выполнение каждую минуту:  
![cron](https://user-images.githubusercontent.com/26553608/160832454-1121b863-6f1f-4b50-9507-2792d982158d.JPG)














