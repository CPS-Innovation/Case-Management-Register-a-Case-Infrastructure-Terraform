module "network" {
  source           = "../../../modules/network"
  project_acronym  = var.project_acronym
  subscription_env = var.subscription_env
  vnet_rg          = var.vnet_rg
  vnet_name        = var.vnet_name
  vnet_id          = data.azurerm_virtual_network.vnet.id
  create_nsg       = false
  nsg_id           = data.azurerm_network_security_group.nsg.id
  route_table_id   = data.azurerm_route_table.rt.id

  subnets = {
    "subnet-${var.project_acronym}-service-${var.environment}" = {
      address_prefixes   = ["10.7.164.128/27"]
      service_endpoints  = ["Microsoft.Storage", "Microsoft.KeyVault"]
      service_delegation = false
    }
    "subnet-${var.project_acronym}-linux-apps-${var.environment}" = {
      address_prefixes   = ["10.7.164.160/27"]
      service_endpoints  = ["Microsoft.Storage", "Microsoft.KeyVault"]
      service_delegation = true
    }
    "subnet-${var.project_acronym}-windows-apps-${var.environment}" = {
      address_prefixes   = ["10.7.164.192/27"]
      service_endpoints  = ["Microsoft.Storage", "Microsoft.KeyVault"]
      service_delegation = true
    }
  }
}
