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
  description = "The functional area / subsystem / workload of the function app. E.g 'api'."
}

variable "asp_id" {
  type        = string
  description = "The resource id of an existing App Service Plan within which the function app runs."
}

variable "fa_elastic_instance_minimum" {
  type        = number
  description = "The number of minimum instances for this Function App. Only affects apps on Elastic Premium plans."
  default     = null
}

variable "fa_worker_count" {
  type        = number
  description = "The number of instances running each app on the service plan. Must be a multiple of availability zones in the region"
  default     = 1
}

variable "app_scale_limit" {
  type        = number
  description = "The number of workers this function app can scale out to. Only applicable to apps on the Consumption and Premium plan."
  default     = null
}

variable "dotnet_version" {
  type        = string
  description = "The version of .NET to use."
  default     = "v8.0"
}

variable "app_settings" {
  type        = map(any)
  description = "A map of key-value pairs for App Settings and custom values."
  default     = {}
}

variable "sa_name" {
  type        = string
  description = "The name of the storage account associated with the function app."
}

variable "sa_id" {
  type        = string
  description = "The resource id of the associated storage account."
}

variable "sa_iam_roles" {
  type        = set(string)
  description = "A set of role definition names to assign to the function app for the storage account scope."
}

variable "kv_id" {
  type        = string
  description = "The resource id of the key vault holding the app's sensitive variable values."
}

variable "vnet_subnet_id" {
  type        = string
  description = "The resource id of the subnet through which the function app is integrated into the VNet."
}

variable "ai_connection_string" {
  type        = string
  description = "The connection string for the application insights instance to associate with the function app."
}

variable "always_on" {
  type        = bool
  description = "Determines whether the always_on feature is enabled for the function app."
  default     = true
}

variable "cors_allowed_origins" {
  type        = list(string)
  description = "A list of origins that should be allowed to make cross-origin calls."
  nullable    = true
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
  description = "Specifies whether an app slot should be created for the function app."
}

variable "slot_name" {
  type        = string
  description = "The name of the app slot. E.g. 'staging'. Must be specified when var.create_slot = true."
  default     = null
}

variable "slot_settings" {
  type        = map(any)
  description = "A map of key-value pairs for slot-specific app_settings and custom values."
  default     = {}
}

variable "sticky_settings" {
  type = map(object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  }))
  description = "Lists of app_setting and connection_string names that the function app will not swap between slots when a swap operation is triggered."
  default     = {}
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

# variable "health_check_path" {
#   type        = string
#   description = "The health or status endpoint to hit as the pulse check for the app's nodes. Must begin with a '/'. E.g '/api/status'."
#   default     = null
#   nullable    = true
#   validation {
#     condition     = var.health_check_path == null ? true : startswith(var.health_check_path, "/")
#     error_message = "Unless null, health check path must begin with a '/'."
#   }
# }

# variable "health_check_eviction_time_mins" {
#   type        = number
#   description = "The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between 2 and 10. Only valid in conjunction with health_check_path."
#   default     = null
#   nullable    = true
# }
