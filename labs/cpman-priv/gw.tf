

module "gw" {

        depends_on = [module.cpman, azurerm_subnet.gw_frontend, azurerm_subnet.backend]

        source  = "CheckPointSW/cloudguard-network-security/azure//modules/single_gateway_existing_vnet"
        version = "1.0.4"

        source_image_vhd_uri            = "noCustomUri"
        resource_group_name             = "cpman-priv-gw-${local.secrets.envId}"
        single_gateway_name             = "gw"
        location                        =  var.location
        vnet_name                       =  local.vnet
        vnet_resource_group             =  local.rg
        subnet_frontend_name            = azurerm_subnet.gw_frontend.name
        subnet_backend_name             =  azurerm_subnet.backend.name
        subnet_frontend_1st_Address     = "172.17.101.4"
        subnet_backend_1st_Address      = "172.17.102.4"
        management_GUI_client_network   = "0.0.0.0/0"
        admin_password                  = var.admin_password
        smart_1_cloud_token             = ""
        sic_key                         = "welcomehome1984"
        vm_size                         = "Standard_D3_v2"
        disk_size                       = "110"
        vm_os_sku                       = "sg-byol"
        vm_os_offer                     = "check-point-cg-r8120"
        os_version                      = "R8120"
        bootstrap_script                = "touch /home/admin/bootstrap.txt; echo 'hello_world' > /home/admin/bootstrap.txt"
        allow_upload_download           = true
        authentication_type             = "Password"
        enable_custom_metrics           = true
        admin_shell                     = "/bin/bash"
        installation_type               = "gateway"
        serial_console_password_hash    = ""
        maintenance_mode_password_hash  = ""
        nsg_id                          = ""      
        add_storage_account_ip_rules    = false
        storage_account_additional_ips  = []
}