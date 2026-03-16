module "ui_spa" {
  source = "../../../modules/linux-app"

  environment     = var.environment
  project_acronym = var.project_acronym
  location        = var.location
  tags            = local.tags
  rg_name         = module.rg.rg_name

  create_slot = true
  slot_name   = "stg"

  asp_id               = module.asp_linux.id
  functional_area      = "ui-spa"
  vnet_subnet_id       = data.azurerm_subnet.base["subnet-${var.project_acronym}-linux-apps-${var.environment}"].id
  ai_connection_string = module.ai.ai_connection_string
  always_on            = true

  pe_subnet_id         = local.pe_subnet_id
  private_dns_zone_ids = [data.azurerm_private_dns_zone.dns["sites"].id]
}
