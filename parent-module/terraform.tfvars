
rgs = {
  rg1 = {
    name     = "rjni"
    location = "Central India"
  }
  rg2 = {
    name     = "suraj"
    location = "Central India"
  }

 rg3 = {
    name     = "kapil"
    location = "Central India"
  }
}


vnet = {
  vnet1 = {
    name                = "linux-vnet"
    location            = "Central India"
    address_space       = ["10.0.0.0/16"]
    resource_group_name = "rjni"
  }
}

snat = {
  snat1 = {
    name                 = "linux-subnet"
    virtual_network_name = "linux-vnet"
    address_prefixes     = ["10.0.1.0/24"]
    resource_group_name  = "rjni"
  }
}

pip = {
  pip1 = {
    public-ip-name       = "linux-pip"
    public-ip-location   = "Central India"
    public-ip-allocation = "Static"
    resource_group_name  = "rjni"
  }
}

nic = {
  nic1 = {
    subnet_name         = "linux-subnet"
    public-ip-name      = "linux-pip"
    resource_group_name = "rjni"
    location            = "Central India"
    vnet_name           = "linux-vnet"
 nic-name            = "linux-nic"
}
  }


vms = {
  vm1 = {

    vm_name             = "Kapil-VM"
    vm_location         = "Central India"
    resource_group_name = "rjni"
    vm_size             = "Standard_B2s_v2"
    nic_name            = "linux-nic"

    admin_username = "azureuser"
    admin_password = "Kapil@12345"

    publisher    = "Canonical"
    offer        = "0001-com-ubuntu-server-jammy"
    sku          = "22_04-lts"
    version      = "latest"
    os_disk_name = "linux_os_disk"
    os_disk_sku  = "Standard_LRS"
  }
}