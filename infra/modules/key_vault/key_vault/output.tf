output "key_vault_id" {
  description = "El ID del Key Vault."
  value       = azurerm_key_vault.keyvault.id
}

output "key_vault_uri" {
  description = "El URI del Key Vault."
  value       = azurerm_key_vault.keyvault.vault_uri
}

output "key_vault_name" {
  description = "El nombre del Key Vault."
  value       = azurerm_key_vault.keyvault.name
}

