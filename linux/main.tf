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

# Virtual Network Module
module "virtual_network" {
  source              = "../modules/virtual_network"
  vnet_name           = "${var.app_name}-${var.vnet_name}"
  address_space       = var.address_space
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
  depends_on          = [module.resource_group]
}

# Availability Set Module
module "availability_set" {
  source              = "../modules/availability_set"
  as_name             = "${var.app_name}-${var.availability_set_name}"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
  depends_on          = [module.resource_group]
}

# Create a Single Subnet for Linux VMs
module "subnet_linux" {
  source               = "../modules/subnet"
  subnet_name          = "${var.app_name}-lin-subnet"
  address_prefix       = var.subnet_address_prefix_linux # Directly pass a single string value
  resource_group_name  = module.resource_group.rg_name
  virtual_network_name = module.virtual_network.vnet_name
  depends_on           = [module.resource_group, module.virtual_network]
}


# Network Security Group Module for Linux VMs
module "network_security_group_linux" {
  source              = "../modules/network_security_group"
  nsg_name            = "${var.app_name}-lin-nsg"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.rg_name
  security_rules      = var.security_rules
}


# Subnet to NSG Association for Linux VMs
module "subnet_nsg_association_linux" {
  source     = "../modules/subnet_nsg_association"
  subnet_id  = element(module.subnet_linux.subnet_id, 0)
  nsg_id     = module.network_security_group_linux.nsg_id
  depends_on = [module.subnet_linux, module.network_security_group_linux]
}


# Network Interface Module for Linux VMs
module "network_interface_linux" {
  source              = "../modules/network_interface"
  count               = var.linux_vm_count
  nic_name            = "${var.app_name}-lin-nic-${format("%02d", count.index + 1)}"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
  subnet_id           = element(module.subnet_linux.subnet_id, 0)
  # Correctly reference unique public IPs
  public_ip_ids       = module.public_ip_linux[count.index].public_ip_id
  public_ip_addresses = flatten(module.public_ip_linux[*].public_ip_address)
  depends_on          = [module.public_ip_linux, module.subnet_linux]
}


# Define the Public IP Module for Linux VMs
module "public_ip_linux" {
  source              = "../modules/public_ip"
  count               = var.linux_vm_count
  public_ip_name      = "${var.app_name}-lin-pip-${format("%02d", count.index + 1)}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.rg_name
  allocation_method   = "Static"
  sku                 = "Basic"
  depends_on          = [module.resource_group]
}


#SSH Keys
module "ssh_key" {
  source              = "../modules/ssh_key"
  name                = "${var.app_name}-key-pair"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
  public_key_path     = "~/.ssh/id_rsa.pub"
  depends_on          = [module.resource_group]
}

# Virtual Machine Module for Linux VMs
module "virtual_machine_linux" {
  source              = "../modules/linux_virtual_machine"
  count               = var.linux_vm_count
  vm_name             = "${var.app_name}-lin-vm-${format("%02d", count.index + 1)}"
  vm_size             = var.linux_vm_size
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
  admin_username      = var.admin_username_linux
  admin_password      = var.default_admin_password_linux
  availability_set_id = module.availability_set.as_id
  # Fix the references to pass correct values
  nic_ids     = element(module.network_interface_linux[*].nic_id, count.index)
  private_ips = element(module.network_interface_linux[*].private_ip, count.index)
  #ssh
  ssh_public_key = module.ssh_key.public_key
  # Linux Image Configuration
  image_publisher = var.linux_image_publisher
  image_offer     = var.linux_image_offer
  image_sku       = var.linux_image_sku
  image_version   = var.linux_image_version

  # OS Disk 
  storage_os_disk_name = "${var.app_name}-lin-vm-osdisk-${format("%02d", count.index + 1)}"
  os_disk_type         = var.linux_os_disk_type

  # OS Profile Linux Configuration to enable password authentication
  disable_password_authentication = false
  # Tags
  tags       = var.tags
  depends_on = [module.resource_group, module.network_interface_linux]

}

# Remote-exec provisioner for executing a script on the VM
resource "null_resource" "remote_exec" {
  provisioner "remote-exec" {
    inline = [
      #!/bin/bash
      "echo 'Running remote script...'",
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx"

    ]

    # Connection block using username and password
    connection {
      type     = "ssh"
      host     = module.virtual_machine_linux[0].first_vm_public_ip
      user     = var.admin_username_linux
      password = var.default_admin_password_linux
    }
  }

 # Triggers to re-run the remote provisioner if necessary
  triggers = {
    vm_id = module.virtual_machine_linux[0].first_vm_id
  }
  # Ensure the VM is created before running the provisioner
  depends_on = [module.virtual_machine_linux]
}

/*
# Nested module call for the remote provisioner
  module "remote_provisioner" {
    source              = "./modules/remote_provisioner"
    count               = var.linux_vm_count > 0 ? 1 : 0
    host                = module.virtual_machine_linux[0].first_vm_public_ip 
    username            = var.admin_username_linux
    password            = var.default_admin_password_linux
    scripts_to_run      = ["install_jenkins.sh"]
    scripts_path        = "./modules/remote_provisioner/scripts"
    vm_id               = module.virtual_machine_linux[0].first_vm_id 
    depends_on          = [module.virtual_machine_linux]  # Ensure VM is created before provisioner runs
}
*/