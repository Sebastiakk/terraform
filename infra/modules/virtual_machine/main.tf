resource "random_password" "administrator_password" {
  length           = 10
  special          = true
  upper            = true
  lower            = true
  numeric          = true
  min_special      = 1
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  override_special = "!@#$%^&*()-_=+?"
}

locals {
  admin_username = "azureuser-${var.app_name}"
  admin_password = random_password.administrator_password.result
  disk_name      = "${var.vm_name}-${var.environment}-osdisk"
  vm_name        = "${var.vm_name}-${var.environment}-vm"
  vm_nic_name    = "${var.app_name}-${var.environment}-vm-nic"
}


resource "azurerm_network_interface" "vm_nic" {
  name                = local.vm_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                = local.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  vm_size             = var.vm_size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = local.disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = local.admin_username
    admin_password = local.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = var.environment
    app_name    = var.app_name
  }

  depends_on = [
    azurerm_network_interface.vm_nic
  ]
}
