##Этот файл для 7 задания!!
locals {

  test_list = ["develop", "staging", "production"]

  test_map = {
    admin = "John"
    user  = "Alex"
  }
my_key = keys(local.test_map)

  servers = {
    develop = {
      cpu   = 2
      ram   = 4
      image = "ubuntu-21-10"
      disks = ["vda", "vdb"]
    },
    stage = {
      cpu   = 4
      ram   = 8
      image = "ubuntu-20-04"
      disks = ["vda", "vdb"]
    },
    production = {
      cpu   = 10
      ram   = 40
      image = "ubuntu-20-04"
      disks = ["vda", "vdb", "vdc", "vdd"]
    }
  }

value = "${local.test_map.admin} is ${local.my_key[0]} for ${local.test_list[2]} server based on OS ${local.servers.production.image} with ${local.servers.production.cpu} vcpu, ${local.servers.production.ram} ram, and ${length(local.servers.production.disks)} virtual disks"
  
}
