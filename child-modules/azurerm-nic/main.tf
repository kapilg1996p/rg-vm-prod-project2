data "azurerm_subnet" "snat" {
  for_each             = var.nic
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "PIP-id" {
  for_each            = var.nic
  name                = each.value.public-ip-name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.nic
  name                = each.value.nic-name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  ip_configuration {
    name                          = "Internal"
    subnet_id                     = data.azurerm_subnet.snat[each.key].id
    public_ip_address_id          = data.azurerm_public_ip.PIP-id[each.key].id
    private_ip_address_allocation = "Dynamic"
  }

}