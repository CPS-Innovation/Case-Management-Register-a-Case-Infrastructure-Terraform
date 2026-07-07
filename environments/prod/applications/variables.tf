variable "project_acronym" {
  type        = string
  description = "The abbreviated project name."
}

variable "environment" {
  type        = string
  description = "The deployment environment."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network in which to create the subnet"
}

variable "vnet_rg" {
  type        = string
  description = "The name of the virtual network in which to create the subnet"
}

variable "aad_sp_name" {
  type        = string
  description = "Display name of the enterprise app (service principal) used to deploy code to the resources in the environment"
}

variable "asp_zone_balancing_enabled" {
  type        = bool
  description = "Determines if zone balancing is enabled for the app service plan."
  default     = false
}

variable "asp_auto_scale_enabled" {
  type        = bool
  description = "Should auto-scaling be enabled for the app service plan?"
  default     = false
}

variable "asp_linux_sku" {
  type        = string
  description = "The SKU of the Linux app service plan."
}

variable "asp_linux_worker_count" {
  type        = number
  description = "The number of instances running each app on the service plan. For zone redundancy, must be a multiple of availability zones in the region"
}

variable "asp_windows_sku" {
  type        = string
  description = "The SKU of the Windows app service plan."
}

variable "asp_windows_worker_count" {
  type        = number
  description = "The number of instances running each app on the service plan. For zone redundancy, must be a multiple of availability zones in the region"
}

variable "log_retention_in_days" {
  type        = number
  description = "The workspace data retention in days."
  default     = 60
}

variable "kv_soft_delete_retention_days" {
  type        = number
  description = "The number of days to retain deleted KV objects in a recoverable state"
  default     = 7
}

variable "sa_delete_retention" {
  type = object({
    days                     = number
    permanent_delete_enabled = bool
  })
  description = "The delete retention policy for the storage account"
  default = {
    days                     = 3
    permanent_delete_enabled = true
  }
}

variable "sa_replication_type" {
  type        = string
  description = "The replication type for the storage account."
  default     = "LRS"
}

variable "dev_team_email" {
  type        = string
  description = "The DL email address of the project's dev team."
  sensitive   = true
}

variable "health_check_eviction_time_min" {
  type        = number
  description = "The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between 2 and 10."
  default     = 10
}

variable "siem_evh_subscription_id" {
  type        = string
  description = "The GUID of the Azure Subscription where the SIEM event hub resides."
  sensitive   = true
}

variable "alert_ui_5xx_rate_threshold" {
  type        = number
  description = "The number of UI SPA 5xx responses over which an alert should be triggered."
}

variable "alert_ui_latency_threshold" {
  type        = number
  description = "The response time in seconds over which a latency alert should be triggered."
}
