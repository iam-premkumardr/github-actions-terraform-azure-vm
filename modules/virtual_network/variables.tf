variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network (e.g., ['10.0.0.0/16'])."
  type        = list(string)
}

variable "location" {
  description = "Location of the virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the virtual network."
  type        = string
}
