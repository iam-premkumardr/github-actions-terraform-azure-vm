# virtual_machine module main configuration

resource "azurerm_virtual_machine" "vm" {
  count               = var.vm_count
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [var.nic_ids[count.index]]
  availability_set_id = var.availability_set_id
  vm_size             = var.vm_size

  # OS Disk configuration
  storage_os_disk {
    name              = var.storage_os_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.os_disk_type
  }

   # Optional Data Disk configuration
  dynamic "storage_data_disk" {
    for_each = var.data_disks
    content {
      name              = "${var.vm_name}-datadisk-${count.index + 1}-${storage_data_disk.value.lun}"
      lun               = storage_data_disk.value.lun
      caching           = "ReadOnly"
      create_option     = "Empty"
      disk_size_gb      = storage_data_disk.value.size_gb
      managed_disk_type = storage_data_disk.value.managed_disk_type
    }
  }

  # OS profile settings based on OS type
  os_profile {
    computer_name  = "${var.vm_name}-${count.index + 1}"
    admin_username = var.admin_username
    admin_password = var.admin_password
    # Use the custom_data attribute to run a script on the first boot
    custom_data = var.custom_data
  }

  dynamic "os_profile_windows_config" {
    for_each = var.os_type == "Windows" ? [1] : []
    content {
      provision_vm_agent = true
    }
  }

  # Image reference for the VM OS
  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }



# Ignore OS disk changes during destroy
  lifecycle {
    ignore_changes = [
      storage_os_disk,
      storage_data_disk
    ]
  }
  # Tags for the VM
  tags = var.tags
}
