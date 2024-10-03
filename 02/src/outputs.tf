output "result" {
  value = [
    { platform = [yandex_compute_instance.platform.network_interface[0].nat_ip_address, yandex_compute_instance.platform.fqdn] },
    { netology-develop-platform-db = [yandex_compute_instance.netology-develop-platform-db.network_interface[0].nat_ip_address, yandex_compute_instance.netology-develop-platform-db.fqdn] }
  ]
}