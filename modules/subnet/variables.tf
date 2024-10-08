variable "subnet_name" {
  description = "Name of the subnet to be created."
  type        = string
}

variable "address_prefix" {
  description = "Address prefix for the subnet (e.g., '10.0.1.0/24')."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"] # Update with your own prefixes
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the subnet."
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network in which to create the subnet."
  type        = string
}
