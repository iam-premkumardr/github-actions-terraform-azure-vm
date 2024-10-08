# Linux Terraform Configuration

This directory contains Terraform configurations for deploying Linux-based virtual machines in Azure. Below is an overview of the project structure and the purpose of each file.

##  Directory

- **backend.tf**: Defines the backend configuration for state management in the Azure Storage Account. 
- **main.tf**: Main configuration file that defines the core infrastructure resources for the Linux VM. 
- **outputs.tf**: Outputs file that defines the output values to be displayed after the execution. 
- **variables.tf**: Input variables file that defines the variables used in this configuration. 

### Variables Defined in This Module

| Variable Name | Description | Type | Default Value |
|---------------|-------------|------|---------------|
| subscription_id | Azure Subscription ID | string | "" |
| app_name | Company name to use as a prefix for resource names. | string | "doc" |
| resource_group_name | Name of the resource group. | string | "lin-rg" |
| location | Azure region for resources (e.g., East US, West Europe). | string | "Australia East" |
| vnet_name | Name of the Virtual Network. | string | "lin-vnet" |
| address_space | Address space for the Virtual Network (e.g., ['10.0.0.0/16']). | list(string) | ["10.2.0.0/16"] |
| subnet_name | Name of the Subnet. | string | "lin-subnet" |
| security_rules | List of security rules for the Network Security Group | list( | No default value |
| subnet_address_prefix_linux | List of address prefixes for each subnet. | list(string) | ["10.2.2.0/24"] # Update with your own prefixes if needed |
| availability_set_name | Name of the availability set. | string | "lin-aset" |
| linux_vm_count | Number of Linux VMs to create. | number | 1 |
| linux_vm_size | Size of the Linux virtual machines (e.g., Standard_B2s). | string | "Standard_B2s" |
| admin_username_linux | Admin username for the Linux virtual machines. | string | "linuxadmin" |
| default_admin_password_linux | Default admin password for Linux VMs when no random password is generated. | string | "Default@1234" # Change to a more secure password |
| linux_image_publisher | Publisher of the Linux OS image. | string | "Canonical" |
| linux_image_offer | Offer of the Linux OS image. | string | "UbuntuServer" |
| linux_image_sku | SKU of the Linux OS image. | string | "18.04-LTS" |
| linux_image_version | Version of the Linux OS image. | string | "latest" |
| linux_os_disk_type | Type of managed disk for the Linux OS (e.g., Standard_LRS or Premium_LRS). | string | "Standard_LRS" |
| tags | A map of tags to assign to the resources. | map(string) | { |


