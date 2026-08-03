
resource "azurerm_public_ip" "pip" {
  for_each            = var.pip
  name                = each.value.public-ip-name
  location            = each.value.public-ip-location
  allocation_method   = each.value.public-ip-allocation
  resource_group_name = each.value.resource_group_name
}