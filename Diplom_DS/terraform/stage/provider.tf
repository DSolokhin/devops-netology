terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

    backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "my-tf-diplom-ds"
    key        = "state/terraform.tfstate"
    access_key = "YCAJEvAfzaLJB7EHIDoLA834v"
    secret_key = "YCMwAkVLDf-FOJtvsDmkXbwyvbiUTRlZYU6lP0iG"
    region     = "ru-central1-a"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  service_account_key_file = "${var.yandex_key}"
  cloud_id                 = "${var.yandex_cloud_id}"
  folder_id                = "${var.yandex_folder_id}"
}

