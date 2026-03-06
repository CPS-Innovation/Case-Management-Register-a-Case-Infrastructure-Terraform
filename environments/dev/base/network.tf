module "network" {
  source           = "../../../modules/network"
  project_acronym  = var.project_acronym
  subscription_env = var.subscription_env
  vnet_rg          = var.vnet_rg
  vnet_name        = var.vnet_name
  vnet_id          = data.azurerm_virtual_network.vnet.id
  create_nsg       = true
  location         = "UKSouth"
  route_table_id   = data.azurerm_route_table.rt.id

  private_dns_zones = {
    sites = "privatelink.azurewebsites.net"
    vault = "privatelink.vaultcore.azure.net"
  }

  subnets = {
    "subnet-${var.project_acronym}-service-${var.environment}" = {
      address_prefixes   = ["10.7.164.32/27"]
      service_endpoints  = ["Microsoft.Storage", "Microsoft.KeyVault"]
      service_delegation = false
    }
    "subnet-${var.project_acronym}-linux-apps-${var.environment}" = {
      address_prefixes   = ["10.7.164.64/27"]
      service_endpoints  = ["Microsoft.Storage", "Microsoft.KeyVault"]
      service_delegation = true
    }
    "subnet-${var.project_acronym}-windows-apps-${var.environment}" = {
      address_prefixes   = ["10.7.164.96/27"]
      service_endpoints  = ["Microsoft.Storage", "Microsoft.KeyVault"]
      service_delegation = true
    }
  }

  nsg_rules = {
    AllowAmzWorkspcCustom443Inbound = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefixes    = ["10.7.152.0/23", "10.7.150.0/23"]
      destination_address_prefix = "*"
    }
  }

  tags = {
    environment = var.subscription_env
    project     = var.project_acronym
  }
}
