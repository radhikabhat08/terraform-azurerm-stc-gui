# Run Windows Spirent TestCenter Application
This Terraform module runs a Windows Server 2019 instance and installs the Spirent TestCenter Application.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| stc\_windows\_pw | Specify the windows password with a TF\_VAR\_stc\_windows\_pw environment variable | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_public\_ips | List of public IP addresses assigned to the instances, if applicable |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
