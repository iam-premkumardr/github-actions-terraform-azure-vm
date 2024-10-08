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

# Create a Single Subnet for Windows VMs
module "subnet_windows" {
  source               = "../modules/subnet"
  subnet_name          = "${var.app_name}-win-subnet"
  address_prefix       = var.subnet_address_prefix_windows # Directly pass a single string value
  resource_group_name  = module.resource_group.rg_name
  virtual_network_name = module.virtual_network.vnet_name
  depends_on           = [module.resource_group, module.virtual_network]
}



# Network Security Group Module for Windows VMs
module "network_security_group_windows" {
  source              = "../modules/network_security_group"
  nsg_name            = "${var.app_name}-win-nsg"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.rg_name
  security_rules      = var.security_rules
}


# Subnet to NSG Association for Windows VMs
module "subnet_nsg_association_windows" {
  source     = "../modules/subnet_nsg_association"
  subnet_id  = element(module.subnet_windows.subnet_id, 0)
  nsg_id     = module.network_security_group_windows.nsg_id
  depends_on = [module.subnet_windows, module.network_security_group_windows]
}


# Network Interface Module for Windows VMs
module "network_interface_windows" {
  source              = "../modules/network_interface"
  count               = var.windows_vm_count 
  nic_name            = "${var.app_name}-win-nic-${format("%02d", count.index + 1)}"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
  subnet_id           = element(module.subnet_windows.subnet_id, 0)
  # Correctly reference unique public IPs
  public_ip_ids       = module.public_ip_windows[count.index].public_ip_id
  public_ip_addresses = flatten(module.public_ip_windows[*].public_ip_address)
  depends_on          = [module.public_ip_windows, module.subnet_windows, module.public_ip_windows]
}


# Define the Public IP Module for Windows VMs
module "public_ip_windows" {
  source              = "../modules/public_ip"
  count               = var.windows_vm_count
  public_ip_name      = "${var.app_name}-win-pip-${format("%02d", count.index + 1)}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.rg_name
  allocation_method   = "Static"
  sku                 = "Basic"
  depends_on          = [module.resource_group]
}

#SSH Keys
module "ssh_key" {
  source              = "../modules/ssh_key"
  name                = "${var.app_name}-win-key-pair"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
  public_key_path     = "~/.ssh/id_rsa.pub"
  depends_on          = [module.resource_group]
}

# Virtual Machine Module for Windows VMs
module "virtual_machine_windows" {
  source              = "../modules/virtual_machine"
  count               = var.windows_vm_count
  vm_name             = "${var.app_name}-win-vm-${format("%02d", count.index + 1)}"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
  admin_username      = var.admin_username_windows
  admin_password      = var.default_admin_password_windows
  custom_data         = var.custom_data

  # Fix the references to pass correct values
  nic_ids     = element(module.network_interface_windows[*].nic_id, count.index)
  private_ips = element(module.network_interface_windows[*].private_ip, count.index)

  availability_set_id = module.availability_set.as_id
  vm_size             = var.windows_vm_size
  os_type             = "Windows"
  ssh_public_key = module.ssh_key.public_key
  # Windows Image Configuration
  image_publisher = var.windows_image_publisher
  image_offer     = var.windows_image_offer
  image_sku       = var.windows_image_sku
  image_version   = var.windows_image_version

  # OS Disk Type
  storage_os_disk_name = "${var.app_name}-win-vm-osdisk-${format("%02d", count.index + 1)}"
  os_disk_type         = var.windows_os_disk_type

  tags       = var.tags
  depends_on = [module.resource_group, module.network_interface_windows, module.availability_set]
}
