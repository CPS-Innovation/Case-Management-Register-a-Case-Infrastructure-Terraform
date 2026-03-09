variable "subscription_env" {
  type        = string
  description = "The subscription environment, e.g 'prod' or 'preprod'."
}

variable "environment" {
  type        = string
  description = "The deployment environment, e.g. Dev, Staging, Prod."
}

variable "project_acronym" {
  type        = string
  description = "The abbreviated project name."
}

variable "vnet_rg" {
  type        = string
  description = "The resource group containing the virtual network."
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network in which to create the subnet."
}
