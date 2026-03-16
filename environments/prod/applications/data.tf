data "azurerm_client_config" "current" {}

# The Enterprise App (service principal) used to deploy code to the resources in the environment
data "azuread_service_principal" "ado" {
  display_name = var.aad_sp_name
}

data "azurerm_private_dns_zone" "dns" {
  for_each = {
    blob  = "privatelink.blob.core.windows.net"
    sites = "privatelink.azurewebsites.net"
    vault = "privatelink.vaultcore.azure.net"
  }

  name                = each.value
  resource_group_name = var.vnet_rg
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_rg
}

# All subnets of the vnet above.
# To reference a specific subnet use data.azurerm_subnet.base["<subnet-name>"].id
data "azurerm_subnet" "base" {
  for_each = toset(data.azurerm_virtual_network.vnet.subnets)

  name                 = each.value
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg
}
