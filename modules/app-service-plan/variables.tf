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
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "functional_area" {
  type        = string
  description = "The functional area / subsystem / workload of the app service plan. E.g 'ui'."
  default     = null
}

variable "os_type" {
  type        = string
  description = "The Operating System of the App Service Plan. Valid options are 'windows' or 'linux'."
}

variable "sku" {
  type        = string
  description = "The SKU of the App Service Plan."
}

variable "max_elastic_worker_count" {
  type        = number
  description = "The maximum number of workers that can be used when scaling out the apps on the service plan"
  default     = null
}

variable "worker_count" {
  type        = number
  description = "The number of instances running each app on the service plan. Must be a multiple of availability zones in the region"
  default     = 1
}

variable "zone_balancing_enabled" {
  type        = bool
  description = "Determines if zone balancing is enabled for the app service plan."
  default     = false
}

variable "auto_scale_enabled" {
  type        = bool
  description = "Should auto-scaling be enabled for the app service plan?"
  default     = null
}
