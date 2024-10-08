# variables.tf
variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "location" {
  description = "The location/region where the storage account is created."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account to create. Must be globally unique."
  type        = string
}

variable "storage_container_name" {
  description = "The name of the storage account to create. Must be globally unique."
  type        = string
}

variable "account_tier" {
  description = "The tier of the storage account. Options: Standard or Premium."
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "The replication strategy of the storage account. Options: LRS, GRS, RAGRS, ZRS."
  type        = string
  default     = "LRS"
}

variable "tags" {
  description = "A map of tags to add to the resource."
  type        = map(string)
  default     = {}
}
