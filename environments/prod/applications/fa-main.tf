module "fa_main" {
  source = "../../../modules/windows-fa"

  environment     = var.environment
  project_acronym = var.project_acronym
  location        = var.location
  tags            = local.tags
  rg_name         = module.rg.rg_name

  create_slot = true
  slot_name   = "stg"

  asp_id               = module.asp_windows.id
  functional_area      = "api"
  vnet_subnet_id       = data.azurerm_subnet.base["subnet-${var.project_acronym}-windows-apps-${var.environment}"].id
  ai_connection_string = module.ai.ai_connection_string
  always_on            = true

  sa_name = module.fa_sa.name
  sa_id   = module.fa_sa.id
  sa_iam_roles = [
    "Storage Blob Data Owner",
    "Storage Table Data Contributor"
  ]

  kv_id = module.kv.id

  cors_allowed_origins = [
    "https://${module.ui_spa.default_hostname}",
    "https://login.microsoftonline.com"
  ]

  pe_subnet_id         = local.pe_subnet_id
  private_dns_zone_ids = [data.azurerm_private_dns_zone.dns["sites"].id]

  health_check_path               = "/api/status"
  health_check_eviction_time_mins = 10
}
