
module "resource_group" {

  source = "../child-modules/azurerm-resource-group"
  rgs    = var.rgs
}

module "virtual-netwok" {
  depends_on = [module.resource_group]
  source     = "../child-modules/azurerm-virtual-network"
  vnet       = var.vnet
}

module "subnet" {
  depends_on = [module.virtual-netwok]
  source     = "../child-modules/azurerm-subnet"
  snat       = var.snat
}
module "pip" {
  depends_on = [module.resource_group]
  source     = "../child-modules/azurerm-public-ip"
  pip        = var.pip
}

module "nic" {
  depends_on = [module.subnet, module.pip]
  source     = "../child-modules/azurerm-nic"
  nic        = var.nic

}

module "vm" {
  depends_on = [ module.nic ]
  source = "../child-modules/azurerm-linux-vm"
  vms = var.vms
}