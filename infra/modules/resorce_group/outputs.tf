output "name" {
  description = "Nombre del grupo de recursos"
  value       = azurerm_resource_group.resource_group.name
}

output "location" {
  description = "Localizacion principal donde se almacenan los recursos"
  value       = azurerm_resource_group.resource_group.location
}

output "tags" {
  value = azurerm_resource_group.resource_group.tags
}
