output "password" {
  value     = var.admin_password != null ? var.admin_password : random_password.admin_password.result
  sensitive = true
}

output "sic_key" {
  value     = var.sic_key #random_password.sic_key.result
  sensitive = true
}