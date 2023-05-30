resource "azuread_user" "bob" {
  user_principal_name = "bob@testeivind.onmicrosoft.com"
  display_name       = "Bob"
  password           = "gFwRfE5hv2"

  lifecycle {
    ignore_changes = [
      password
    ]
  }
}

resource "azuread_user" "dave" {
  user_principal_name = "dave@testeivind.onmicrosoft.com"
  display_name       = "Dave"
  password           = "gFwRfE5hv2"

  lifecycle {
    ignore_changes = [
      password
    ]
}
}

resource "azuread_user" "mark" {
  user_principal_name = "mark@testeivind.onmicrosoft.com"
  display_name       = "Mark"
  password           = "gFwRfE5hv2"

  lifecycle {
    ignore_changes = [
      password
    ]
}
}