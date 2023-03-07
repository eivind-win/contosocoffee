provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "contosocoffee" # Resource group name
  location = "West US" # Azure region for the resource group
}

# Create a storage account with Blob storage
resource "azurerm_storage_account" "example" {
  name                     = "contoso" # Storage account name
  resource_group_name      = azurerm_resource_group.example.name # Resource group name
  location                 = azurerm_resource_group.example.location # Azure region
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Add a lifecycle management rule to move objects to the Archive tier after 30 days
  lifecycle {
    # Define the rule to move objects to the Archive tier after 30 days
    rule {
      name                   = "ArchiveRule"
      enabled                = true
      type                   = "Lifecycle"
      prefix_match           = ["blob/"] # Specify a prefix for the objects to apply the rule to
      days_after_modification_greater_than = 30 # Move objects to Archive tier after 30 days of modification
      action {
        type = "TierToArchive" # Move the objects to the Archive tier
      }
    }
  }

  # Enable blob storage
  is_blob_storage = true
}

# Create container groups for London and New York
resource "azurerm_container_group" "london" {
  name                = "web-london" # Container group name for London
  location            = "uksouth" # Azure region for London
  resource_group_name = azurerm_resource_group.example.name # Resource group name for London

  # Define the container settings for London
  container {
    name   = "web"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld"
    cpu    = 0.5
    memory = 1.5

    port {
      protocol = "TCP"
      port     = 80
    }
  }
}

resource "azurerm_container_group" "newyork" {
  name                = "web-newyork" # Container group name for New York
  location            = "eastus" # Azure region for New York
  resource_group_name = azurerm_resource_group.example.name # Resource group name for New York

  # Define the container settings for New York
  container {
    name   = "web"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld"
    cpu    = 0.5
    memory = 1.5

    port {
      protocol = "TCP"
      port     = 80
    }
  }
}

# Create an Azure Traffic Manager profile to load balance the two container groups
resource "azurerm_traffic_manager_profile" "example" {
  name                = "contosocoffee-tm" # Traffic Manager profile name
  resource_group_name = azurerm_resource_group.example.name # Resource group name for the profile

  traffic_routing_method = "Geographic" # Set to "Geographic" for geo-load balancing

  # Endpoint health check settings
  monitor_path      = "/"
  monitor_port      = 80
  monitor_protocol  = "http"
  monitor_interval  = 30
  monitor_timeout   = 10

  # DNS settings
  dns_config {
    relative_name = "contosoc
