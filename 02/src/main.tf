resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = var.vpc_name_b
  zone           = var.zone_b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.cidr_b
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_db_os_family
}
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web
  platform_id = var.vm_web_platform_id
  allow_stopping_for_update = true
  resources {
    cores = var.vms_resources.web.cores
    memory = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
    
    
    /* cores         = var.vm_web_cpu_count
    memory        = var.vm_web_ram_count
    core_fraction = var.vm_web_core_fraction */
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
  }

  metadata = {
    serial-port-enable = var.ssh_key.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.ssh_key.metadata.ssh-keys}"
  }

}

resource "yandex_compute_instance" "netology-develop-platform-db" {
  name        = local.vm_db
  platform_id = var.vm_db_platform_id
  zone = var.zone_b
  allow_stopping_for_update = true
  resources {
    cores = var.vms_resources.db.cores
    memory = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction


  /*  cores         = var.vm_db_cpu_count
    memory        = var.vm_db_ram_count
    core_fraction = var.vm_db_core_fraction */

  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = var.vm_db_nat
  }

  metadata = {
    serial-port-enable = var.ssh_key.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.ssh_key.metadata.ssh-keys}"
  }

}

output "out" {
   value = local.test
}