data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_rg
}

data "azurerm_route_table" "rt" {
  name                = "rt-${var.project_acronym}-${var.subscription_env}"
  resource_group_name = var.vnet_rg
}
