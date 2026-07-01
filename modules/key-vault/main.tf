resource "azurerm_key_vault" "kv" {
  name                        = "kv-${var.project_acronym}${var.functional_area}-${var.environment}"
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = true
  rbac_authorization_enabled  = true

  public_network_access_enabled = false

  sku_name = lower(var.kv_sku)

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }

  tags = var.tags
}
