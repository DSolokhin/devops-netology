resource "yandex_compute_instance" "node02" {
  name                      = "db01-node02"
  platform_id               = "standard-v1"
  zone                      = "ru-central1-b"
  hostname                  = "${var.host_name.1}"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8qps171vp141hl7g9l"
      name        = "root-node02"
      type        = "network-ssd"
      size        = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.lan-b.id}"

    ip_address = "192.168.110.12"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
