resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",

  { webservers = yandex_compute_instance.web })

  filename = "${abspath(path.module)}/hosts.ini"
}

resource "local_file" "hosts_for" {
  content =  <<-EOT
  %{if length(yandex_compute_instance.web) > 0}
  [webservers]
  %{for i in yandex_compute_instance.web }
  ${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]}   fqdn=${i["fqdn"]}
  %{endfor}
  %{endif}
  %{if length(yandex_compute_instance.db) > 0}
  [databases]
  %{for i in yandex_compute_instance.db }
  ${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]}   fqdn=${i["fqdn"]}
  %{endfor}
  %{endif}
  %{if length(yandex_compute_instance.storage) > 0}
  [storage]
  %{for j in yandex_compute_instance.storage }
  ${j["name"]}   ansible_host=${j["network_interface"][0]["nat_ip_address"]}   fqdn=${j["fqdn"]}
  %{endfor}
  %{endif}
  EOT
  filename = "${abspath(path.module)}/for.ini"
}