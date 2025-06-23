
data "http" "codespace" {
  url = "https://ifconfig.me/ip"
}

output "codespace_ip" {
  value = data.http.codespace.response_body
}

resource "checkpoint_management_host" "codespace" {
  name         = "codespace"
  ipv4_address = data.http.codespace.response_body
  color        = "blue"
  comments     = "Codespace host"
}