# main.tf
# Terraform Block with Required Providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
  }
}

# Configure the AzureRM Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Resource Group Module
module "resource_group" {
  source     = "../modules/resource_group"
  rg_name    = "${var.app_name}-${var.resource_group_name}"
  location   = var.location
  depends_on = [var.subscription_id]
}

module "azure_storage" {
  source                  = "../modules/storage_account"
  resource_group_name     = module.resource_group.rg_name
  location                = module.resource_group.location
  storage_account_name    = "${var.app_name}${var.storage_account_name}"
  storage_container_name  = "${var.app_name}-${var.storage_container_name}"
  account_tier            = var.account_tier
  replication_type        = var.replication_type
  tags                    = var.tags
  depends_on = [module.resource_group]
}
