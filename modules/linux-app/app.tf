resource "azurerm_linux_web_app" "app" {
  #checkov:skip=CKV_AZURE_213:Ensure that App Service configures health check
  #checkov:skip=CKV_AZURE_13:Ensure App Service Authentication is set on Azure App Service
  #checkov:skip=CKV_AZURE_88:Ensure that app services use Azure Files
  #checkov:skip=CKV_AZURE_66:Ensure that App service enables failed request tracing
  #checkov:skip=CKV_AZURE_17:Ensure the web app has 'Client Certificates (Incoming client certificates)' set
  #checkov:skip=CKV_AZURE_214:Ensure App Service is set to be always on

  name                          = "${var.project_acronym}-app-${var.functional_area}-${var.environment}"
  resource_group_name           = var.rg_name
  location                      = var.location
  service_plan_id               = var.asp_id
  virtual_network_subnet_id     = var.vnet_subnet_id
  public_network_access_enabled = false
  https_only                    = true

  site_config {
    app_command_line        = var.app_command_line
    always_on               = var.always_on
    http2_enabled           = true
    vnet_route_all_enabled  = true
    ftps_state              = "FtpsOnly"
    minimum_tls_version     = "1.2"
    scm_minimum_tls_version = "1.2"
    managed_pipeline_mode   = "Integrated"

    health_check_path                 = var.health_check == null ? null : var.health_check.path
    health_check_eviction_time_in_min = var.health_check == null ? null : var.health_check.eviction_time_min
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = merge({
    APPLICATIONINSIGHTS_CONNECTION_STRING = var.ai_connection_string
  }, var.app_settings)

  dynamic "sticky_settings" {
    for_each = var.sticky_settings

    content {
      app_setting_names       = sticky_settings.value.app_setting_names
      connection_string_names = sticky_settings.value.connection_string_names
    }
  }

  logs {
    detailed_error_messages = true
    failed_request_tracing  = false

    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags,
      site_config[0].app_command_line
    ]
  }
}
