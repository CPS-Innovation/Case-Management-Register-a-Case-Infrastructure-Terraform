module "fa_sa" {
  source = "../../../modules/storage-account"

  environment     = var.environment
  project_acronym = var.project_acronym
  location        = var.location
  tags            = local.tags
  rg_name         = module.rg.rg_name
  functional_area = "api"

  pe_subnet_id = local.pe_subnet_id
  private_endpoints = {
    blob = data.azurerm_private_dns_zone.dns["blob"].id
  }
}
