resource "azurerm_monitor_diagnostic_setting" "evh" {
  for_each                       = local.diagnostic_settings
  name                           = "${each.key}-to-${var.eventhub_name}"
  target_resource_id             = each.value.target_resource_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.authorization_rule_id

  dynamic "enabled_log" {
    for_each = toset(each.value.enabled_logs)
    content {
      category = enabled_log.value
    }
  }

  lifecycle {
    ignore_changes = [metric]
  }
}

locals {
  diagnostic_settings = {
    ai = {
      target_resource_id = var.app_insights_id
      enabled_logs       = var.app_insights_logs
    }
    activity-log = {
      target_resource_id = "/subscriptions/${var.subscription_id}"
      enabled_logs       = var.subscription_logs
    }
  }
}
