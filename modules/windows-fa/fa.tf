resource "azurerm_windows_function_app" "fa" {
  name                          = "fa-${var.project_acronym}-${var.functional_area}-${var.environment}"
  resource_group_name           = var.rg_name
  location                      = var.location
  storage_account_name          = var.sa_name
  storage_uses_managed_identity = true
  service_plan_id               = var.asp_id
  virtual_network_subnet_id     = var.vnet_subnet_id
  public_network_access_enabled = false
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

  app_settings = var.app_settings

  dynamic "sticky_settings" {
    for_each = var.sticky_settings

    content {
      app_setting_names       = sticky_settings.value.app_setting_names
      connection_string_names = sticky_settings.value.connection_string_names
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags,
      app_settings,
      site_config[0].cors[0].allowed_origins
    ]
  }
}
