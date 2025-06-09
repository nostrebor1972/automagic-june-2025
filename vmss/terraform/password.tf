// random admin password
resource "random_password" "admin_password" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric  = true
  override_special = "!@#$%^&*()_+"
  keepers = {
    envId = local.secrets.envId
  }
}

// random sic_key 
resource "random_password" "sic_key" {
  length  = 18
  special = false
  upper   = true
  lower   = true
  numeric  = true
  # override_special = "!@#$%^&*()_+"
  keepers = {
    envId = local.secrets.envId
  }
}

