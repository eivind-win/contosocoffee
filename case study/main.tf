# Define the Azure provider and required version

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create the resource group
resource "azurerm_resource_group" "contosocoffee" {
  name     = "contosocoffee"
  location = "eastus"

  tags = {
    environment = "dev"
  }
}

# Create the storage account
resource "azurerm_storage_account" "example" {
  name                     = "coffeshop12345"
  resource_group_name      = azurerm_resource_group.contosocoffee.name
  location                 = azurerm_resource_group.contosocoffee.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }

}

resource "azurerm_container_registry" "coffeshop" {
  name                = "coffeshop"
  location            = "eastus"
  resource_group_name = "contosocoffee"
  sku                 = "Standard"
  admin_enabled       = true
}


