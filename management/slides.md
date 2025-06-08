---
layout: cover
---
# `make managent` 
# using Terraform module
---
---
# `make management` using Terraform module

* sss

---
layout: two-cols-header
---
# Clickops approach from Azure Marketplace
::left::
![alt text](./img/az-marketplace.png)
::right::
![alt text](./img/az-marketplace-form.png)
---
---
# DevOps approach - declarative in code

```hcl
module "example_module" {

    source  = "CheckPointSW/cloudguard-network-security/azure//modules/management_new_vnet"
    version = "1.0.4"


    source_image_vhd_uri            = "noCustomUri"
    resource_group_name             = "checkpoint-mgmt-terraform"
    mgmt_name                       = "checkpoint-mgmt-terraform"
    location                        = "eastus"
    vnet_name                       = "checkpoint-mgmt-vnet"
    address_space                   = "10.0.0.0/16"
    subnet_prefix                   = "10.0.0.0/24"
    management_GUI_client_network   = "0.0.0.0/0"
    mgmt_enable_api                 = "disable"
    admin_password                  = "xxxxxxxxxxxx"
    vm_size                         = "Standard_D3_v2"
    disk_size                       = "110"
    vm_os_sku                       = "mgmt-byol"
    vm_os_offer                     = "check-point-cg-r8110"
    os_version                      = "R8110"
    bootstrap_script                = "touch /home/admin/bootstrap.txt; echo 'hello_world' > /home/admin/bootstrap.txt"
    allow_upload_download           = true
    authentication_type             = "Password"
    admin_shell                     = "/etc/cli.sh"
    serial_console_password_hash    = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    maintenance_mode_password_hash  = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    nsg_id                          = ""
    add_storage_account_ip_rules    = false
    storage_account_additional_ips  = []
}
```