# Before the following resources can be deployed, the following must be obtained:
# 1. The app certificate itself must be created manually, to avoid accidental deletion.
# 2. To enable domain verification, an ASUID public TXT record must be added to CPS DNS.

resource "azurerm_app_service_custom_hostname_binding" "hostname" {
  hostname            = "${var.hostname}.cps.gov.uk"
  app_service_name    = var.app_service_name
  resource_group_name = var.rg_name

  lifecycle {
    ignore_changes = [ssl_state, thumbprint]
  }
}

resource "azurerm_app_service_certificate_binding" "hostname" {
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.hostname.id
  certificate_id      = var.certificate_id
  ssl_state           = "SniEnabled"
}
