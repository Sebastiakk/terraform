variable "name" {
  description = "Nombre de la red virtual"
  type        = string
}

variable "address_space" {
  description = "Espacio de direcciones de la red virtual en formato CIDR"
  type = list(string)
}

variable "location" {
  description = "Ubicación de la red virtual"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos donde se creará la red virtual"
  type        = string
}

variable "environment" {
  description = "Entorno de los recursos"
  type        = string
}


variable "app_name" {
  description = "Nombre de la aplicación"
  type        = string
}





