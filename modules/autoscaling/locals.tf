locals {
  # Definition of request rules for each service
  requests_rules_increase = flatten([
    for id in var.target_service_ids : {
      metric_trigger = {
        metric_name              = "Requests"
        metric_resource_id       = id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = try(var.scale_metrics.requests.statistic_increase, "Average")
        time_window              = try("PT${var.scale_metrics.requests.time_window_increase}M", "PT1M")
        time_aggregation         = try(var.scale_metrics.requests.time_aggregation_increase, "Average")
        operator                 = "GreaterThan"
        threshold                = try(var.scale_metrics.requests.upper_threshold, null)
        divide_by_instance_count = true
      }

      scale_action = {
        direction = "Increase"
        type      = "ChangeCount"
        value     = try(var.scale_metrics.requests.increase_by, null)
        cooldown  = try("PT${var.scale_metrics.requests.cooldown_increase}M", "PT1M")
      }
    }
  ])

  requests_rules_decrease = flatten([
    for id in var.target_service_ids : {
      metric_trigger = {
        metric_name              = "Requests"
        metric_resource_id       = id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = try(var.scale_metrics.requests.statistic_decrease, "Average")
        time_window              = try("PT${var.scale_metrics.requests.time_window_decrease}M", "PT1M")
        time_aggregation         = try(var.scale_metrics.requests.time_aggregation_decrease, "Average")
        operator                 = "LessThan"
        threshold                = try(var.scale_metrics.requests.lower_threshold, null)
        divide_by_instance_count = true
      }

      scale_action = {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = try(var.scale_metrics.requests.decrease_by, null)
        cooldown  = try("PT${var.scale_metrics.requests.cooldown_decrease}M", "PT10M")
      }
    }
  ])

  # CPU rules - these are at the service plan level, so they don't change
  cpu_rule_increase = {
    metric_trigger = {
      metric_name              = "CpuPercentage"
      metric_resource_id       = var.asp_id
      metric_namespace         = "microsoft.web/serverfarms"
      time_grain               = "PT1M"
      statistic                = var.scale_metrics.cpu.statistic_increase
      time_window              = "PT${var.scale_metrics.cpu.time_window_increase}M"
      time_aggregation         = var.scale_metrics.cpu.time_aggregation_increase
      operator                 = "GreaterThan"
      threshold                = var.scale_metrics.cpu.upper_threshold
      divide_by_instance_count = false
    }

    scale_action = {
      direction = "Increase"
      type      = "ChangeCount"
      value     = var.scale_metrics.cpu.increase_by
      cooldown  = "PT${var.scale_metrics.cpu.cooldown_increase}M"
    }
  }

  cpu_rule_decrease = {
    metric_trigger = {
      metric_name              = "CpuPercentage"
      metric_resource_id       = var.asp_id
      metric_namespace         = "microsoft.web/serverfarms"
      time_grain               = "PT1M"
      statistic                = var.scale_metrics.cpu.statistic_decrease
      time_window              = "PT${var.scale_metrics.cpu.time_window_decrease}M"
      time_aggregation         = var.scale_metrics.cpu.time_aggregation_decrease
      operator                 = "LessThan"
      threshold                = var.scale_metrics.cpu.lower_threshold
      divide_by_instance_count = false
    }

    scale_action = {
      direction = "Decrease"
      type      = "ChangeCount"
      value     = var.scale_metrics.cpu.decrease_by
      cooldown  = "PT${var.scale_metrics.cpu.cooldown_decrease}M"
    }
  }

  # Memory rules - these are at the service plan level, so they don't change
  memory_rule_increase = {
    metric_trigger = {
      metric_name              = "MemoryPercentage"
      metric_resource_id       = var.asp_id
      metric_namespace         = "microsoft.web/serverfarms"
      time_grain               = "PT1M"
      statistic                = try(var.scale_metrics.memory.statistic_increase, "Average")
      time_window              = try("PT${var.scale_metrics.memory.time_window_increase}M", "PT1M")
      time_aggregation         = try(var.scale_metrics.memory.time_aggregation_increase, "Average")
      operator                 = "GreaterThan"
      threshold                = try(var.scale_metrics.memory.upper_threshold, null)
      divide_by_instance_count = false
    }

    scale_action = {
      direction = "Increase"
      type      = "ChangeCount"
      value     = try(var.scale_metrics.memory.increase_by, null)
      cooldown  = try("PT${var.scale_metrics.memory.cooldown_increase}M", "PT1M")
    }
  }

  memory_rule_decrease = {
    metric_trigger = {
      metric_name              = "MemoryPercentage"
      metric_resource_id       = var.asp_id
      metric_namespace         = "microsoft.web/serverfarms"
      time_grain               = "PT1M"
      statistic                = try(var.scale_metrics.memory.statistic_decrease, "Average")
      time_window              = try("PT${var.scale_metrics.memory.time_window_decrease}M", "PT1M")
      time_aggregation         = try(var.scale_metrics.memory.time_aggregation_decrease, "Average")
      operator                 = "LessThan"
      threshold                = try(var.scale_metrics.memory.lower_threshold, null)
      divide_by_instance_count = false
    }

    scale_action = {
      direction = "Decrease"
      type      = "ChangeCount"
      value     = try(var.scale_metrics.memory.decrease_by, null)
      cooldown  = try("PT${var.scale_metrics.memory.cooldown_decrease}M", "PT1M")
    }
  }
}
