###cloud vars

variable "zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cidr_b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name_b" {
  type        = string
  default     = "develop_b"
  description = "VPC network & subnet name"
}

variable "vm_db_cpu_count" {
  type        = number
  default     = 2
  description = "Count of CPUs"
}

variable "vm_db_ram_count" {
  type        = number
  default     = 2
  description = "Value of RAM"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "core_fraction"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Type of platform to use"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Could it be stopped or not"
}

variable "vm_db_os_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "A name of the OS"
}

variable "vm_db_vm_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "A name of the VM"
}

variable "vm_db_nat" {
  type        = bool
  default     = true
  description = "Should we have nat or not"
}

variable "vm_db_serial-port-enable" {
  type        = string
  default     = "1"
  description = "Should we enable serial port"
}

