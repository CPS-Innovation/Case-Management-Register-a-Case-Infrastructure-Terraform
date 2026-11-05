resource "azurerm_role_assignment" "ado_service_principal" {
  for_each = tomap({
    for item in local.ado_sp_roles_list : "${item.key}.${item.role_definition}" => item
  })

  scope                = each.value.scope
  role_definition_name = each.value.role_definition
  principal_id         = data.azuread_service_principal.ado.object_id
}

locals {
  ado_sp_roles = {
    sa = {
      scope = module.fa_sa.account_id
      role_definitions = [
        "Storage Blob Data Contributor",
        "Storage Queue Data Contributor",
        "Storage Table Data Contributor"
      ]
    }
    kv = {
      scope            = module.kv.id
      role_definitions = ["Key Vault Secrets Officer"]
    }
  }

  ado_sp_roles_list = flatten([
    for key, value in local.ado_sp_roles : [
      for role_definition in value.role_definitions : {
        key             = key
        scope           = value.scope
        role_definition = role_definition
      }
    ]
  ])
}

# Temporary reporting service resources
resource "azurerm_role_assignment" "lcc_reporting_service" {
  for_each = {
    log = {
      scope           = module.ai.law_id
      role_definition = "Log Analytics Reader"
    }
    sa = {
      scope           = module.fa_sa.account_id
      role_definition = "Storage Blob Data Contributor"
    }
  }

  scope                = each.value.scope
  role_definition_name = each.value.role_definition
  principal_id         = data.azurerm_windows_function_app.lcc_reporting_service.identity[0].principal_id
}

resource "azurerm_role_assignment" "lcc_reporting_logic_app" {
  role_definition_name = "Storage Blob Data Reader"
  scope                = module.fa_sa.container_ids["${var.project_acronym}-reports-${var.environment}"]
  principal_id         = data.azurerm_logic_app_standard.lcc_reporting.identity[0].principal_id
}
