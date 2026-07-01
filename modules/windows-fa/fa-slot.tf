resource "azurerm_windows_function_app_slot" "fa_slot" {
  count                = var.create_slot ? 1 : 0
  name                 = var.slot_name
  function_app_id      = azurerm_windows_function_app.fa.id
  storage_account_name = var.sa_name

  storage_uses_managed_identity = true
  public_network_access_enabled = false
  virtual_network_subnet_id     = var.vnet_subnet_id
  builtin_logging_enabled       = false
  https_only                    = true
  client_certificate_enabled    = false

  site_config {
    application_insights_connection_string = var.ai_connection_string
    always_on                              = var.always_on
    http2_enabled                          = true
    vnet_route_all_enabled                 = true
    ftps_state                             = "FtpsOnly"
    elastic_instance_minimum               = var.fa_elastic_instance_minimum
    worker_count                           = var.fa_worker_count
    app_scale_limit                        = var.app_scale_limit

    health_check_path                 = var.health_check == null ? null : var.health_check.path
    health_check_eviction_time_in_min = var.health_check == null ? null : var.health_check.eviction_time_min

    application_stack {
      dotnet_version              = var.dotnet_version
      use_dotnet_isolated_runtime = true
    }

    cors {
      allowed_origins     = var.cors_allowed_origins
      support_credentials = true
    }
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = var.slot_settings

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags,
      site_config,
      app_settings
    ]
  }
}
