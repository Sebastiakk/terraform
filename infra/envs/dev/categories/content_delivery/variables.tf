variable "app_name" {
  description = "Nombre de la aplicación"
  type        = string
}

variable "location" {
  description = "Localizacion principal donde se almacenan los recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de los recursos"
  type        = string
}

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
