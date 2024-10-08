# Storage Account Terraform Module

This directory contains Terraform configurations for creating and managing an Azure Storage Account. The module supports defining a storage account, configuring access, and managing containers.

## Module Overview
The `storage_account` module allows users to create and manage Azure Storage Accounts with different configurations. Below is an overview of the project structure and the purpose of each file.

##  Directory

- **main.tf**: Main configuration file that defines the core resources for the Azure Storage Account. 
- **output.tf**: Terraform configuration file. 
- **variables.tf**: Input variables file that defines the variables used in this module. 

### Variables Defined in This Module

| Variable Name | Description | Type | Default Value |
|---------------|-------------|------|---------------|
| subscription_id | The Azure Subscription ID to deploy the resources in. | string | "" |
| resource_group_name | The name of the resource group. | string | "sto-rg" |
| location | The location/region of the resource group. | string | "Australia East" |
| app_name | Company name to use as a prefix for resource names. | string | "doc" |
| storage_account_name | The name of the Storage Account to create. | string | "stoacc" |
| storage_container_name | The name of the Storage Account to create. | string | "terraform-tfstate" |
| account_tier | The tier of the storage account. | string | "Standard" |
| replication_type | The replication strategy for the storage account. | string | "LRS" |
| tags | Tags to apply to resources. | map(string) | { |


