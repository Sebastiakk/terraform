locals {
  unique_id = substr(md5("${var.app_name}-${var.environment}"), 0, 8)
  acr_name = "${var.acr_name}${var.environment}${local.unique_id}"
}


resource "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true

  tags = {
    environment = var.environment
    app_name    = var.app_name
  }
}
