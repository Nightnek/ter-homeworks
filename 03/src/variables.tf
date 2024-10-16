###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
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

variable "allow_stopping_for_update" {
  type = bool
  default = true
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_name" {
  type = string
  default = "web-"
  description = "template for web-machines names"
}

variable "vm_os" {
  type = string
  default = "ubuntu-2204-lts"
  description = "OS version"
}

variable "hardware_web" {
  type = map(object({
    cores = number
    memory = number
    core_fraction = number
    hdd_size = number
  }))
  default = {
    "web" = {
      cores = 2
      memory = 1
      core_fraction = 20
      hdd_size = 5
    }
  }
}

variable "hardware_db" {
  type = map(object({
    cores = number
    memory = number
    core_fraction = number
    hdd_size = number
  }))
  default = {
    "main" = {
      cores = 2
      memory = 2
      core_fraction = 20
      hdd_size = 6
    }
    "replica" = {
      cores = 2
      memory = 3
      core_fraction = 20
      hdd_size = 7
    }
  }
}

variable "vm_platform_id" {
  type = string
  default = "standard-v3"  
}

variable "vm_preemptible" {
  type        = bool
  default     = true
  description = "Could it be stopped or not"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "nat or not"
}

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
  default = [
  {
      cpu = 2
      disk_volume = 10
      ram = 2
      vm_name = "main"
  },
  {
      cpu = 4
      disk_volume = 20
      ram = 4
      vm_name = "replica"
  }]
}

locals {
  ssh_key = file("~/.ssh/id_rsa.pub")
}