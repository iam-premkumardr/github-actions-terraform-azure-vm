# outputs.tf
output "storage_account_id" {
  description = "The ID of the Storage Account."
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_primary_endpoint" {
  description = "The primary endpoint for the Storage Account."
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}
