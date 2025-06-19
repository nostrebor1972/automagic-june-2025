locals {
  vnet    = var.vnet_name != null ? var.vnet_name : "cpman-priv-${local.secrets.envId}"
  rg      = "cpman-priv-${local.secrets.envId}"
  gw_rg   = "cpman-priv-gw-${local.secrets.envId}"
  gw_name = "gw"
}