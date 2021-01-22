#VARIABLES

variable "instance_count" {
  type        = number
  description = "Number of instances to create."
  default     = 1
}

variable "instance_size" {
  type        = string
  description = "Azure instance size."
  default     = "Standard_DS1_v2"
}

variable "instance_name" {
  type        = string
  description = "Name assigned to the Windows STC GUI instance.  An instance number will be appended to the name."
  default     = "stcgui"
}

variable "marketplace_version" {
  type        = string
  description = "Version of the Windows server image."
  default     = "latest"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name in Azure."
  default     = "default"
}

variable "resource_group_location" {
  type        = string
  description = "Resource group location in Azure."
  default     = "West US"
}

variable "virtual_network" {
  type        = string
  description = "Azure virtual network name."
  default     = ""
}

variable "mgmt_plane_subnet_id" {
  type        = string
  description = "Management public Azure subnet ID."
  default     = ""
}

variable "admin_username" {
  description = "local administrator user name."
  default     = "adminuser"
}

variable "admin_password" {
  description = "local administrator password."
  default     = "P@$$w0rd1234!"
}

variable "dest_dir" {
  type        = string
  description = "Destination directory on the instance where files will be copied."
  default     = "c:/users/adminuser/downloads"
}

variable "src_dir" {
  type        = string
  description = "Source directory containing 'Spirent TestCenter Application.exe'.  This directory will be copied to each instance."
}

variable "enable_provisioner" {
  type        = bool
  description = "Enable provisioning."
  default     = true
}

variable "ingress_cidr_blocks" {
  description = "List of management interface ingress IPv4/IPv6 CIDR ranges"
  type        = list(string)
}


