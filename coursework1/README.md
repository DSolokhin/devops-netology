Настроил брандмауэр:

![1](https://user-images.githubusercontent.com/26553608/160374601-8665ccae-3d2c-41fa-8259-2ed51ff32eff.JPG)  

Архив hashicorp vault пришлось качать через vpn:

![2](https://user-images.githubusercontent.com/26553608/160399106-b680c826-2e1f-4a87-b95b-44d51c1773a7.JPG)  

Запускаю сервер в dev режиме в отдельном терминале:  

![3](https://user-images.githubusercontent.com/26553608/160424754-c4f198de-504f-413f-bf15-b40529a325eb.JPG)  

Создал корневой центр сертификации с генерацией сертификата на 30 дней (720 часов)  для домена vault.example.com:  

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
>     country="Russian Federation" \
>     locality="Moscow" \
>     street_address="Red Square 1" \
>     postal_code="101000" \
>     organization="Horns and Hooves LLC" \
>     ou="IT" \
>     ttl="262800h" > pki-root-ca.json
solo@solo:~$ cat pki-root-ca.json | jq -r .data.certificate > rootCA.pem
solo@solo:~$ vault write pki_root_ca/config/urls \
>     issuing_certificates="http://vault.example.com:8200/v1/pki_root_ca/ca" \
>     crl_distribution_points="http://vault.example.com:8200/v1/pki_root_ca/crl"
Success! Data written to: pki_root_ca/config/urls
solo@solo:~$ vault secrets enable \
>     -path=pki_int_ca \
>     -description="PKI Intermediate CA" \
>     -max-lease-ttl="175200h" \
>     pki
Success! Enabled the pki secrets engine at: pki_int_ca/
solo@solo:~$ vault write -format=json pki_int_ca/intermediate/generate/internal \
>    common_name="Intermediate CA" \
>    country="Russian Federation" \
>    locality="Moscow" \
>    street_address="
> Red Square 1
> " \
>    postal_code="101000" \
>    organization="
> Horns and Hooves LLC
> " \
>    ou="IT" \
>    ttl="175200h" | jq -r '.data.csr' > pki_intermediate_ca.csr
solo@solo:~$ vault write -format=json pki_root_ca/root/sign-intermediate csr=@pki_intermediate_ca.csr \
>    country="Russia Federation" \
>    locality="Moscow" \
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
>     issuing_certificates="http://vault.example.com:8200/v1/pki_int_ca/ca" \
>     crl_distribution_points="http://vault.example.com:8200/v1/pki_int_ca/crl"
Success! Data written to: pki_int_ca/config/urls
solo@solo:~$ vault write pki_int_ca/roles/example-dot-com-server \
>     country="Russia Federation" \
>     locality="Moscow" \
>     street_address="
> Red Square 1
> " \
>     postal_code="101000" \
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
solo@solo:~$ vault write pki_int_ca/roles/example-dot-com-client \
>     country="Russia Federation" \
>     locality="Moscow" \
>     street_address="
> Red Square 1
> " \
>     postal_code="101000" \
>     organization="
> Horns and Hooves LLC
> " \
>     ou="IT" \
>     allow_subdomains=true \
>     max_ttl="87600h" \
>     key_bits="2048" \
>     key_type="rsa" \
>     allow_any_name=true \
>     allow_bare_domains=false \
>     allow_glob_domain=false \
>     allow_ip_sans=false \
>     allow_localhost=false \
>     client_flag=true \
>     server_flag=false \
>     enforce_hostnames=false \
>     key_usage="DigitalSignature" \
>     ext_key_usage="ClientAuth" \
>     require_cn=true
Success! Data written to: pki_int_ca/roles/example-dot-com-client
solo@solo:~$ vault write -format=json pki_int_ca/issue/example-dot-com-server \
>     common_name="vault.example.com" \
>     alt_names="vault.example.com" \
>     ttl="720h" > vault.example.com.crt
solo@solo:~$ cat vault.example.com.crt | jq -r .data.certificate > vault.example.com.crt.pem
solo@solo:~$ cat vault.example.com.crt | jq -r .data.issuing_ca >> vault.example.com.crt.pem
solo@solo:~$ cat vault.example.com.crt | jq -r .data.private_key > vault.example.com.crt.key
```












