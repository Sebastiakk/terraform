variable "subscription_id" {
  type        = string
  description = "ID de la suscripción de Azure"
}
variable "tf_state_config" {
  description = "Configuración del backend de Terraform"
  type = object({
    storage_account_name = string
    container_name       = string
    key                  = string
    resource_group_name  = string
  })
}
