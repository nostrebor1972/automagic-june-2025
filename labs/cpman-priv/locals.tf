locals {
    vnet = var.vnet_name != null ? var.vnet_name : "cpman-priv-${local.secrets.envId}"
    rg = "cpman-priv-${local.secrets.envId}"
}