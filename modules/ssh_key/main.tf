resource "azurerm_ssh_public_key" "ssh_key" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  public_key          =  file(var.public_key_path)
}