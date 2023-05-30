// Role assignments according to case dicription 

resource "azurerm_role_assignment" "mark_role_assignment" {
  scope                = "/subscriptions/4fcc9fd5-4152-4dee-bda1-31f47b3e46e3/resourceGroups/contosocoffee"
  role_definition_name = "Reader"
  principal_id         = azuread_user.mark.object_id
}

resource "azurerm_role_assignment" "dave_role_assignment" {
  scope                = "/subscriptions/4fcc9fd5-4152-4dee-bda1-31f47b3e46e3/resourceGroups/contosocoffee"
  role_definition_name = "Contributor"
  principal_id         = azuread_user.dave.object_id
}

/*resource "azurerm_role_assignment" "bob_global_admin_role_assignment" {
  scope                = "/subscriptions/4fcc9fd5-4152-4dee-bda1-31f47b3e46e3"
  role_definition_name = "Global Administrator"
  principal_id         = azuread_user.bob.object_id
}*/

resource "azurerm_role_assignment" "bob_owner_role_assignment" {
  scope                = "/subscriptions/4fcc9fd5-4152-4dee-bda1-31f47b3e46e3"
  role_definition_name = "Owner"
  principal_id         = azuread_user.bob.object_id
}

