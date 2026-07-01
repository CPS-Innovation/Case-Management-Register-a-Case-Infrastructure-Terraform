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

variable "functional_area" {
  type        = string
  description = "The functional area / subsystem / workload of the function app monitored by the alert rule."
}

variable "app_id" {
  type        = string
  description = "The resource id of the app service resource monitored by the alert rule."
}

variable "app_name" {
  type        = string
  description = "The name of the app service resource monitored by the alert rule."
}

variable "action_group_id" {
  type        = string
  description = "List of one or more Action Group resource IDs to invoke when the alert fires."
}

variable "alert_5xx_rate_threshold" {
  type        = number
  description = "The number of 5xx responses over which an alert should be triggered."
}

variable "alert_latency_threshold" {
  type        = number
  description = "The response time in seconds over which a latency alert should be triggered."
}
