variable "eventhub_name" {
  type        = string
  description = "The name of the event hub to which logs are exported."
}

variable "authorization_rule_id" {
  type        = string
  description = "The ID of the event hub namespace's authorization rule."
}

variable "app_insights_id" {
  type        = string
  description = "Resource ID of the app insights instance from which logs are exported to the event hub."
}

variable "app_insights_logs" {
  type        = list(string)
  description = "A list of app insights log types to export to the event hub."
  default     = ["AppEvents", "AppExceptions", "AppPageViews", "AppRequests", "AppSystemEvents", "AppTraces"]
}

variable "subscription_id" {
  type        = string
  description = "GUID of the current Azure Subscription."
}

variable "subscription_logs" {
  type        = list(string)
  description = "A list of subscription activity log types to export to the event hub."
  default     = ["Administrative", "Policy"]
}
