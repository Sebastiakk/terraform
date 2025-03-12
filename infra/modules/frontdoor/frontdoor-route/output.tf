output "endpoint_id" {
  description = "El ID del endpoint de Azure Front Door creado."
  value       = azurerm_cdn_frontdoor_endpoint.endpoint.id
}

output "endpoint_name" {
  description = "El nombre del endpoint de Azure Front Door creado."
  value       = azurerm_cdn_frontdoor_endpoint.endpoint.name
}

output "route_id" {
  description = "El ID de la ruta de Azure Front Door creada."
  value       = azurerm_cdn_frontdoor_route.route.id
}

output "route_name" {
  description = "El nombre de la ruta de Azure Front Door creada."
  value       = azurerm_cdn_frontdoor_route.route.name
}
