data "yandex_compute_disk" "second_disk" {
    count = 3
    name = "disk_${count.index+1}"
}

resource "yandex_compute_instance" "storage" {
    depends_on = [ yandex_compute_instance.web ]
    for_each = data.yandex_compute_disk.second_disk
    name = "storage"
    platform_id = var.vm_platform_id
    allow_stopping_for_update = var.allow_stopping_for_update

    resources {
        cores = var.hardware_web.web.cores
        memory = var.hardware_web.web.memory
        core_fraction = var.hardware_web.web.core_fraction
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.image_id
            
        }
    }

    secondary_disk {
      disk_id = each.key
    }

    scheduling_policy {
    preemptible = var.vm_preemptible
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat = var.vm_web_nat
        security_group_ids = [yandex_vpc_security_group.example.id]
    }

    metadata = {
        ssh-keys           = "ubuntu:${local.ssh_key}"
    }
}