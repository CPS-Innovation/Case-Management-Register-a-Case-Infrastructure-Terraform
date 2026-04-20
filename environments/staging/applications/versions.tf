terraform {
  required_version = "1.14.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.44.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=3.6.0"
    }
  }
}

provider "azuread" {}

provider "azurerm" {
  features {}
  storage_use_azuread = true
}

provider "azurerm" {
  alias = "siem-prod"
  features {}
  subscription_id                 = var.siem_evh_subscription_id
  resource_provider_registrations = "none"
}
