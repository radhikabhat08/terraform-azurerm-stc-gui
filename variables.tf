#VARIABLES

variable "instance_count" {
  description = "Number of instances to create."
  type        = number
}

variable "instance_size" {
  description = "The Azure Virtual Machine SKU."
  type        = string
}

variable "instance_name" {
  description = "Name assigned to the Windows STC GUI instance.  An instance number will be appended to the name."
  type        = string
  default     = "stcgui"
}

variable "marketplace_version" {
  description = "Version of the Windows server image."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name in Azure."
  type        = string
  default     = ""
}

variable "resource_group_location" {
  description = "Resource group location in Azure."
  type        = string
  default     = ""
}

variable "mgmt_plane_subnet_id" {
  description = "Management public Azure subnet ID."
  type        = string
  default     = ""
}

variable "admin_username" {
  description = "Local administrator user name."
  default     = "adminuser"
}

variable "dest_dir" {
  description = "Destination directory on the instance where files will be copied."
  type        = string
  default     = "c:/users/adminuser/downloads"
}

variable "stc_installer" {
  description = "File path to 'Spirent TestCenter Application x64.exe' or 'Spirent TestCenter Application.exe' installer."
  type        = string

  validation {
    condition = (
      can(regex("Spirent TestCenter Application( x64|)\\.exe", basename(var.stc_installer)))
    )
    error_message = "Spirent TestCenter Application x64.exe or Spirent TestCenter Application.exe must be specified in the path."
  }

}

variable "enable_provisioner" {
  description = "Enable provisioning."
  type        = bool
  default     = true
}

variable "ingress_cidr_blocks" {
  description = "List of management interface ingress IPv4/IPv6 CIDR ranges."
  type        = list(string)
}

variable "stc_windows_pw" {
  description = "Specify the windows password with a TF_VAR_stc_windows_pw environment variable"
  type        = string
}


