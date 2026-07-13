
resource "azurerm_resource_group" "rg" {
  name     = "rg-python-app"
  location = "East US"
}

resource "azurerm_container_registry" "acr" {
  name                = "acrpythonreg001" # Must be globally unique
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-python-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "PerGB2018"
}

resource "azurerm_container_app_environment" "env" {
  name                       = "ca-env-python"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
}

