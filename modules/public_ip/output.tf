output "public_ip_id" {
  description = "The ID of the public IP"
  value       = azurerm_public_ip.pip[*].id
}

output "public_ip_address" {
  description = "The address of the public IP"
  value       = azurerm_public_ip.pip[*].ip_address
}


output "first_windows_vm_public_ip" {
  value       = azurerm_public_ip.pip[0].ip_address
  description = "Public IP address of the first Linux VM"
}