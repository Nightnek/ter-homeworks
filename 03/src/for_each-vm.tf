resource "yandex_compute_instance" "web1" {
    depends_on = [ yandex_compute_instance.web ]
    for_each = {
        for key, value in var.each_vm:
        key => value
    }
    name = "${each.value.vm_name}"
    platform_id = var.vm_platform_id
    allow_stopping_for_update = var.allow_stopping_for_update

    resources {
        cores = each.value.cpu
        memory = each.value.ram
        core_fraction = var.hardware_web.web.core_fraction
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.image_id
            size = each.value.disk_volume
        }
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