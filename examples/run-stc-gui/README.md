## Run Windows Spirent TestCenter Application

Run a Windows Server 2019 instance and install the Spirent TestCenter Application.

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
| instance\_count | Number of instances to create. | `number` | `1` | no |
| instance\_size | The Azure Virtual Machine SKU. | `string` | `"Standard_DS1_v2"` | no |
| marketplace\_version | Version of the Windows server image. | `string` | `"latest"` | no |
| mgmt\_subnet\_name | Management subnet name. | `string` | `"mgmt-westus2"` | no |
| resource\_group\_location | Resource group location in Azure. | `string` | `"West US 2"` | no |
| resource\_group\_name | Resource group name in Azure. | `string` | `"default"` | no |
| stc\_installer | File path to 'Spirent TestCenter Application x64.exe' or 'Spirent TestCenter Application.exe' installer. | `string` | `"../../Spirent TestCenter Application x64.exe"` | no |
| stc\_windows\_pw | Specify the windows password with a TF\_VAR\_stc\_windows\_pw environment variable | `string` | n/a | yes |
| virtual\_network\_name | Virtual Network name in Azure. | `string` | `"STCv"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_public\_ips | List of public IP addresses assigned to the instances, if applicable |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
