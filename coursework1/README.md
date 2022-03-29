1. Создал виртуальную машину Ubuntu:  

![1_0](https://user-images.githubusercontent.com/26553608/160563349-06eb7634-6a9e-4d58-af2e-61b4c48a3f4f.JPG)


2. Настроил брандмауэр (ufw у меня уже был предустановлен):

![1](https://user-images.githubusercontent.com/26553608/160374601-8665ccae-3d2c-41fa-8259-2ed51ff32eff.JPG)  

3. Архив hashicorp vault пришлось качать через vpn:

![2](https://user-images.githubusercontent.com/26553608/160399106-b680c826-2e1f-4a87-b95b-44d51c1773a7.JPG)  

Запускаю сервер в dev режиме в отдельном терминале:  

![3](https://user-images.githubusercontent.com/26553608/160424754-c4f198de-504f-413f-bf15-b40529a325eb.JPG)  

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

7. 














