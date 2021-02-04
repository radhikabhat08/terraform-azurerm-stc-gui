## Example : This Terraform module deploys Spirent TestCenter GUI on a Windows Server from Azure Marketplace image.

provider "azurerm" {
  version                    = ">=2.37.0"
  skip_provider_registration = "true"
  features {}
}

data "azurerm_subnet" "mgmt_plane" {
  name                 = "mgmt-westus2"
  virtual_network_name = "STCv"
  resource_group_name  = "default"
}

module "stc_gui" {
  source                    = "../.."
  instance_count            = 1
  marketplace_version       = "latest"
  resource_group_location   = "West US 2"
  ingress_cidr_blocks       = ["0.0.0.0/0"]
  stc_installer             = "../../../stcv-Ninstances/install-files"
  mgmt_plane_subnet_id      = data.azurerm_subnet.mgmt_plane.id
  stc_windows_pw            = var.stc_windows_pw
}

output "instance_public_ips" {
  value = module.stc_gui.*.instance_public_ips
}