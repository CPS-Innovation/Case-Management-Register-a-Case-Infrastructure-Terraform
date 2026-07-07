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
  description = "The functional area / subsystem / workload of the web app. E.g 'ui'."
}

variable "asp_id" {
  type        = string
  description = "The resource id of an existing App Service Plan within which the app runs."
}

variable "vnet_subnet_id" {
  type        = string
  description = "The resource id of the subnet through which the app is integrated into the VNet."
}

variable "app_command_line" {
  type        = string
  description = "The App command line to launch."
  default     = null
}

variable "always_on" {
  type        = bool
  description = "Determines whether the always_on feature is enabled for the app."
  default     = true
}

variable "worker_count" {
  type        = number
  description = "The number of Workers for this Linux App Service."
  default     = 1
}

variable "ai_connection_string" {
  type        = string
  description = "The connection string for the application insights instance to associate with the app."
}

variable "app_settings" {
  type        = map(any)
  description = "A map of key-value pairs for App Settings and custom values."
  default     = {}
}

variable "pe_subnet_id" {
  type        = string
  description = "The id of the subnet within which the Private Endpoint IP is located."
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "Specifies the list of Private DNS Zones to include within the private_dns_zone_group"
}

variable "create_slot" {
  type        = bool
  description = "Specifies whether an app slot should be created for the app."
}

variable "slot_name" {
  type        = string
  description = "The name of the app slot. E.g. 'staging'. Must be specified when var.create_slot = true."
  default     = null
}

variable "slot_settings" {
  type        = map(any)
  description = "A map of key-value pairs for slot-specific App Settings and custom values."
  default     = {}
}

variable "sticky_settings" {
  type = map(object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  }))
  default = {}
}

variable "health_check" {
  type = object({
    path              = string
    eviction_time_min = number
  })
  description = "The health check settings for the app."
  validation {
    condition     = var.health_check == null ? true : startswith(var.health_check.path, "/")
    error_message = "Unless null, health check path must begin with a '/'."
  }
  default = null
}
