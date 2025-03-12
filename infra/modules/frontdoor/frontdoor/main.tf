locals {
  name = "${var.name}-${var.environment}-frontdoor"
}

resource "azurerm_cdn_frontdoor_profile" "frontdoor" {
  name                = local.name
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name

  tags = {
    environment = var.environment
  }
}
