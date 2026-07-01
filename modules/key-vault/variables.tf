variable "tags" {
  type        = map(string)
  description = "A map of tag names to values."
}

variable "project_acronym" {
  type        = string
  description = "The abbreviated project name."
}

variable "environment" {
  type        = string
  description = "The deployment environment."
}

variable "rg_name" {
  type        = string
  description = "The name of the resource group in which to create the resource."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
}

variable "functional_area" {
  type        = string
  description = "The functional area / subsystem / workload for which the RG is created. Unless left as the default empty string, it must be prefixed with a hyphen. E.g '-backend'."
  default     = ""
  validation {
    condition     = var.functional_area == "" || startswith(var.functional_area, "-")
    error_message = "The value for var.functional_area must be prefixed with a hyphen (-), unless it is left as the default empty string."
  }
}

variable "kv_sku" {
  type        = string
  description = "The SKU tier of the key vault."
  default     = "standard"
}

variable "tenant_id" {
  type        = string
  description = "The tenant id of the current subscription."
}

variable "soft_delete_retention_days" {
  type        = number
  description = "The number of days to retain deleted KV objects in a recoverable state"
}

variable "pe_subnet_id" {
  type        = string
  description = "The id of the subnet within which the Private Endpoint IP is located."
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "Specifies the list of Private DNS Zones to include within the private_dns_zone_group"
}
