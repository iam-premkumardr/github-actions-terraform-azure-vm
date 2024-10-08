# Terraform Block with Required Providers
terraform {
    required_version = ">= 1.0.0"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
  }
}