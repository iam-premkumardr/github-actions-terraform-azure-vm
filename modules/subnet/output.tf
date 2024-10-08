output "subnet_name" {
  description = "The name of the created subnet."
  value       = azurerm_subnet.subnet.name
}

output "subnet_id" {
  description = "The ID of the created subnet."
  value       = azurerm_subnet.subnet[*].id
}

output "address_prefix" {
  description = "The address prefix of the created subnet."
  value       = azurerm_subnet.subnet.address_prefixes
}
