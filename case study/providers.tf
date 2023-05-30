# Define the Azure provider and required version

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.58.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.39.0"
    }

  }
}

provider "azurerm" {
  features {}
}
provider "azuread" {

}