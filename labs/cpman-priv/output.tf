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