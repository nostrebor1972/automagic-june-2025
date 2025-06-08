variable "admin_password" {
    description = "Admin Password Management"
    type        = string
    default     = "xxxxxxxxxxxx"
}

variable "rg" {
    description = "Resource Group Name"
    type        = string
    default    = "automagic-management-${local.secrets.envId}"
}

variable "name" {
    description = "Name of Security Management VM"
    type        = string
    default     = "cpman"
}

variable "location" {
    description = "Location for the resources"
    type        = string
    default     = "westeurope"
}

variable "vnet_name" {
    description = "Name of the Virtual Network"
    type        = string
    default     = "${var.name}-vnet"
}

variable "vnet_address" {
    description = "Address space for the Virtual Network"
    type        = string
    default     = "10.107.0.0/16"
}

variable "management_subnet" {
    description = "Subnet for the Management VM"
    type        = string
    default     = "10.107.1.0/24"
}