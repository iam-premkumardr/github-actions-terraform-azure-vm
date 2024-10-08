output "nic_id" {
  description = "List of IDs of the created network interfaces."
  value       = azurerm_network_interface.nic[*].id
}

# Output the Private IP Addresses for all instances of the network interface
output "private_ip" {
  description = "The private IP address of the Network Interface"
  value       = [for nic in azurerm_network_interface.nic : nic.ip_configuration[0].private_ip_address]
}
# Output the Public IP Addresses passed from the parent module
output "public_ip_ids" {
  description = "The public IP addresses associated with the NICs (if applicable)"
  value       = var.public_ip_addresses
}