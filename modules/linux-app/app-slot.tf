resource "azurerm_linux_web_app_slot" "app_slot" {
  count                         = var.create_slot ? 1 : 0
  name                          = var.slot_name
  app_service_id                = azurerm_linux_web_app.app.id
  virtual_network_subnet_id     = var.vnet_subnet_id
  public_network_access_enabled = false
  https_only                    = true
  client_certificate_enabled    = true
  client_certificate_mode       = "Optional"

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
  }, var.slot_settings)

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
      site_config
    ]
  }
}
