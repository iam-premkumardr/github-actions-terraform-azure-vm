terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.vm_count
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [var.nic_ids[count.index]]
  size                = var.vm_size
  availability_set_id = var.availability_set_id
  #OS Profile
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  computer_name       = "${var.vm_name}-${count.index + 1}"
  disable_password_authentication = var.disable_password_authentication

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  # Image Reference Configuration
  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  # OS Disk Configuration
  os_disk {
    name              = var.storage_os_disk_name
    caching           = "ReadWrite"
    storage_account_type = var.os_disk_type
  }

  # Ignore OS disk changes during destroy
  lifecycle {
    ignore_changes = [
      os_disk
    ]
  }

  # Tags
  tags = var.tags
}
