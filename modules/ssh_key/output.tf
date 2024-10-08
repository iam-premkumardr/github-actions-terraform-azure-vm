output "public_key" {
  description = "The generated SSH public key content."
  value       = azurerm_ssh_public_key.ssh_key.public_key
  sensitive = false
}
