locals {
  tags = {
    environment = var.environment
    project     = var.project_acronym
  }

  pe_subnet_id = data.azurerm_subnet.base["subnet-${var.project_acronym}-service-${var.environment}"].id
}
