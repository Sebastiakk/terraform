locals {
  name = "${var.app_name}-${var.name}-${var.environment}-rg"
}


resource "azurerm_resource_group" "resource_group" {
  location = var.location
  name     = local.name
  tags = {
    environment = var.environment
    app_name    = var.app_name
  }
}
