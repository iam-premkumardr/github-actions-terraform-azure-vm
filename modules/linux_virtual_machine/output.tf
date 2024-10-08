output "vm_ids" {
  description = "List of IDs of the Linux VMs"
  value       = azurerm_linux_virtual_machine.vm[*].id
}

output "vm_names" {
  description = "List of names of the Linux VMs"
  value       = azurerm_linux_virtual_machine.vm[*].name
}

output "vm_private_ips" {
  description = "List of private IP addresses of the Linux VMs"
  value       = var.private_ips
}

output "public_ip_addresses" {
  description = "List of public IP addresses of the Linux VMs"
  value       = azurerm_linux_virtual_machine.vm[*].public_ip_address
}

output "first_vm_id" {
  value       = azurerm_linux_virtual_machine.vm[0].id
  description = "ID of the first Linux VM"
}

output "first_vm_public_ip" {
  value       = azurerm_linux_virtual_machine.vm[0].public_ip_address
  description = "Public IP address of the first Linux VM"
}