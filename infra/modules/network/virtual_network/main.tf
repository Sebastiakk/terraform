locals {
  name = "${var.name}-${var.environment}-vnet"
}


resource "azurerm_virtual_network" "vnet" {
  name                = local.name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
    environment = var.environment
    app_name    = var.app_name
  }
}
