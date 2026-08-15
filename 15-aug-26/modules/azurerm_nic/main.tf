data "azurerm_subnet" "subnet" {
  for_each = var.nic
  name = each.value.subnet-name
  virtual_network_name = each.value.vnet-name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_public_ip" "pip" {
  for_each = var.nic
  name = each.value.pip-name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_network_interface" "netwrok-card" {
    for_each = var.nic
  name                = each.value.nic-name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
  }