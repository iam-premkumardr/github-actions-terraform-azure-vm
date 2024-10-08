variable "nic_name" {
  description = "Base name of the network interface to be created. Suffix will be added for multiple NICs."
  type        = string
}

variable "nic_count" {  
  description = "Number of network interfaces to create."
  type        = number
  default     = 1
}


variable "location" {
  description = "Location for the network interface."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the network interface."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to associate with the network interface."
  type        = string
}

# List of Public IP IDs to associate with the NIC (optional)
variable "public_ip_ids" {
  description = "List of Public IP IDs to associate with the network interfaces"
  type        = list(string)
  default     = []
}

# List of Public IP Addresses to associate with the NICs (optional)
variable "public_ip_addresses" {
  description = "List of Public IP addresses associated with the network interfaces"
  type        = list(string)
  default     = []
}