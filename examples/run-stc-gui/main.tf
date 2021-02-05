## Example : This Terraform module deploys Spirent TestCenter GUI on a Windows Server from Azure Marketplace image.

provider "azurerm" {
  version                    = ">=2.37.0"
  skip_provider_registration = "true"
  features {}
}

data "azurerm_subnet" "mgmt_plane" {
  name                 = var.mgmt_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

module "stc_gui" {
  source                    = "../.."
  instance_count            = var.instance_count
  instance_size             = var.instance_size
  resource_group_name       = var.resource_group_name
  marketplace_version       = var.marketplace_version
  resource_group_location   = var.resource_group_location

  # Warning: Using all address cidr block to simplify the example. You should limit instance access.
  ingress_cidr_blocks       = ["0.0.0.0/0"]

  stc_installer             = var.stc_installer
  mgmt_plane_subnet_id      = data.azurerm_subnet.mgmt_plane.id
  stc_windows_pw            = var.stc_windows_pw
}

output "instance_public_ips" {
  value = module.stc_gui.*.instance_public_ips
}

