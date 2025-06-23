resource "checkpoint_management_network" "vnet_all" {
  name         = "net_vnet_all"
  subnet4      = "10.0.0.0"
  mask_length4 = 8
}

resource "checkpoint_management_network" "net-linux" {
  broadcast    = "allow"
  color        = "red"
  mask_length4 = 24
  name         = "net-linux"
  nat_settings = {
    "auto_rule"   = "true"
    "hide_behind" = "gateway"
    "install_on"  = "All"
    "method"      = "hide"
  }
  subnet4 = "10.114.1.0"
  tags    = []
}