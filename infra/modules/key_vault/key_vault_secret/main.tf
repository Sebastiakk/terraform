resource "azurerm_key_vault_secret" "secret" {
  name         = "${var.project_name}-${var.secret_name}"
  value        = var.value
  key_vault_id = var.key_vault_id
  content_type = var.content_type
  tags = {
    environment = var.environment
  }
}
