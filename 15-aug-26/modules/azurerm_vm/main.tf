data "azurerm_network_interface" "nic" {
  for_each            = var.vm
  name                = each.value.nic-name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault" "kv" {
  for_each            = var.vm
  name                = each.value.keyvault_name
  resource_group_name = each.value.keyvault_rg
}

data "azurerm_key_vault_secret" "admin_username" {
  for_each     = var.vm
  name         = each.value.username_secret_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_key_vault_secret" "admin_password" {
  for_each     = var.vm
  name         = each.value.password_secret_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vm
  name                            = each.value.vm-name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.vm-size
  admin_username                  = data.azurerm_key_vault_secret.admin_username[each.key].value
  admin_password                  = data.azurerm_key_vault_secret.admin_password[each.key].value
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids = [
    data.azurerm_network_interface.nic[each.key].id
  ]
  os_disk {
    caching              = each.value.caching    
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer 
    sku       = each.value.sku   
    version   = each.value.version
  }
}