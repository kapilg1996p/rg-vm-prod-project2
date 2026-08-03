data "azurerm_network_interface" "nic" {
  for_each = var.vms

  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_linux_virtual_machine" "vm" {

  for_each = var.vms

  name                = each.value.vm_name
  location            = each.value.vm_location
  resource_group_name = each.value.resource_group_name
  size                = each.value.vm_size


  network_interface_ids = [
    data.azurerm_network_interface.nic[each.key].id
  ]


  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false


  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }


  os_disk {
    name                 = each.value.os_disk_name
    caching              = "ReadWrite"
    storage_account_type = each.value.os_disk_sku
  }
}