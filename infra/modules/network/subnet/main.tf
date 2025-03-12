locals {
  name = "${var.name}-${var.service_type}-${var.environment}-subnet"
}


resource "azurerm_subnet" "subnet" {
  name                                          = local.name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.virtual_network_name
  address_prefixes                              = var.address_prefixes
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
}
