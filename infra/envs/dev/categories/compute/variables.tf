variable "location" {
  type        = string
  description = "Ubicación del recurso en Azure"
}

variable "environment" {
  description = "Entorno de los recursos (dev, lab, pdn)"
  type        = string
}

variable "app_name" {
  description = "Nombre de la aplicación"
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

