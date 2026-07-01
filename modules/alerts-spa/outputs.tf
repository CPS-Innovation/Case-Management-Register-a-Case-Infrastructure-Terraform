output "alert_degraded_health_id" {
  value = azurerm_monitor_metric_alert.degraded_health.id
}

output "alert_5xx_rate" {
  value = azurerm_monitor_metric_alert.server_failure_rate.id
}

output "alert_response_time" {
  value = azurerm_monitor_metric_alert.response_time.id
}
