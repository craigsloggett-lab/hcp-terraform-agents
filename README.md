# HCP Terraform Agents

Terraform configuration for HCP Terraform agents.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.0 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_agent_count"></a> [agent\_count](#input\_agent\_count) | Desired number of HCP Terraform agent instances. | `number` | `2` | no |
| <a name="input_aws_ami"></a> [aws\_ami](#input\_aws\_ami) | AMI owner and name filter for the HCP Terraform agent instances. | <pre>object({<br/>    owner = string<br/>    name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Tags to apply to all resources. | `map(string)` | `{}` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type for HCP Terraform agent nodes. | `string` | `"t3.medium"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name prefix for all resources. | `string` | n/a | yes |
| <a name="input_tfc_agent_token"></a> [tfc\_agent\_token](#input\_tfc\_agent\_token) | HCP Terraform agent token. | `string` | n/a | yes |
| <a name="input_tfc_agent_version"></a> [tfc\_agent\_version](#input\_tfc\_agent\_version) | Version of the HCP Terraform agent to install. | `string` | `"1.28.7"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name tag of the existing VPC to deploy into. | `string` | n/a | yes |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_autoscaling_group.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_iam_instance_profile.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.agent_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_launch_template.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_secretsmanager_secret.tfc_agent_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.tfc_agent_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.agent_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_ami.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_policy_document.agent_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.agent_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_asg_name"></a> [asg\_name](#output\_asg\_name) | Name of the HCP Terraform agent Auto Scaling Group. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of the HCP Terraform agent IAM role. |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of the HCP Terraform agent IAM role. |
| <a name="output_security_group"></a> [security\_group](#output\_security\_group) | HCP Terraform agent security group. |
| <a name="output_tfc_agent_token_secret_arn"></a> [tfc\_agent\_token\_secret\_arn](#output\_tfc\_agent\_token\_secret\_arn) | ARN of the Secrets Manager secret containing the HCP Terraform agent token. |
<!-- END_TF_DOCS -->
