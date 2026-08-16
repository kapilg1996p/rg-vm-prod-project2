data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  for_each            = var.kv
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku_name            = each.value.sku_name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "Set", "List", "Delete", "Purge"
    ]
  }
}

resource "azurerm_key_vault_secret" "secret" {
  for_each     = var.secrets
  name         = each.value.name
  value        = each.value.value
  key_vault_id = azurerm_key_vault.kv[each.value.kv_key].id
}
