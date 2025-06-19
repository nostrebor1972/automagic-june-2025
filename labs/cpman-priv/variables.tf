variable "name" {
  description = "Name of Management VM"
  type        = string
  default     = "cpman-priv"
}

variable "location" {
  description = "Location for the Management VM"
  type        = string
  default     = "westeurope"
}

variable "vnet_name" {
  description = "Name of the VNet for the Management VM"
  type        = string
  default     = null
}

variable "vnet_address" {
  description = "Address space for the VNet"
  type        = string
  default     = "172.17.0.0/16"
}

variable "management_subnet" {
  description = "Subnet prefix for the Management VM"
  type        = string
  default     = "172.17.1.0/24"
}

variable "admin_password" {
  description = "Admin password for the Management VM"
  type        = string
  sensitive   = true
  default     = "Welcome@Home#1984"
}