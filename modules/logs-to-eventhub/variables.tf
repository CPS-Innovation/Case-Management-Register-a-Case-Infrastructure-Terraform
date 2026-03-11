variable "eventhub_name" {
  type        = string
  description = "The name of the event hub to which logs are streamed."
}

variable "authorization_rule_id" {
  type        = string
  description = "The ID of the event hub namespace's authorization rule."
}

variable "app_insights_id" {
  type        = string
  description = "Resource ID of the app insights instance from which logs are streamed to the event hub."
}

variable "app_insights_logs" {
  type        = list(string)
  description = "A list of app insights log types to stream to the event hub."
  default     = ["AppEvents", "AppExceptions", "AppPageViews", "AppRequests", "AppSystemEvents", "AppTraces"]
}

variable "subscription_id" {
  type        = string
  description = "GUID of the current Azure subscription."
}

variable "subscription_logs" {
  type        = list(string)
  description = "A list of subscription activity log types to stream to the event hub."
  default     = ["Administrative", "Policy"]
}
