rgs = {

  rg1 = {
    name     = "kapil1"
    location = "Australia Central"
  }
  rg2 = {
    name     = "kapil2"
    location = "Australia Central"
  }
}

vnet = {
  vnet1 = {
    name                = "kapil-vnet"
    location            = "Australia Central"
    address_space       = ["10.0.0.0/16"]
    resource_group_name = "kapil1"
  }
}

snat = {
  snat1 = {
    name                 = "kapil-subnet1"
    virtual_network_name = "kapil-vnet"
    address_prefixes     = ["10.0.0.0/24"]
    resource_group_name  = "kapil1"
  }
  snat2 = {
    name                 = "kapil-subnet2"
    virtual_network_name = "kapil-vnet"
    address_prefixes     = ["10.0.1.0/24"]
    resource_group_name  = "kapil1"
  }
}

pip = {
  pip1 = {
    name                = "kapil-pip"
    location            = "Australia Central"
    allocation_method   = "Static"
    resource_group_name = "kapil1"
  }
}

nic = {
  nic1 = {

    subnet-name         = "kapil-subnet1"
    vnet-name           = "kapil-vnet"
    resource_group_name = "kapil1"
    pip-name            = "kapil-pip"
    nic-name            = "kapil-nic"
    location            = "Australia Central"
  }
}

vm = {
  vm1 = {
    nic-name                        = "kapil-nic"
    resource_group_name             = "kapil1"
    vm-name                         = "kapil-linux-vm"
    location                        = "Australia Central"
    vm-size                         = "Standard_B2s"
    keyvault_name                   = "kapil-kv"
    keyvault_rg                     = "kapil1"
    username_secret_name            = "admin-username"
    password_secret_name            = "admin-password"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"

    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

kv = {
  kv1 = {
    name                = "kapil-kv"
    location            = "Australia Central"
    resource_group_name = "kapil1"
    sku_name            = "standard"
  }
}

secrets = {
  sec1 = {
    name   = "admin-username"
    value  = "azureuser"
    kv_key = "kv1"
  }
  sec2 = {
    name   = "admin-password"
    value  = "AzureP@ssw0rd123!"
    kv_key = "kv1"
  }
}