
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

resource "azurerm_user_assigned_identity" "example" {
  location            = azurerm_resource_group.contosocoffee.location
  name                = "contosocoffmi"
  resource_group_name = azurerm_resource_group.contosocoffee.name
}

#create a container registry

resource "azurerm_role_assignment" "roleassignmentforidentity" {
  scope                = azurerm_container_registry.coffeshop.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.example.principal_id
}

resource "azurerm_container_registry" "coffeshop" {
  name                = "coffeshop"
  location            = "eastus"
  resource_group_name = "contosocoffee"
  sku                 = "Standard"
  admin_enabled       = true
}


resource "azurerm_container_group" "example-london" {
  name                = "example-container-group-london"
  location            = "North Europe"
  resource_group_name = azurerm_resource_group.contosocoffee.name
  ip_address_type     = "Public"
  dns_name_label      = "example-dns-london"
  os_type             = "Linux"


  image_registry_credential {
    user_assigned_identity_id = azurerm_user_assigned_identity.example.id
    server                    = azurerm_container_registry.coffeshop.login_server
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }
  container {

    image  = "${azurerm_container_registry.coffeshop.login_server}/coffee-app:latest"
    cpu    = "1.0"
    memory = "1.5"
    name   = "coffe-app"


    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}

resource "azurerm_container_group" "example-new-york" {
  name                = "example-container-group-new-york"
  location            = "East US"
  resource_group_name = azurerm_resource_group.contosocoffee.name
  ip_address_type     = "Public"
  dns_name_label      = "example-dns-new-york"
  os_type             = "Linux"

  image_registry_credential {
    user_assigned_identity_id = azurerm_user_assigned_identity.example.id
    server                    = azurerm_container_registry.coffeshop.login_server
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }
  container {

    image  = "${azurerm_container_registry.coffeshop.login_server}/coffee-app:latest"
    cpu    = "1.0"
    memory = "1.5"
    name   = "coffe-app"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}

# Traffic manager profile
resource "azurerm_traffic_manager_profile" "example" {
  name                   = "contosocoffee"
  resource_group_name    = azurerm_resource_group.contosocoffee.name
  traffic_routing_method = "Performance"

  dns_config {
    relative_name = "coffeeshop"
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = {
    environment = "Production"
  }
}
# creating endpoint located in UK London
resource "azurerm_traffic_manager_external_endpoint" "endpoint1" {
  name              = "london"
  profile_id        = azurerm_traffic_manager_profile.example.id
  target            = azurerm_container_group.example-london.fqdn
  endpoint_location = azurerm_container_group.example-london.location


}
# creating endpoint located in US New york
resource "azurerm_traffic_manager_external_endpoint" "endpoint2" {
  name              = "new-york"
  profile_id        = azurerm_traffic_manager_profile.example.id
  target            = azurerm_container_group.example-new-york.fqdn
  endpoint_location = azurerm_container_group.example-new-york.location

}