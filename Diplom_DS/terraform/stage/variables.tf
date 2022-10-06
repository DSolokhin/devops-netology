# Указать свой домен

variable "domain_name" {
  default = "dsolokhin.ru"
}

##Настройки Yandex cloud##

# Указать ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = "b1g2tnfvt8jqdekno3l1"
}

# Указать Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = "b1gem3u5mv0e4k9vjcif"
}

# Путь до service_account_key_file
variable "yandex_key" {
  default = "../secrets/key.json"
}

# Наименование хостов
variable "host_name" {
  default = [ "nginx", "db01", "db02", "www", "gitlab", "g-runner", "monitoring" ]
}

##Настройки конфигурации базы данных##

# Указать пароль для репликации MySQL
variable "replication_passwd" {
  default = "replication"
}


##Настройки для мониторинга##


# Указать пароль к Grafana (для админской учетной записи)
variable "grafana_passwd" {
  default = "grafana"
}

##Настройки GitLab##

# Указать пароль к Gitlab (для корневой админской учетной записи)
variable "gitlab_passwd" {
  default = "gitlab!!!"
}

# Указать токен Gitlab c runner
variable "gitlab_runner" {
  default = "gitlabtoken"
}
