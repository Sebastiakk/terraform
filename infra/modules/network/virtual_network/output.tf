output "id" {
  description = "ID de la red virtual creada"
  value       = azurerm_virtual_network.vnet.id
}

output "name" {
  description = "Nombre de la red virtual creada"
  value       = azurerm_virtual_network.vnet.name
}

output "address_space" {
  description = "Espacio de direcciones de la red virtual creada"
  value       = azurerm_virtual_network.vnet.address_space
}
