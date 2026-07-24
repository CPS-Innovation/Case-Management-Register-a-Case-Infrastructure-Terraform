resource "azurerm_service_plan" "asp" {
  #checkov:skip=CKV_AZURE_212:Ensure App Service has a minimum number of instances for failover
  #checkov:skip=CKV_AZURE_225:Ensure the App Service Plan is zone redundant
  #checkov:skip=CKV_AZURE_211:Ensure App Service plan suitable for production use

  name                            = "asp-${var.project_acronym}-${local.qualifier}-${var.environment}"
  resource_group_name             = var.rg_name
  location                        = var.location
  os_type                         = title(var.os_type)
  sku_name                        = var.sku
  maximum_elastic_worker_count    = var.max_elastic_worker_count
  zone_balancing_enabled          = var.zone_balancing_enabled
  worker_count                    = var.worker_count
  premium_plan_auto_scale_enabled = var.auto_scale_enabled

  tags = var.tags
}

locals {
  qualifier = var.functional_area == null ? lower(var.os_type) : var.functional_area
}
