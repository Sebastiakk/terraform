variable "name" {
  description = "Nombre de la subred"
  type        = string
}


variable "environment" {
  description = "Entorno de los recursos (dev, lab, pdn)"
  type        = string
}


variable "resource_group_name" {
  description = "El nombre del grupo de recursos."
  type        = string
  validation {
    condition     = length(var.resource_group_name) >= 1
    error_message = "El nombre del grupo de recursos no puede estar vacío."
  }
}

variable "service_type" {
  description = "Tipo de servicio al que está destinada la subred. Opciones: 'database', 'bastion', 'aks'"
  type        = string
  validation {
    condition = contains(["database", "bastion", "aks"], var.service_type)
    error_message = "El tipo de servicio debe ser uno de los siguientes: 'database', 'bastion', 'aks'."
  }
}

variable "virtual_network_name" {
  description = "Nombre de la red virtual a la que pertenecerá la subred"
  type        = string
}

variable "address_prefixes" {
  description = "Prefijos de direcciones de la subred en formato CIDR"
  type = list(string)
}

variable "private_link_service_network_policies_enabled" {
  description = "Indica si las políticas de red del servicio de vínculo privado están habilitadas"
  type        = bool
  default     = false
}



