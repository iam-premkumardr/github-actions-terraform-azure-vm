
# Aggregate Linux VM IDs
output "linux_vm_ids" {
  description = "IDs of the created Linux VMs."
  value       = flatten([for instance in module.virtual_machine_linux : instance.vm_ids])
}


# Aggregate Linux VM Names
output "linux_vm_names" {
  description = "Names of the created Linux VMs."
  value       = flatten([for instance in module.virtual_machine_linux : instance.vm_names])
}



# Aggregate Linux VM Private IPs
output "linux_vm_private_ips" {
  description = "Private IP addresses of the created Linux VMs."
  value       = flatten([for instance in module.virtual_machine_linux : instance.vm_private_ips])
}


output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.resource_group.rg_name
}