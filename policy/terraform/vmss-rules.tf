resource "checkpoint_management_access_section" "vmss_outbound" {
  name = "VMSS Outbound"
  position = {top = "top"}
  layer = "${checkpoint_management_package.vmss.name} Network"
}

resource "checkpoint_management_access_rule" "any_internet" {
  name = "Allow Internet Access"
  layer = "${checkpoint_management_package.vmss.name} Network"
  position = {below = checkpoint_management_access_section.vmss_outbound.id}
  source = [checkpoint_management_network.vnet_all.name]
  destination = ["Any"]
  service = ["Any"]
  content = ["Any"]
  time = ["Any"]
  install_on = ["Policy Targets"]
  track = {
    type = "Log"
    accounting = false
    alert = "none"
    enable_firewall_session = false
    per_connection = true
    per_session = false
  }
  action_settings = {}
  custom_fields = {}
  vpn = "Any"
  action = "Accept"
}

resource "checkpoint_management_access_section" "vmss_inbound" {
  name = "VMSS Inbound"
  position = {top = "top"}
  layer = "${checkpoint_management_package.vmss.name} Network"
}

resource "checkpoint_management_access_rule" "codespace" {
  name = "Management from Codespace host"
  layer = "${checkpoint_management_package.vmss.name} Network"
  position = {below = checkpoint_management_access_section.vmss_inbound.id}
  source = [checkpoint_management_host.codespace.name]
  destination = ["Any"]
  service = ["https", "ssh"]
  content = ["Any"]
  time = ["Any"]
  install_on = ["Policy Targets"]
  track = {
    type = "Log"
    accounting = false
    alert = "none"
    enable_firewall_session = false
    per_connection = true
    per_session = false
  }
  action_settings = {}
  custom_fields = {}
  vpn = "Any"
  action = "Accept"
}
