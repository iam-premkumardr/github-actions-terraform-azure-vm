variable "public_ip_count" {
  description = "Number of Public IPs to create"
  type        = number
  default     = 1
}

variable "public_ip_name" {
  description = "Name of the public IP address to be created."
  type        = string
}

variable "location" {
  description = "Location of the public IP."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the public IP."
  type        = string
}

variable "allocation_method" {
  description = "Allocation method for the public IP (Dynamic or Static)."
  type        = string
  default     = "Dynamic"
}

variable "sku" {
  description = "SKU for the Public IP (Basic or Standard)."
  type        = string
  default     = "Basic"
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
