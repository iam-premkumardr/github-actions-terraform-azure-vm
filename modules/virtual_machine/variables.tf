variable "vm_name" {
  description = "Base name of the virtual machines to be created."
  type        = string
}

variable "location" {
  description = "Location for the virtual machines."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the virtual machines."
  type        = string
}

variable "nic_ids" {
  description = "List of network interface IDs to attach to the virtual machines."
  type        = list(string)
}

variable "private_ips" {
  description = "List of private IP addresses of the associated network interfaces."
  type        = list(string)
}

variable "availability_set_id" {
  description = "ID of the availability set to place the virtual machines in."
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machines (e.g., Standard_DS1_v2)."
  type        = string
  default     = "Standard_DS1_v2"
}

variable "os_type" {
  description = "Operating system type for the virtual machines: 'Linux' or 'Windows'."
  type        = string
}

variable "admin_username" {
  description = "Admin username for the virtual machines."
  type        = string
}

variable "admin_password" {
  description = "Admin password for the virtual machines."
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key to be used for the Linux VM."
  type        = string
  default     = ""
}

variable "image_publisher" {
  description = "Publisher of the OS image."
  type        = string
}

variable "image_offer" {
  description = "Offer of the OS image."
  type        = string
}

variable "image_sku" {
  description = "SKU of the OS image."
  type        = string
}

variable "image_version" {
  description = "Version of the OS image."
  type        = string
  default     = "latest"
}

variable "os_disk_type" {
  description = "Type of managed disk for the OS (e.g., Standard_LRS or Premium_LRS)."
  type        = string
  default     = "Standard_LRS"
}

variable "storage_os_disk_name" {
  description = "Storage OS Disk Name "
  type        = string
  default     = "myosdisk"
}
variable "data_disks" {
  description = "Optional list of data disks to attach to the virtual machine. Each disk is defined as an object."
  type = list(object({
    lun               = number          # Logical Unit Number (LUN) for the data disk (0, 1, 2, etc.)
    size_gb           = number          # Size of the data disk in GB
    managed_disk_type = string          # Type of managed disk (e.g., Standard_LRS or Premium_LRS)
  }))
  default = []  # No data disks by default
}

variable "vm_count" {
  description = "Number of virtual machines to create."
  type        = number
  default     = 1
}

variable "tags" {
  description = "A map of tags to assign to the virtual machines."
  type        = map(string)
  default     = {}
}

variable "custom_data" {
  description = "Custom Data"
  type        = string
}