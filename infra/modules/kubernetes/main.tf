locals {
  name       = "${var.name}-${var.environment}-aks"
  dns_prefix = "${var.name}-${var.environment}-aks"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                    = local.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  dns_prefix              = local.dns_prefix
  private_cluster_enabled = true
  tags = {
    environment = var.environment
    app_name    = var.app_name
  }

  default_node_pool {
    name           = "default"
    node_count     = var.node_count
    vm_size        = var.vm_size
    vnet_subnet_id = var.vnet_subnet_id
    upgrade_settings {
      drain_timeout_in_minutes      = 0
      node_soak_duration_in_minutes = 0
      max_surge                     = "10%"
    }
  }

  identity {
    type = "SystemAssigned"
  }


  network_profile {
    network_plugin = var.network_plugin
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }
}
