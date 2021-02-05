provider "azurerm" {
  version                    = ">=2.37.0"
  skip_provider_registration = "true"
  features {}
}

resource "azurerm_network_security_group" "stc_gui" {
  name                = "nsg-${var.instance_name}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 3389
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ssh"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = var.ingress_cidr_blocks
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "all-traffic"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = ["0.0.0.0/0"]
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "stc_gui" {
  count               = var.instance_count
  name                = "publicip-${var.instance_name}-${count.index}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "mgmt" {
  count                      = var.instance_count
  name                       = "nic-mgmt-${var.instance_name}-${count.index}"
  location                   = var.resource_group_location
  resource_group_name        = var.resource_group_name

  # dynamic IP configuration
  ip_configuration {
    name                          = "ipc-mgmt-${var.instance_name}-${count.index}"
    subnet_id                     = var.mgmt_plane_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.stc_gui.*.id, count.index)
  }
}

resource "azurerm_network_interface_security_group_association" "mgmt" {
  count                     = var.instance_count
  network_interface_id      = element(azurerm_network_interface.mgmt.*.id, count.index)
  network_security_group_id = azurerm_network_security_group.stc_gui.id
}

# create Windows TestCenter
resource "azurerm_windows_virtual_machine" "stc_gui" {
  count                 = var.instance_count
  name                  = "${var.instance_name}-VM${count.index}"
  resource_group_name   = var.resource_group_name
  location              = var.resource_group_location
  size                  = var.instance_size
  admin_username        = var.admin_username
  admin_password        = var.stc_windows_pw
  network_interface_ids = [element(azurerm_network_interface.mgmt.*.id, count.index)]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = var.marketplace_version != "" ? var.marketplace_version : "latest"
  }
}

data "template_file" "tf" {
    template = file("${path.module}/install-openssh.ps1")
}

resource "azurerm_virtual_machine_extension" "openssh-extension" {
  count                 = var.instance_count
  name                 = "extension-${var.instance_name}-${count.index}"
  virtual_machine_id   = element(azurerm_windows_virtual_machine.stc_gui.*.id, count.index)
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<SETTINGS
  {
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.tf.rendered)}')) | Out-File -filepath install-openssh.ps1\" && powershell -ExecutionPolicy Unrestricted -File install-openssh.ps1"
  }
  SETTINGS
}

# provision the windows VM
resource "null_resource" "provisioner" {
  count = var.enable_provisioner ? var.instance_count : 0
  connection {
    host        = element(azurerm_windows_virtual_machine.stc_gui.*.public_ip_address, count.index)
    type        = "ssh"
    user        = var.admin_username
    password    = var.stc_windows_pw
    # work around terraform bug #25634 windows server 2019 ssh server
    script_path = "/Windows/Temp/terraform_%RAND%.bat"
  }

  # copy install script
  provisioner "file" {
    source      = "${path.module}/install-testcenter.ps1"
    destination = "${var.dest_dir}/install-testcenter.ps1"
  }

  # copy Spirent TestCenter installer
  provisioner "file" {
    source      = var.stc_installer
    destination = "${var.dest_dir}/${basename(var.stc_installer)}"
  }

  # run install
   provisioner "remote-exec" {
    inline = [
      "powershell -File \"${var.dest_dir}/install-testcenter.ps1\" -Dir \"${var.dest_dir}\" -ExtraDownload 1",
    ]
  }
}
