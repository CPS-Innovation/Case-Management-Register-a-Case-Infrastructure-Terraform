module "log-to-siem" {
  source                = "../../../modules/logs-to-eventhub"
  eventhub_name         = "eh-siem-01"
  authorization_rule_id = data.azurerm_eventhub_namespace_authorization_rule.evhns_siem.id
  app_insights_id       = module.ai.ai_id
  subscription_id       = data.azurerm_client_config.current.subscription_id
}

data "azurerm_eventhub_namespace_authorization_rule" "evhns_siem" {
  provider            = azurerm.siem-prod
  name                = "eh-siem-sap-01"
  namespace_name      = "ns-siem-eventhub"
  resource_group_name = "rg-siem-eventhub"
}
