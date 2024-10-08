variable "subnet_id" {
  description = "The ID of the Subnet to associate the NSG with."
  type        = string
}

variable "nsg_id" {
  description = "The ID of the Network Security Group to associate with the Subnet."
  type        = string
}
