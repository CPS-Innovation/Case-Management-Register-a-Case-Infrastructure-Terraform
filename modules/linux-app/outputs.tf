output "app_id" {
  value = azurerm_linux_web_app.app.id
}

output "app_slot_id" {
  value = var.create_slot ? azurerm_linux_web_app_slot.app_slot[0].id : null
}

output "app_name" {
  value = azurerm_linux_web_app.app.name
}

output "default_hostname" {
  value = azurerm_linux_web_app.app.default_hostname
}
