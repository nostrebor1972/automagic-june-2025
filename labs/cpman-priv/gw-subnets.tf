
resource "azurerm_subnet" "gw_frontend" {
  depends_on = [module.cpman]
  
  name = "frontend"
  virtual_network_name = local.vnet
  resource_group_name = local.rg
  address_prefixes = ["172.17.101.0/24"]
}

resource "azurerm_subnet" "backend" {
  depends_on = [module.cpman]
  
  name = "backend"
  virtual_network_name = local.vnet
  resource_group_name = local.rg
  address_prefixes = ["172.17.102.0/24"]
}