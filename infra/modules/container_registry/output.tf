output "acr_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "acr_password" {
  value = azurerm_container_registry.acr.admin_password
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}
