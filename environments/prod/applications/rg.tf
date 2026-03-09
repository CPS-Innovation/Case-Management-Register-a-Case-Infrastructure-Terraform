module "rg" {
  source = "../../../modules/resource-group"

  environment     = var.environment
  project_acronym = var.project_acronym
  location        = var.location
  tags            = local.tags
}
