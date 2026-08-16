module "resource_group" {

  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_virtual_network"
  vnet       = var.vnet
}

module "subnet" {
  depends_on = [module.virtual_network, module.resource_group]
  source     = "../../modules/azurerm_subnet"
  snat       = var.snat
}

module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_public_ip"
  pip        = var.pip
}

module "network_interface_card" {
  depends_on = [module.subnet, module.public_ip]
  source     = "../../modules/azurerm_nic"
  nic        = var.nic
}

module "key_vault" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_key_vault"
  kv         = var.kv
  secrets    = var.secrets
}

module "linux-vm" {
  depends_on = [module.network_interface_card, module.key_vault]
  source     = "../../modules/azurerm_vm"
  vm         = var.vm
}