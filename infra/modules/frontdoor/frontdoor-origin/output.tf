output "origin_group_id" {
  description = "El ID del grupo de orígenes de Azure Front Door creado."
  value       = azurerm_cdn_frontdoor_origin_group.origin_group.id
}

output "origin_group_name" {
  description = "El nombre del grupo de orígenes de Azure Front Door creado."
  value       = azurerm_cdn_frontdoor_origin_group.origin_group.name
}

output "origin_id" {
  description = "El ID del origen de Azure Front Door creado."
  value       = azurerm_cdn_frontdoor_origin.origin.id
}

output "origin_name" {
  description = "El nombre del origen de Azure Front Door creado."
  value       = azurerm_cdn_frontdoor_origin.origin.name
}
