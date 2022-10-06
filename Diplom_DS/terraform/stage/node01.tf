resource "yandex_compute_instance" "node01" {
  name                      = "nginx-node01"
  platform_id               = "standard-v1"
  zone                      = "ru-central1-a"
  hostname                  = "${var.host_name.0}"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "fd84mnpg35f7s7b0f5lg"
      name        = "root-node01"
      type        = "network-ssd"
      size        = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.public-a.id}"
    nat       = true
    ip_address = "192.168.100.11"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }


  }

