output "vm_ids" {
  description = "List of IDs of the created virtual machines."
  value       = azurerm_virtual_machine.vm[*].id
}

output "vm_names" {
  description = "List of names of the created virtual machines."
  value       = azurerm_virtual_machine.vm[*].name
}

output "vm_private_ips" {
  description = "Private IP addresses of the created virtual machines."
  value       = var.private_ips
}


output "vm_admin_username" {
  description = "Admin username for the created virtual machines."
  value       = var.admin_username
}

output "first_windows_vm_id" {
  value       = azurerm_virtual_machine.vm[0].id
  description = "ID of the first Linux VM"
}

