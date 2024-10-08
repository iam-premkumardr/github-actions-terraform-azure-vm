terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
  }
}


# Loop through scripts using null_resource and count
resource "null_resource" "upload_and_exec" {
  count = length(var.scripts_to_run)

  # Upload the script using the "file" provisioner
  provisioner "file" {
    source      = var.scripts_path != "" ? "${var.scripts_path}/${var.scripts_to_run[count.index]}" : var.scripts_to_run[count.index]
    destination = "/tmp/${var.scripts_to_run[count.index]}"

    connection {
      type        = "ssh"
      host        = var.host
      user        = var.username
      password    = var.password
    }
  }

  # Execute the uploaded script using "remote-exec"
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/${var.scripts_to_run[count.index]}",
      "sudo /tmp/${var.scripts_to_run[count.index]}"
    ]

    connection {
      type        = "ssh"
      host        = var.host
      user        = var.username
      password    = var.password
    }
  }

  # Set triggers to re-run if the scripts or VM ID changes
  triggers = {
    vm_id         = var.vm_id
    script_name   = var.scripts_to_run[count.index]
  }
}