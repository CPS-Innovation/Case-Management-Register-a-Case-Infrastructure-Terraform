module "ag_api_alerts" {
  source = "../../../modules/action-group"

  environment     = var.environment
  project_acronym = var.project_acronym
  tags            = local.tags
  rg_name         = module.rg.rg_name

  function   = "api"
  short_name = "${var.project_acronym}-api"

  email_receivers = {
    EmailDevTeam = {
      email                   = var.dev_team_email
      use_common_alert_schema = false
    }
  }
}
