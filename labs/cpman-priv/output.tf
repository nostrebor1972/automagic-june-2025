output "rg" {
  value = "cpman-priv-${local.secrets.envId}"
}

output "name" {
  value = var.name
}

output "password" {
  value     = var.admin_password
  sensitive = true
}

output "gw_name" {
  value = local.gw_name
}
output "gw_rg" {
  value = local.gw_rg
}