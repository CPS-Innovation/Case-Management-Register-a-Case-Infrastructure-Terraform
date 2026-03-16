module "asp_linux" {
  source = "../../../modules/app-service-plan"

  environment     = var.environment
  project_acronym = var.project_acronym
  location        = var.location
  tags            = local.tags
  rg_name         = module.rg.rg_name

  os_type = "linux"
  sku     = var.asp_linux_sku
}

module "asp_windows" {
  source = "../../../modules/app-service-plan"

  environment     = var.environment
  project_acronym = var.project_acronym
  location        = var.location
  tags            = local.tags
  rg_name         = module.rg.rg_name

  os_type = "windows"
  sku     = var.asp_windows_sku
}
