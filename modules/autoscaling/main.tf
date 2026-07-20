resource "azurerm_monitor_autoscale_setting" "as" {
  name                = "as-${var.asp_name}"
  resource_group_name = var.rg_name
  location            = var.location
  target_resource_id  = var.asp_id

  # Default profile
  profile {
    name = "Default"

    capacity {
      default = var.default_capacity.default
      minimum = var.default_capacity.minimum
      maximum = var.default_capacity.maximum
    }

    # Requests - increase (for each service)
    dynamic "rule" {
      for_each = var.scale_metrics.requests == null ? [] : local.requests_rules_increase

      content {
        metric_trigger {
          metric_name              = rule.value.metric_trigger.metric_name
          metric_resource_id       = rule.value.metric_trigger.metric_resource_id
          metric_namespace         = rule.value.metric_trigger.metric_namespace
          time_grain               = rule.value.metric_trigger.time_grain
          statistic                = rule.value.metric_trigger.statistic
          time_window              = rule.value.metric_trigger.time_window
          time_aggregation         = rule.value.metric_trigger.time_aggregation
          operator                 = rule.value.metric_trigger.operator
          threshold                = rule.value.metric_trigger.threshold
          divide_by_instance_count = rule.value.metric_trigger.divide_by_instance_count
        }

        scale_action {
          cooldown  = rule.value.scale_action.cooldown
          direction = rule.value.scale_action.direction
          type      = rule.value.scale_action.type
          value     = rule.value.scale_action.value
        }
      }
    }

    # Requests - decrease (for each service)
    dynamic "rule" {
      for_each = var.scale_metrics.requests == null ? [] : local.requests_rules_decrease

      content {
        metric_trigger {
          metric_name              = rule.value.metric_trigger.metric_name
          metric_resource_id       = rule.value.metric_trigger.metric_resource_id
          metric_namespace         = rule.value.metric_trigger.metric_namespace
          time_grain               = rule.value.metric_trigger.time_grain
          statistic                = rule.value.metric_trigger.statistic
          time_window              = rule.value.metric_trigger.time_window
          time_aggregation         = rule.value.metric_trigger.time_aggregation
          operator                 = rule.value.metric_trigger.operator
          threshold                = rule.value.metric_trigger.threshold
          divide_by_instance_count = rule.value.metric_trigger.divide_by_instance_count
        }

        scale_action {
          cooldown  = rule.value.scale_action.cooldown
          direction = rule.value.scale_action.direction
          type      = rule.value.scale_action.type
          value     = rule.value.scale_action.value
        }
      }
    }

    # CPU - increase
    rule {
      metric_trigger {
        metric_name              = local.cpu_rule_increase.metric_trigger.metric_name
        metric_resource_id       = local.cpu_rule_increase.metric_trigger.metric_resource_id
        metric_namespace         = local.cpu_rule_increase.metric_trigger.metric_namespace
        time_grain               = local.cpu_rule_increase.metric_trigger.time_grain
        statistic                = local.cpu_rule_increase.metric_trigger.statistic
        time_window              = local.cpu_rule_increase.metric_trigger.time_window
        time_aggregation         = local.cpu_rule_increase.metric_trigger.time_aggregation
        operator                 = local.cpu_rule_increase.metric_trigger.operator
        threshold                = local.cpu_rule_increase.metric_trigger.threshold
        divide_by_instance_count = local.cpu_rule_increase.metric_trigger.divide_by_instance_count
      }

      scale_action {
        cooldown  = local.cpu_rule_increase.scale_action.cooldown
        direction = local.cpu_rule_increase.scale_action.direction
        type      = local.cpu_rule_increase.scale_action.type
        value     = local.cpu_rule_increase.scale_action.value
      }
    }

    # CPU - decrease
    rule {
      metric_trigger {
        metric_name              = local.cpu_rule_decrease.metric_trigger.metric_name
        metric_resource_id       = local.cpu_rule_decrease.metric_trigger.metric_resource_id
        metric_namespace         = local.cpu_rule_decrease.metric_trigger.metric_namespace
        time_grain               = local.cpu_rule_decrease.metric_trigger.time_grain
        statistic                = local.cpu_rule_decrease.metric_trigger.statistic
        time_window              = local.cpu_rule_decrease.metric_trigger.time_window
        time_aggregation         = local.cpu_rule_decrease.metric_trigger.time_aggregation
        operator                 = local.cpu_rule_decrease.metric_trigger.operator
        threshold                = local.cpu_rule_decrease.metric_trigger.threshold
        divide_by_instance_count = local.cpu_rule_decrease.metric_trigger.divide_by_instance_count
      }

      scale_action {
        cooldown  = local.cpu_rule_decrease.scale_action.cooldown
        direction = local.cpu_rule_decrease.scale_action.direction
        type      = local.cpu_rule_decrease.scale_action.type
        value     = local.cpu_rule_decrease.scale_action.value
      }
    }

    # Memory - increase
    dynamic "rule" {
      for_each = var.scale_metrics.memory == null ? [] : [1]

      content {
        metric_trigger {
          metric_name              = local.memory_rule_increase.metric_trigger.metric_name
          metric_resource_id       = local.memory_rule_increase.metric_trigger.metric_resource_id
          metric_namespace         = local.memory_rule_increase.metric_trigger.metric_namespace
          time_grain               = local.memory_rule_increase.metric_trigger.time_grain
          statistic                = local.memory_rule_increase.metric_trigger.statistic
          time_window              = local.memory_rule_increase.metric_trigger.time_window
          time_aggregation         = local.memory_rule_increase.metric_trigger.time_aggregation
          operator                 = local.memory_rule_increase.metric_trigger.operator
          threshold                = local.memory_rule_increase.metric_trigger.threshold
          divide_by_instance_count = local.memory_rule_increase.metric_trigger.divide_by_instance_count
        }

        scale_action {
          cooldown  = local.memory_rule_increase.scale_action.cooldown
          direction = local.memory_rule_increase.scale_action.direction
          type      = local.memory_rule_increase.scale_action.type
          value     = local.memory_rule_increase.scale_action.value
        }
      }
    }

    # Memory - decrease
    dynamic "rule" {
      for_each = var.scale_metrics.memory == null ? [] : [1]

      content {
        metric_trigger {
          metric_name              = local.memory_rule_decrease.metric_trigger.metric_name
          metric_resource_id       = local.memory_rule_decrease.metric_trigger.metric_resource_id
          metric_namespace         = local.memory_rule_decrease.metric_trigger.metric_namespace
          time_grain               = local.memory_rule_decrease.metric_trigger.time_grain
          statistic                = local.memory_rule_decrease.metric_trigger.statistic
          time_window              = local.memory_rule_decrease.metric_trigger.time_window
          time_aggregation         = local.memory_rule_decrease.metric_trigger.time_aggregation
          operator                 = local.memory_rule_decrease.metric_trigger.operator
          threshold                = local.memory_rule_decrease.metric_trigger.threshold
          divide_by_instance_count = local.memory_rule_decrease.metric_trigger.divide_by_instance_count
        }

        scale_action {
          cooldown  = local.memory_rule_decrease.scale_action.cooldown
          direction = local.memory_rule_decrease.scale_action.direction
          type      = local.memory_rule_decrease.scale_action.type
          value     = local.memory_rule_decrease.scale_action.value
        }
      }
    }
  }

  tags = var.tags
}
