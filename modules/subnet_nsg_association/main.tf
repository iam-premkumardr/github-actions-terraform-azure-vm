terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "association" {
  subnet_id                 = var.subnet_id
  network_security_group_id = var.nsg_id
}
