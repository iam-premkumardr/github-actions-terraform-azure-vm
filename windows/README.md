# Windows Terraform Configuration

This directory contains Terraform configurations for deploying Windows-based virtual machines in Azure. Below is an overview of the project structure and the purpose of each file.

##  Directory

- **backend.tf**: Defines the backend configuration for state management in the Azure Storage Account. 
- **main.tf**: Main configuration file that defines the core infrastructure resources for the Windows VM. 
- **outputs.tf**: Outputs file that defines the output values to be displayed after the execution. 
- **variables.tf**: Input variables file that defines the variables used in this configuration. 

### Variables Defined in This Module

| Variable Name | Description | Type | Default Value |
|---------------|-------------|------|---------------|
| subscription_id | Azure Subscription ID | string | "" |
| app_name | App name to use as a prefix for resource names. | string | "doc" |
| resource_group_name | Name of the resource group. | string | "win-rg" |
| location | Azure region for resources (e.g., East US, West Europe). | string | "Australia East" |
| vnet_name | Name of the Virtual Network. | string | "win-vnet" |
| address_space | Address space for the Virtual Network (e.g., ['10.0.0.0/16']). | list(string) | ["10.1.0.0/16"] |
| subnet_name | Name of the Subnet. | string | "win-subnet" |
| security_rules | List of security rules for the Network Security Group | list( | No default value |
| subnet_address_prefix_windows | List of address prefixes for each subnet. | list(string) | ["10.1.1.0/24"] # Update with your own prefixes if needed |
| availability_set_name | Name of the availability set. | string | "win-aset" |
| windows_vm_count | Number of Windows VMs to create. | number | 1 |
| windows_vm_size | Size of the Windows virtual machines (e.g., Standard_DS1_v2). | string | "Standard_DS1_v2" |
| admin_username_windows | Admin username for the Windows virtual machines. | string | "windowsadmin" |
| default_admin_password_windows | Default admin password for Windows VMs when no random password is generated. | string | "Default@1234" # Change to a more secure password |
| windows_image_publisher | Publisher of the Windows OS image. | string | "MicrosoftWindowsServer" |
| windows_image_offer | Offer of the Windows OS image. | string | "WindowsServer" |
| windows_image_sku | SKU of the Windows OS image. | string | "2019-Datacenter" |
| windows_image_version | Version of the Windows OS image. | string | "latest" |
| windows_os_disk_type | Type of managed disk for the Windows OS (e.g., Standard_LRS or Premium_LRS). | string | "Standard_LRS" |
| custom_data | Custom Data to configure OpenSSH on the Windows VM | string | <<-EOT |
| storage_account_name | The name of the Azure Storage Account where the Terraform state file is stored. | string | "docstoacc" |
| storage_container_name | The name of the container inside the Azure Storage Account to hold the Terraform state file. | string | "doc-terraform-tfstate" |
| tf_state | The key or path of the state file within the container. | string | "terraform.tfstate" |
| tags | A map of tags to assign to the resources. | map(string) | { |

- **versions.tf**: Terraform configuration file. 

