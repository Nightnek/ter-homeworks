###cloud vars

variable "organisation" {
  type        = string
  default = "netology"
  description = "organisation"
}

variable "stage_dev" {
  type        = string
  default = "develop"
  description = "Stage fore developement"
}

variable "progect" {
  type        = string
  default = "platform"
  description = "Project name"
}

variable "vm_type" {
  type        = list(string)
  default = [ "web", "db" ]
  description = "Project name"
}

variable "cloud_id" {
  type        = string
  default = "b1gua5vm4htrvegtvhce"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default = "b1gpf79u52rvts6oo1mn"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vms_resources" {
  type = map(object({
    cores = number
    memory = number
    core_fraction = number
    hdd_size = number
    hdd_type = string
  }))
  default = {
    web={
    cores=2
    memory=1
    core_fraction=20
    hdd_size=5
    hdd_type="network-hdd"
  },
  db= {
    cores=2
    memory=2
    core_fraction=20
    hdd_size=5
    hdd_type="network-hdd"
  }
}
}

# variable "vm_web_cpu_count" {
#   type        = number
#   default     = 2
#   description = "Count of CPUs"
# }

# variable "vm_web_ram_count" {
#   type        = number
#   default     = 1
#   description = "Value of RAM"
# }

# variable "vm_web_core_fraction" {
#   type        = number
#   default     = 20
#   description = "core_fraction"
# }

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Type of platform to use"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Could it be stopped or not"
}

variable "vm_web_os_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "A name of the OS"
}

variable "vm_web_vm_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "A name of the VM"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "Should we have nat or not"
}

# variable "vm_web_serial-port-enable" {
#   type        = string
#   default     = "1"
#   description = "Should we enable serial port"
# }

###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMDBucc4dn0yIez/OhPBwwh24sSul30kOPBHt1jKrbcQb5/+PGBuZWOVzsmPYb23SPuxHNt8XbxNOlOf7SU5QdF4y4btKZJncC0G73WUUx+12ZKVsGu69E7grEYvfS4RTpB7nZj6OyTHTN3KvBVBChVtZnNsx7R9wTQQjTl81EzBGqKyaI7lVAs+CwkBr1K1aWigi+0Ys/1FsJdamkdvsbRaJQtpT4QkNoXU/TuS9qJDHtlxMSNb8GFJSHzHKTjBRdGKPS0KhVOZbm1tNqV0DDxkD5PG53MywrjYLBWA7wlz/VEwZ6R1wW/6QwZbl50b9qAR6ZSvV83DUj4v+2rSyz/D3K6jlXUTsLcfAygMyqyp34vsshY3iMQDIYwj7cZp3Jk1h8V0d2WWMUG5BLDFcaYUK+wnlbFxrf7rkVYbZoYcUMj7Pex0nAckpziS7jJKbPctROBb7BBX7ptKoIggYFpqy/3xnKXeQEmcTRY2MW1I/n0FUwPLekeaCH3P808oU= g-l-s@Nightnek_laptop"
#   description = "ssh-keygen -t ed25519"
# }

variable "ssh_key" {
  type = map(object({
    serial-port-enable = string
    ssh-keys = string
  }))
  default = {
    metadata = {
      serial-port-enable = "1"
      ssh-keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMDBucc4dn0yIez/OhPBwwh24sSul30kOPBHt1jKrbcQb5/+PGBuZWOVzsmPYb23SPuxHNt8XbxNOlOf7SU5QdF4y4btKZJncC0G73WUUx+12ZKVsGu69E7grEYvfS4RTpB7nZj6OyTHTN3KvBVBChVtZnNsx7R9wTQQjTl81EzBGqKyaI7lVAs+CwkBr1K1aWigi+0Ys/1FsJdamkdvsbRaJQtpT4QkNoXU/TuS9qJDHtlxMSNb8GFJSHzHKTjBRdGKPS0KhVOZbm1tNqV0DDxkD5PG53MywrjYLBWA7wlz/VEwZ6R1wW/6QwZbl50b9qAR6ZSvV83DUj4v+2rSyz/D3K6jlXUTsLcfAygMyqyp34vsshY3iMQDIYwj7cZp3Jk1h8V0d2WWMUG5BLDFcaYUK+wnlbFxrf7rkVYbZoYcUMj7Pex0nAckpziS7jJKbPctROBb7BBX7ptKoIggYFpqy/3xnKXeQEmcTRY2MW1I/n0FUwPLekeaCH3P808oU= g-l-s@Nightnek_laptop"
    }
  }
}

variable "test" {
  type = map(set(string))
  test = {
    web = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@${yandex_compute_instance.platform.network_interface[0].nat_ip_address}",
      "${yandex_compute_instance.platform.network_interface[0].ip_address}",
    ]

    db = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@${yandex_compute_instance.netology-develop-platform-db.network_interface[0].nat_ip_address}",
      "${yandex_compute_instance.netology-develop-platform-db.network_interface[0].ip_address}",
    ]
  }
}