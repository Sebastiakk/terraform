locals {
  public_ip_name    = "${var.prefix}-bastion-ip"
  bastion_host_name = "${var.prefix}-bastion"
}


resource "azurerm_public_ip" "bastion_ip" {
  name                = local.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = local.bastion_host_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tunneling_enabled   = true
  tags = {
    environment = var.environment
    app_name    = var.app_name
  }

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
}
