resource "azurerm_monitor_metric_alert" "degraded_health" {
  name                = "alert-${var.project_acronym}-${var.functional_area}-outage-${var.environment}"
  resource_group_name = var.rg_name
  description         = "The health check results for ${var.app_name} indicate degraded instance health."
  scopes              = [var.app_id]
  severity            = 1

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HealthCheckStatus"
    aggregation      = "Average"
    operator         = "LessThanOrEqual"
    threshold        = 99
  }

  frequency   = "PT1M"
  window_size = "PT5M"

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "server_failure_rate" {
  name                = "alert-${var.project_acronym}-${var.functional_area}-5xx-${var.environment}"
  resource_group_name = var.rg_name
  description         = "A spike in 5xx response rate from ${var.app_name}."
  scopes              = [var.app_id]
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.alert_5xx_rate_threshold
  }

  frequency   = "PT1M"
  window_size = "PT5M"

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}


resource "azurerm_monitor_metric_alert" "response_time" {
  name                = "alert-lacc-ui-response-time-${var.environment}"
  resource_group_name = var.rg_name
  description         = "A spike in response time from ${var.app_name}."
  scopes              = [var.app_id]
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HttpResponseTime"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = var.alert_latency_threshold
  }

  frequency   = "PT1M"
  window_size = "PT5M"

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}
