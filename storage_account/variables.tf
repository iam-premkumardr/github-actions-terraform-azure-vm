variable "subscription_id" {
  description = "The Azure Subscription ID to deploy the resources in."
  type        = string
  sensitive   = true
  default     = ""
}


variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "sto-rg"
}

variable "location" {
  description = "The location/region of the resource group."
  type        = string
  default     = "Australia East"
}
# Application Prefix
variable "app_name" {
  description = "Company name to use as a prefix for resource names."
  type        = string
  default     = "doc"
}

variable "storage_account_name" {
  description = "The name of the Storage Account to create."
  type        = string
  default = "stoacc"
}

variable "storage_container_name" {
  description = "The name of the Storage Account to create."
  type        = string
  default = "terraform-tfstate"
}

variable "account_tier" {
  description = "The tier of the storage account."
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "The replication strategy for the storage account."
  type        = string
  default     = "LRS"
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {
    environment = "development"
  }
}
