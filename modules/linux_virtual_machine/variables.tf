variable "vm_count" {
  description = "Number of Linux VMs to create."
  type        = number
  default     = 1
}

variable "vm_name" {
  description = "Name of the Linux VM."
  type        = string
}

variable "location" {
  description = "Azure region where the VM will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group where the VM will be created."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
}

variable "admin_username" {
  description = "Admin username for the Linux VM."
  type        = string
}

variable "admin_password" {
  description = "Admin password for the Linux VM."
  type        = string
}
variable "nic_ids" {
  description = "Network interface IDs for the VM."
  type        = list(string)
}

variable "private_ips" {
  description = "List of private IP addresses of the associated network interfaces."
  type        = list(string)
}


variable "ssh_public_key" {
  description = "The SSH public key to attach to the Linux VM."
  type        = string
}

variable "storage_os_disk_name" {
  description = "The name of the OS disk."
  type        = string
}

variable "os_disk_type" {
  description = "The type of the OS disk (Standard_LRS, Premium_LRS)."
  type        = string
  default     = "Standard_LRS"
}

variable "availability_set_id" {
  description = "Availability Set ID"
  type        = string
}

variable "image_publisher" {
  description = "Publisher of the image."
  type        = string
}

variable "image_offer" {
  description = "Offer of the image."
  type        = string
}

variable "image_sku" {
  description = "SKU of the image."
  type        = string
}

variable "image_version" {
  description = "Version of the image."
  type        = string
}


variable "disable_password_authentication" {
  description = "disable_password_authentication"
  type        = string
}
variable "tags" {
  description = "Tags for the virtual machine."
  type        = map(string)
  default     = {
    environment = "dev"
  }
}
