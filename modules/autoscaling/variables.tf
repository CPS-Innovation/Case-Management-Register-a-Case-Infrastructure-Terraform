variable "tags" {
  type        = map(string)
  description = "A map of tag names to values."
}

variable "rg_name" {
  type        = string
  description = "The name of the resource group in which to create the resource."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "asp_name" {
  type        = string
  description = "The name of the target App Service Plan."
}

variable "asp_id" {
  type        = string
  description = "The resource id of the target App Service Plan."
}

variable "default_capacity" {
  type = object({
    default = number
    minimum = number
    maximum = number
  })

  description = "The capacity settings for the default autoscale profile"
}

variable "target_service_ids" {
  type        = list(string)
  description = "The resource IDs of the target services to autoscale. You can specify multiple app services and/or function apps that share the same plan."

  validation {
    condition = alltrue([
      for id in var.target_service_ids :
      can(regex(
        "^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/[^/]+(?:/[^/]+)+$",
        id
      ))
    ])

    error_message = "Each element in target_service_ids must be a valid Azure resource ID."
  }

  default = []
}

variable "scale_metrics" {
  type = object({
    requests = optional(object({
      upper_threshold           = number
      lower_threshold           = number
      increase_by               = number
      decrease_by               = number
      cooldown_increase         = optional(number, 1)
      cooldown_decrease         = optional(number, 10)
      statistic_increase        = optional(string, "Average")
      statistic_decrease        = optional(string, "Average")
      time_aggregation_increase = optional(string, "Average")
      time_aggregation_decrease = optional(string, "Average")
      time_window_increase      = optional(number, 1)
      time_window_decrease      = optional(number, 1)
    }), null)
    cpu = optional(object({
      upper_threshold           = optional(number, 80)
      lower_threshold           = optional(number, 20)
      increase_by               = optional(number, 1)
      decrease_by               = optional(number, 1)
      cooldown_increase         = optional(number, 1)
      cooldown_decrease         = optional(number, 20)
      statistic_increase        = optional(string, "Average")
      statistic_decrease        = optional(string, "Average")
      time_aggregation_increase = optional(string, "Average")
      time_aggregation_decrease = optional(string, "Average")
      time_window_increase      = optional(number, 5)
      time_window_decrease      = optional(number, 5)
    }), {})
    memory = optional(object({
      upper_threshold           = optional(number, 70)
      lower_threshold           = optional(number, 20)
      increase_by               = optional(number, 1)
      decrease_by               = optional(number, 1)
      cooldown_increase         = optional(number, 1)
      cooldown_decrease         = optional(number, 5)
      statistic_increase        = optional(string, "Average")
      statistic_decrease        = optional(string, "Average")
      time_aggregation_increase = optional(string, "Average")
      time_aggregation_decrease = optional(string, "Average")
      time_window_increase      = optional(number, 5)
      time_window_decrease      = optional(number, 5)
    }), null)
  })

  description = "Set the metrics to monitor. CPU is mandatory, Memory and Requests are not. Each attribute has a default value that can be overridden"

  default = {
    requests = null
    cpu = {
      upper_threshold           = 80
      lower_threshold           = 20
      increase_by               = 1
      decrease_by               = 1
      cooldown_increase         = 1
      cooldown_decrease         = 20
      statistic_increase        = "Average"
      statistic_decrease        = "Average"
      time_aggregation_increase = "Average"
      time_aggregation_decrease = "Average"
      time_window_increase      = 5
      time_window_decrease      = 5
    }
    memory = null
  }

  validation {
    condition     = var.scale_metrics.cpu != null
    error_message = "CPU metrics can't be null"
  }

  validation {
    condition = alltrue([
      # Statistic
      can(var.scale_metrics.requests.statistic_increase) ? contains(["Average", "Max", "Min", "Sum"], var.scale_metrics.requests.statistic_increase) : true,
      can(var.scale_metrics.requests.statistic_decrease) ? contains(["Average", "Max", "Min", "Sum"], var.scale_metrics.requests.statistic_decrease) : true,
      contains(["Average", "Max", "Min", "Sum"], var.scale_metrics.cpu.statistic_increase),
      contains(["Average", "Max", "Min", "Sum"], var.scale_metrics.cpu.statistic_decrease),
      can(var.scale_metrics.memory.statistic_increase) ? contains(["Average", "Max", "Min", "Sum"], var.scale_metrics.memory.statistic_increase) : true,
      can(var.scale_metrics.memory.statistic_decrease) ? contains(["Average", "Max", "Min", "Sum"], var.scale_metrics.memory.statistic_decrease) : true,
    ])
    error_message = "Each Statistic metric trigger must be one of the following values: Average, Max, Min, or Sum."
  }

  validation {
    condition = alltrue([
      can(var.scale_metrics.requests.time_aggregation_increase) ? contains(["Average", "Count", "Maximum", "Minimum", "Last", "Total"], var.scale_metrics.requests.time_aggregation_increase) : true,
      can(var.scale_metrics.requests.time_aggregation_decrease) ? contains(["Average", "Count", "Maximum", "Minimum", "Last", "Total"], var.scale_metrics.requests.time_aggregation_decrease) : true,
      contains(["Average", "Count", "Maximum", "Minimum", "Last", "Total"], var.scale_metrics.cpu.time_aggregation_increase),
      contains(["Average", "Count", "Maximum", "Minimum", "Last", "Total"], var.scale_metrics.cpu.time_aggregation_decrease),
      can(var.scale_metrics.memory.time_aggregation_increase) ? contains(["Average", "Count", "Maximum", "Minimum", "Last", "Total"], var.scale_metrics.memory.time_aggregation_increase) : true,
      can(var.scale_metrics.memory.time_aggregation_decrease) ? contains(["Average", "Count", "Maximum", "Minimum", "Last", "Total"], var.scale_metrics.memory.time_aggregation_decrease) : true,
    ])
    error_message = "Each Time aggregation metric trigger must be one of the following values: Average, Count, Maximum, Minimum, Last or Total."
  }
}
