variable "rg_name" {
  type        = string
  description = "The name of the resource group in which to create the resource."
}

variable "hostname" {
  type        = string
  description = "The custom hostname to bind to the app service (the leftmost part of the FQDN)."
}

variable "app_service_name" {
  type        = string
  description = "The name of the app service to bind with the custom hostname."
}

variable "certificate_id" {
  type        = string
  description = "The resource ID of the certificate to bind with the app service."
}
