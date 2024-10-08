variable "scripts_to_run" {
  description = "List of scripts to run on the remote machine"
  type        = list(string)
  default     = []
}

variable "scripts_path" {
  description = "Path where the scripts are stored"
  type        = string
  default     = "./scripts"
}

variable "host" {
  description = "The IP address of the remote VM"
  type        = string
}

variable "username" {
  description = "Username for SSH connection"
  type        = string
}

variable "password" {
  description = "Password for SSH connection (if not using private key)"
  type        = string
  sensitive   = true
}

variable "vm_id" {
  description = "ID of the virtual machine"
  type        = string
}