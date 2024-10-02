terraform {
  required_providers {
    yandex = {
        source = "yandex-cloud/yandex"
    }
  }
}

variable "yandex_cloud_token" {
  type = string
  description = "Введите токен"
}

provider "yandex" {
  token = var.yandex_cloud_token
  cloud_id = "b1gua5vm4htrvegtvhce"
  folder_id = "b1gpf79u52rvts6oo1mn"
}

resource "yandex_vpc_network" "network" {}

resource "yandex_vpc_subnet" "subnet_a" {
    zone = "ru-central1-a"
    network_id = "${yandex_vpc_network.network.id}"  
    v4_cidr_blocks = ["10.10.10.0/24"]
}

resource "yandex_compute_instance" "server" {
    name = "server"
  platform_id = "standard-v1"
  zone = "ru-central1-a"
  allow_stopping_for_update = true

  resources {
    cores = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
        image_id = "fd8tvc3529h2cpjvpkr5"
    }
  }

  metadata = {
    user-data = "#cloud-config\n  ssh_pwauth: no\nusers:\n  - name: g-l-s\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("C:\\Users\\g-l-s\\.ssh\\id_rsa.pub")}"
    ssh-keys = "g-l-s:${file("C:\\Users\\g-l-s\\.ssh\\id_rsa.pub")}"
  }

  network_interface {
    index = 1
    subnet_id = "${yandex_vpc_subnet.subnet_a.id}"
    nat = true
    nat_ip_address = yandex_vpc_address.external_address.external_ipv4_address[0].address
  }  
}

resource "yandex_vpc_address" "external_address" {
  name = "external-IP"
  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}

output "server_ip_address" {
  value = yandex_vpc_address.external_address.external_ipv4_address[0].address
}