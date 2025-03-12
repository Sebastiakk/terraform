output "id" {
  description = "ID de la subred creada"
  value       = azurerm_subnet.subnet.id
}

output "name" {
  description = "Nombre de la subred creada"
  value       = azurerm_subnet.subnet.name
}

output "address_prefixes" {
  description = "Prefijos de direcciones de la subred creada"
  value       = azurerm_subnet.subnet.address_prefixes
}
