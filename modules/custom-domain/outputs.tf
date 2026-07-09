output "hostname_binding_id" {
  value = azurerm_app_service_custom_hostname_binding.hostname.id
}

output "certificate_binding_id" {
  value = azurerm_app_service_certificate_binding.hostname.id
}
