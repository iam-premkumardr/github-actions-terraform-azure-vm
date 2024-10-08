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
  default     = "win-rg"
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
  default     = "win-vnet"
}

variable "address_space" {
  description = "Address space for the Virtual Network (e.g., ['10.0.0.0/16'])."
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

# Subnet Configuration
variable "subnet_name" {
  description = "Name of the Subnet."
  type        = string
  default     = "win-subnet"
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
    /*Tools like ping and traceroute use ICMP to test connectivity and diagnose routing issues.*/
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
    name                       = "AllowRDP"
    priority                   = 1005
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
   {
    name                       = "AllowRDP"
    priority                   = 1005
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "AllowWinRMHTTP"
    priority                   = 1006
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
   {
    name                       = "AllowWinRMHTTPS"
    priority                   = 1007
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  ]
}
# Define the subnet address prefixes for Windows 
variable "subnet_address_prefix_windows" {
  description = "List of address prefixes for each subnet."
  type        = list(string)
  default     = ["10.1.1.0/24"] # Update with your own prefixes if needed
}


# Availability Set
variable "availability_set_name" {
  description = "Name of the availability set."
  type        = string
  default     = "win-aset"
}

# Virtual Machine Counts
variable "windows_vm_count" {
  description = "Number of Windows VMs to create."
  type        = number
  default     = 1
}

# Virtual Machine Size
variable "windows_vm_size" {
  description = "Size of the Windows virtual machines (e.g., Standard_DS1_v2)."
  type        = string
  default     = "Standard_DS1_v2"
}

# Admin User for Windows VMs
variable "admin_username_windows" {
  description = "Admin username for the Windows virtual machines."
  type        = string
  default     = "windowsadmin"
}


variable "default_admin_password_windows" {
  description = "Default admin password for Windows VMs when no random password is generated."
  type        = string
  default     = "Default@1234" # Change to a more secure password
}



# Windows Image Configuration
variable "windows_image_publisher" {
  description = "Publisher of the Windows OS image."
  type        = string
  default     = "MicrosoftWindowsServer"
}

variable "windows_image_offer" {
  description = "Offer of the Windows OS image."
  type        = string
  default     = "WindowsServer"
}

variable "windows_image_sku" {
  description = "SKU of the Windows OS image."
  type        = string
  default     = "2019-Datacenter"
}

variable "windows_image_version" {
  description = "Version of the Windows OS image."
  type        = string
  default     = "latest"
}

# OS Disk Type
variable "windows_os_disk_type" {
  description = "Type of managed disk for the Windows OS (e.g., Standard_LRS or Premium_LRS)."
  type        = string
  default     = "Standard_LRS"
}

variable "custom_data" {
  description = "Custom Data to configure OpenSSH on the Windows VM"
  type        = string
  default     = <<-EOT
    <powershell>
    # Install OpenSSH Server
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

    # Start and set SSH service to automatic
    Start-Service sshd
    Set-Service -Name sshd -StartupType 'Automatic'

    # Open port 22 in the firewall
    netsh advfirewall firewall add rule name="OpenSSH" dir=in action=allow protocol=TCP localport=22
    </powershell>
  EOT
}

# Remote state

# The name of the Azure Storage Account to be used for storing the state file.
variable "storage_account_name" {
  description = "The name of the Azure Storage Account where the Terraform state file is stored."
  type        = string
  default = "docstoacc"
}

# The name of the container within the Azure Storage Account that holds the state file.
variable "storage_container_name" {
  description = "The name of the container inside the Azure Storage Account to hold the Terraform state file."
  type        = string
  default = "doc-terraform-tfstate"
}

# The path and filename for the Terraform state file in the container.
variable "tf_state" {
  description = "The key or path of the state file within the container."
  type        = string
  default     = "terraform.tfstate"
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
