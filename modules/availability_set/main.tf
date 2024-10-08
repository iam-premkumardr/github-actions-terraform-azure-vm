# availability_set module main configuration
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
  }
}

resource "azurerm_availability_set" "as" {
  name                = var.as_name
  resource_group_name = var.resource_group_name
  location            = var.location
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed             = true
}
