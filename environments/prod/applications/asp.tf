module "asp_linux" {
  source = "../../../modules/app-service-plan"

  environment     = var.environment
  project_acronym = var.project_acronym
  location        = var.location
  tags            = local.tags
  rg_name         = module.rg.rg_name
  functional_area = "linux"

  os_type                = "linux"
  sku                    = var.asp_linux_sku
  worker_count           = var.asp_linux_worker_count
  zone_balancing_enabled = false
  auto_scale_enabled     = startswith(var.asp_linux_sku, "P") ? var.asp_auto_scale_enabled : null
}

module "asp_linux_ui" {
  source = "../../../modules/app-service-plan"

  environment     = var.environment
  project_acronym = var.project_acronym
  location        = var.location
  tags            = local.tags
  rg_name         = module.rg_ui.rg_name
  functional_area = "ui"

  os_type                = "linux"
  sku                    = var.asp_linux_sku
  worker_count           = var.asp_linux_worker_count
  zone_balancing_enabled = startswith(var.asp_linux_sku, "B") ? false : var.asp_zone_balancing_enabled
  auto_scale_enabled     = startswith(var.asp_linux_sku, "P") ? var.asp_auto_scale_enabled : null
}

module "asp_windows" {
  source = "../../../modules/app-service-plan"

  environment     = var.environment
  project_acronym = var.project_acronym
  location        = var.location
  tags            = local.tags
  rg_name         = module.rg.rg_name
  functional_area = "windows"

  os_type                = "windows"
  sku                    = var.asp_windows_sku
  worker_count           = var.asp_windows_worker_count
  zone_balancing_enabled = startswith(var.asp_linux_sku, "B") ? false : var.asp_zone_balancing_enabled
}
