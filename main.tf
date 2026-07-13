terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "python-app-rg"
  location = "East US"
}

resource "azurerm_container_registry" "acr" {
  name                = "pythondockerregistry2026111" # Must be globally unique
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false # Disabled for security; we will use the Service Principal instead
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
