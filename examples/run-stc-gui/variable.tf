variable "stc_windows_pw" {
  description = "Specify the windows password with a TF_VAR_stc_windows_pw environment variable"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name in Azure."
  type        = string
  default     = "default"
}

variable "virtual_network_name" {
  description = "Virtual Network name in Azure."
  type        = string
  default     = "STCv"
}

variable "mgmt_subnet_name" {
  description = "Management subnet name."
  type        = string
  default     = "mgmt-westus2"
}

variable "resource_group_location" {
  description = "Resource group location in Azure."
  type        = string
  default     = "West US 2"
}

variable "instance_count" {
  description = "Number of instances to create."
  type        = number
  default     = 1
}

variable "marketplace_version" {
  description = "Version of the Windows server image."
  type        = string
  default     = "latest"
}

variable "instance_size" {
  description = "The Azure Virtual Machine SKU."
  type        = string
  default     = "Standard_DS1_v2"
}

variable "stc_installer" {
  description = "File path to 'Spirent TestCenter Application x64.exe' or 'Spirent TestCenter Application.exe' installer."
  default     = "../../Spirent TestCenter Application.exe"
}