module "kv" {
  source = "../../../modules/key-vault"

  environment     = var.environment
  project_acronym = var.project_acronym
  location        = var.location
  tags            = local.tags
  rg_name         = module.rg.rg_name
  functional_area = "-api"

  tenant_id = data.azurerm_client_config.current.tenant_id

  pe_subnet_id         = local.pe_subnet_id
  private_dns_zone_ids = [data.azurerm_private_dns_zone.dns["vault"].id]
}
