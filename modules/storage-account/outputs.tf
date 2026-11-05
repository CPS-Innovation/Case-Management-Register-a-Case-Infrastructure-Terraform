output "account_id" {
  value = azurerm_storage_account.sa.id
}

output "account_name" {
  value = azurerm_storage_account.sa.name
}

output "container_ids" {
  value = {
    for name in var.containers : name => azurerm_storage_container.sa[name].id
  }
}
