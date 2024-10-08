terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
  }
}

# network_interface module main configuration
resource "azurerm_network_interface" "nic" {
  count               = var.nic_count
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"

    # Attach Public IP if created
    public_ip_address_id          = length(var.public_ip_ids) > 0 ? var.public_ip_ids[count.index] : null
  }
}