output "profile_id" {
  description = "El ID del perfil de CDN Front Door creado."
  value       = azurerm_cdn_frontdoor_profile.frontdoor.id
}

output "profile_name" {
  description = "El nombre del perfil de CDN Front Door creado."
  value       = azurerm_cdn_frontdoor_profile.frontdoor.name
}
