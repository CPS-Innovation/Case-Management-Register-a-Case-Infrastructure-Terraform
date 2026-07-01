resource "azurerm_storage_account" "sa" {
  #checkov:skip=CKV_AZURE_35:Ensure default network access rule for Storage Accounts is set to deny.
  #checkov:skip=CKV_AZURE_33:Ensure Storage logging is enabled for Queue service for read, write and delete requests
  #checkov:skip=CKV_AZURE_206:Ensure that Storage Accounts use replication
  #checkov:skip=CKV2_AZURE_1:Ensure storage for critical data are encrypted with Customer Managed Key
  #checkov:skip=CKV2_AZURE_18:Ensure that Storage Accounts use customer-managed key for encryption

  name                            = "sa${var.project_acronym}${var.functional_area}${var.environment}"
  resource_group_name             = var.rg_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = var.replication_type
  min_tls_version                 = "TLS1_2"
  is_hns_enabled                  = true
  public_network_access_enabled   = false
  shared_access_key_enabled       = var.shared_key_access_enabled
  allow_nested_items_to_be_public = false
  local_user_enabled              = false

  blob_properties {
    delete_retention_policy {
      days                     = var.blob_delete_retention.days
      permanent_delete_enabled = var.blob_delete_retention.permanent_delete_enabled
    }

    container_delete_retention_policy {
      days = var.blob_delete_retention.days
    }
  }

  tags = var.tags
}
