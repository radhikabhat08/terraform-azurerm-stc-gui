# Windows Spirent TestCenter Application
 
Run a Windows Server instance and install the Windows Spirent TestCenter application.
After the instance has been started connect using Remote Desktop to use Spirent TestCenter. 

Please obtain a copy of the Windows Spirent TestCenter Application from http://support.spirent.com
and place it in a directory with files copied to the instances.  Be sure to update the stc_installer variable to point to this directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| azurerm | >=2.37.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >=2.37.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_username | Local administrator user name. | `string` | `"adminuser"` | no |
| dest\_dir | Destination directory on the instance where files will be copied. | `string` | `"c:/users/adminuser/downloads"` | no |
| enable\_provisioner | Enable provisioning. | `bool` | `true` | no |
| ingress\_cidr\_blocks | List of management interface ingress IPv4/IPv6 CIDR ranges. | `list(string)` | n/a | yes |
| instance\_count | Number of instances to create. | `number` | `1` | no |
| instance\_name | Name assigned to the Windows STC GUI instance.  An instance number will be appended to the name. | `string` | `"stcgui"` | no |
| instance\_size | The Azure Virtual Machine SKU. | `string` | `"Standard_DS1_v2"` | no |
| marketplace\_version | Version of the Windows server image. | `string` | `"latest"` | no |
| mgmt\_plane\_subnet\_id | Management public Azure subnet ID. | `string` | `""` | no |
| resource\_group\_location | Resource group location in Azure. | `string` | `"West US"` | no |
| resource\_group\_name | Resource group name in Azure. | `string` | `"default"` | no |
| stc\_installer | File path to 'Spirent TestCenter Application x64.exe' or 'Spirent TestCenter Application.exe' installer. | `string` | n/a | yes |
| stc\_windows\_pw | Specify the windows password with a TF\_VAR\_stc\_windows\_pw environment variable. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_ids | List of instance IDs |
| instance\_private\_ips | List of private IP addresses assigned to the instances, if applicable |
| instance\_public\_ips | List of public IP addresses assigned to the instances, if applicable |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
