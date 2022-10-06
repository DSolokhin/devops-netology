# Network
resource "yandex_vpc_network" "diploma-vpc-network" {
  name = "diplomavpc"
}

#Public zone
resource "yandex_vpc_subnet" "public-a" {
  name = "publicsubneta"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.diploma-vpc-network.id
  v4_cidr_blocks = ["192.168.100.0/24"]
}


# Routing
resource "yandex_vpc_route_table" "diploma-nat" {
  network_id = yandex_vpc_network.diploma-vpc-network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.100.11"
  }
}

# Lan zone
resource "yandex_vpc_subnet" "lan-b" {
  name = "lansubnetb"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diploma-vpc-network.id
  route_table_id = yandex_vpc_route_table.diploma-nat.id
  v4_cidr_blocks = ["192.168.110.0/24"]
}
