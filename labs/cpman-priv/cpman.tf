


module "cpman" {

    source  = "CheckPointSW/cloudguard-network-security/azure//modules/management_new_vnet"
    version = "1.0.4"


    source_image_vhd_uri            = "noCustomUri"
    resource_group_name             = local.rg
    mgmt_name                       = var.name
    location                        = var.location
    vnet_name                       = local.vnet
    address_space                   = var.vnet_address
    subnet_prefix                   = var.management_subnet
    management_GUI_client_network   = "0.0.0.0/0"
    mgmt_enable_api                 = "all"
    admin_password                  = var.admin_password 
    vm_size                         = "Standard_D3_v2"
    disk_size                       = "110"
    vm_os_sku                       = "mgmt-byol"
    vm_os_offer                     = "check-point-cg-r8120"
    os_version                      = "R8120"
    bootstrap_script                = "touch /home/admin/bootstrap.txt; echo 'hello_world' > /home/admin/bootstrap.txt"
    allow_upload_download           = true
    authentication_type             = "Password"
    admin_shell                     = "/bin/bash"
    serial_console_password_hash    = ""
    maintenance_mode_password_hash  = ""
    nsg_id                          = ""
    add_storage_account_ip_rules    = false
    storage_account_additional_ips  = []
}