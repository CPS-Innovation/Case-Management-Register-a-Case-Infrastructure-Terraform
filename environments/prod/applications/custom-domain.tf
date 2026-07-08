data "azurerm_app_service_certificate" "cert" {
  # purchased and added manually to the app service instances
  for_each = toset(["ui", "api"])

  name                = "cert-${var.project_acronym}-${each.value}-${var.environment}"
  resource_group_name = module.rg.rg_name
}

module "ui_hostname" {
  source = "../../../modules/custom-domain"

  rg_name          = module.rg.rg_name
  hostname         = "register-a-case"
  app_service_name = module.ui_spa.app_name
  certificate_id   = data.azurerm_app_service_certificate.cert["ui"].id
}

module "api_hostname" {
  source = "../../../modules/custom-domain"

  rg_name          = module.rg.rg_name
  hostname         = "register-a-case-api"
  app_service_name = module.fa_main.fa_name
  certificate_id   = data.azurerm_app_service_certificate.cert["api"].id
}
