# Azure Subscription ID
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
  default     = ""
}

# Application Prefix
variable "app_name" {
  description = "Company name to use as a prefix for resource names."
  type        = string
  default     = "doc"
}

# Resource Group Variables
variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
  default     = "lin-rg"
}

variable "location" {
  description = "Azure region for resources (e.g., East US, West Europe)."
  type        = string
  default     = "Australia East"
}

# Virtual Network Configuration
variable "vnet_name" {
  description = "Name of the Virtual Network."
  type        = string
  default     = "lin-vnet"
}

variable "address_space" {
  description = "Address space for the Virtual Network (e.g., ['10.0.0.0/16'])."
  type        = list(string)
  default     = ["10.2.0.0/16"]
}

# Subnet Configuration
variable "subnet_name" {
  description = "Name of the Subnet."
  type        = string
  default     = "lin-subnet"
}

# Security Rules

variable "security_rules" {
  description = "List of security rules for the Network Security Group"
  type = list(
    object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })
  )
  default = [
  {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "AllowHTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "AllowHTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "AllowICMP"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "AllowJenkins"
    priority                   = 1005
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  ]
}

# Define the subnet address prefixes for Windows 
variable "subnet_address_prefix_linux" {
  description = "List of address prefixes for each subnet."
  type        = list(string)
  default     = ["10.2.2.0/24"] # Update with your own prefixes if needed
}


# Availability Set
variable "availability_set_name" {
  description = "Name of the availability set."
  type        = string
  default     = "lin-aset"
}

variable "linux_vm_count" {
  description = "Number of Linux VMs to create."
  type        = number
  default     = 1
}


variable "linux_vm_size" {
  description = "Size of the Linux virtual machines (e.g., Standard_B2s)."
  type        = string
  default     = "Standard_B2s"
}


# Admin User for Linux VMs
variable "admin_username_linux" {
  description = "Admin username for the Linux virtual machines."
  type        = string
  default     = "linuxadmin"
}


variable "default_admin_password_linux" {
  description = "Default admin password for Linux VMs when no random password is generated."
  type        = string
  default     = "Default@1234" # Change to a more secure password
}

# Linux Image Configuration
variable "linux_image_publisher" {
  description = "Publisher of the Linux OS image."
  type        = string
  default     = "Canonical"
}

variable "linux_image_offer" {
  description = "Offer of the Linux OS image."
  type        = string
  default     = "UbuntuServer"
}

variable "linux_image_sku" {
  description = "SKU of the Linux OS image."
  type        = string
  default     = "18.04-LTS"
}

variable "linux_image_version" {
  description = "Version of the Linux OS image."
  type        = string
  default     = "latest"
}

# OS Disk Type
variable "linux_os_disk_type" {
  description = "Type of managed disk for the Linux OS (e.g., Standard_LRS or Premium_LRS)."
  type        = string
  default     = "Standard_LRS"
}

# Tags for Resources
variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default = {
    environment = "dev"
    project     = "example"
  }
}
