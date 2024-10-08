variable "name" {
  description = "Name of the SSH public key."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the resource."
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key."
  type        = string
}