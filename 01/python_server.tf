terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
}
provider "docker" {
 /*   host     = "ssh://g-l-s@51.250.90.161:22"
    ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"] */
}

resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "MYSQL_ROOT_RASSWORD" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "MYSQL_RASSWORD" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "docker_image" "mysql_8" {
  name = "mysql:8"
}

resource "docker_container" "mysql" {
  image = docker_image.mysql_8.image_id
  name = "mysql8"
  env = ["MYSQL_ROOT_PASSWORD=${random_password.MYSQL_ROOT_RASSWORD.result}", "MYSQL_DATABASE=wordpress", "MYSQL_USER=wordpress", "MYSQL_PASSWORD=${random_password.MYSQL_RASSWORD.result}", "MYSQL_ROOT_HOST=%"]

  ports {
    internal = 3306
    external = 3306
  }
}