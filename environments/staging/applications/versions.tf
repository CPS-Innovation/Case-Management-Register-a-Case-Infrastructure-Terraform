terraform {
  required_version = "=1.11.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.44.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.8.0"
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
