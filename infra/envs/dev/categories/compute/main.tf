locals {
  resource_group_name = "compute"
  bastion_name        = "kiu-challenge-aks"
  aks_name            = "kiu-challenge-aks"
}

data "terraform_remote_state" "remote_state" {
  backend = "azurerm"

  config = {
    subscription_id      = var.subscription_id
    resource_group_name  = var.tf_state_config.resource_group_name
    storage_account_name = var.tf_state_config.storage_account_name
    container_name       = var.tf_state_config.container_name
    key                  = var.tf_state_config.key
  }
}

module "compute_resource_group" {
  source = "../../../../modules/resorce_group"

  name        = local.resource_group_name
  app_name    = var.app_name
  environment = var.environment
  location    = var.location

}

module "compute_virtual_network" {
  source              = "../../../../modules/network/virtual_network"
  address_space = ["10.0.0.0/16"]
  name                = var.app_name
  resource_group_name = module.compute_resource_group.name
  location            = var.location
  environment         = var.environment
  app_name            = var.app_name

  depends_on = [
    module.compute_resource_group
  ]
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = module.compute_resource_group.name
  virtual_network_name = module.compute_virtual_network.name
  address_prefixes = ["10.0.2.0/24"]

  depends_on = [
    module.compute_virtual_network
  ]
}

module "subnet_aks" {
  source                                        = "../../../../modules/network/subnet"
  name                                          = var.app_name
  service_type                                  = "aks"
  address_prefixes = ["10.0.3.0/24"]
  virtual_network_name                          = module.compute_virtual_network.name
  resource_group_name                           = module.compute_resource_group.name
  environment                                   = var.environment
  private_link_service_network_policies_enabled = false

  depends_on = [
    module.compute_virtual_network
  ]
}

module "bastion" {
  source              = "../../../../modules/bastion"
  prefix              = local.bastion_name
  resource_group_name = module.compute_resource_group.name
  location            = var.location
  environment         = var.environment
  app_name            = var.app_name
  bastion_subnet_id   = azurerm_subnet.bastion_subnet.id

  depends_on = [
    azurerm_subnet.bastion_subnet
  ]
}

module "aks" {
  source              = "../../../../modules/kubernetes"
  resource_group_name = module.compute_resource_group.name
  location            = var.location
  environment         = var.environment
  app_name            = var.app_name
  name                = local.aks_name
  vnet_subnet_id      = module.subnet_aks.id
  vm_size             = "Standard_DS2_v2"
  service_cidr        = "10.0.4.0/24"
  dns_service_ip      = "10.0.4.10"

  depends_on = [
    module.subnet_aks
  ]
}

module "jumpbox" {
  source              = "../../../../modules/virtual_machine"
  vm_name             = "jumpbox"
  resource_group_name = module.compute_resource_group.name
  location            = var.location
  environment         = var.environment
  app_name            = var.app_name
  subnet_id           = module.subnet_aks.id
  vm_size             = "Standard_DS1_v2"

  depends_on = [
    module.subnet_aks
  ]
}


resource "azurerm_lb" "aks_internal_lb" {
  name                = "${local.aks_name}-${var.environment}-lb"
  location            = var.location
  resource_group_name = module.compute_resource_group.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "private-ip"
    subnet_id                     = module.subnet_aks.id
    private_ip_address            = "10.0.3.100"
    private_ip_address_allocation = "Static"
  }

  depends_on = [
    module.subnet_aks
  ]
}

resource "azurerm_private_link_service" "aks_private_link" {
  name                = "${var.app_name}-${var.environment}-pls"
  location            = var.location
  resource_group_name = module.compute_resource_group.name

  nat_ip_configuration {
    name               = "nat-ip"
    private_ip_address = "10.0.3.101"
    subnet_id          = module.subnet_aks.id
    primary            = true
  }

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.aks_internal_lb.frontend_ip_configuration[0].id
  ]

  depends_on = [
    azurerm_lb.aks_internal_lb
  ]
}
