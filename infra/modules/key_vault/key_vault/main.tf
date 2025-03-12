data "azurerm_client_config" "current" {}

locals {
  key_vault_name = "${var.key_vault_name}-${var.environment}-kv"
}

resource "azurerm_key_vault" "keyvault" {
  name                            = local.key_vault_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  enabled_for_disk_encryption     = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  sku_name                        = var.sku_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover"
    ]
  }

  tags = {
    environment = var.environment
    app_name    = var.app_name
  }
}
