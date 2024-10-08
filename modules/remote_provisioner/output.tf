output "provisioned" {
  description = "Indicates whether the remote scripts have been successfully executed."
  value       = true
}

output "provisioned_vm_id" {
  value = var.vm_id
}
