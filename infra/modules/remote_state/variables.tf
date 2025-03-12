variable "subscription_id" {
  description = "ID de la suscripción de Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos para el estado remoto"
  type        = string
  default     = "value"
}

variable "storage_account_name" {
  description = "Nombre de la cuenta de almacenamiento para el estado remoto"
  type        = string
}

variable "container_name" {
  description = "Nombre del contenedor para el estado remoto"
  type        = string
}

variable "key" {
  description = "Clave para el estado remoto"
  type        = string
}
