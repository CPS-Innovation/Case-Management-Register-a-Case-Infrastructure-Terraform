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
      scope = module.fa_sa.id
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
