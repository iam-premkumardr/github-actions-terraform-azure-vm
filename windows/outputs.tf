# Aggregate Windows VM IDs
output "windows_vm_ids" {
  description = "IDs of the created Windows VMs."
  value       = flatten([for instance in module.virtual_machine_windows : instance.vm_ids])
}


# Aggregate Windows VM Names
output "windows_vm_names" {
  description = "Names of the created Windows VMs."
  value       = flatten([for instance in module.virtual_machine_windows : instance.vm_names])
}


# Aggregate Windows VM Private IPs
output "windows_vm_private_ips" {
  description = "Private IP addresses of the created Windows VMs."
  value       = flatten([for instance in module.virtual_machine_windows : instance.vm_private_ips])
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.resource_group.rg_name
}