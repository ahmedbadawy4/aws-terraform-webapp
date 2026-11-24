# ec2 module

Creates one EC2 instance on the latest Amazon Linux 2023 image (x86_64).

- The instance runs in the subnet and security group you pass in, with the instance profile you pass in.
- At first boot it installs the PostgreSQL 17 client (`psql`) with `dnf`, so you can connect to the database from the instance. Amazon Linux 2023 is used because its `psql` supports SCRAM password authentication, which current PostgreSQL versions use.
- The instance metadata service requires IMDSv2 tokens. The root volume is an encrypted gp3 volume that is deleted with the instance.
- A newer Amazon Linux image does not replace a running instance (`ignore_changes = [ami]`). To move to a new image, run `terraform apply -replace=module.ec2.aws_instance.this` from the root module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_ami.amazon_linux_2023](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | Application name. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name, for example dev or prod. | `string` | n/a | yes |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | Name of the instance profile attached to the instance. | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type. It must be an x86\_64 type. | `string` | `"t3.micro"` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | Name of the EC2 key pair used for SSH. | `string` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Size of the encrypted root volume in GiB. | `number` | `20` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | ID of the security group attached to the instance. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet the instance runs in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_private_ip"></a> [ec2\_private\_ip](#output\_ec2\_private\_ip) | Private IP address of the EC2 instance. |
| <a name="output_ec2_public_ip"></a> [ec2\_public\_ip](#output\_ec2\_public\_ip) | Public IP address of the EC2 instance. |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID of the EC2 instance. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
