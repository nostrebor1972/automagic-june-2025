# permissinve NSG for testing
resource "azurerm_network_security_group" "gw_nsg" {
  name                = "gw-nsg"
  location            = var.location
  resource_group_name = local.gw_rg
  security_rule {
    name                       = "AllowAllInbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowAllOutbound"
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# associate NSG with the gateway subnets    
resource "azurerm_subnet_network_security_group_association" "gw_frontend" {
  subnet_id                 = azurerm_subnet.gw_frontend.id
  network_security_group_id = azurerm_network_security_group.gw_nsg.id
}
resource "azurerm_subnet_network_security_group_association" "gw_backend" {
  subnet_id                 = azurerm_subnet.backend.id
  network_security_group_id = azurerm_network_security_group.gw_nsg.id
}