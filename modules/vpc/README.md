<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.81.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.internet_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_security_group.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.postgres](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | application name | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | aws region | `string` | `"us-east-1"` | no |
| <a name="input_az_1"></a> [az\_1](#input\_az\_1) | First Availability Zone | `string` | `"us-east-1a"` | no |
| <a name="input_az_2"></a> [az\_2](#input\_az\_2) | Second Availability Zone | `string` | `"us-east-1b"` | no |
| <a name="input_destination_cidr_block"></a> [destination\_cidr\_block](#input\_destination\_cidr\_block) | CIDR block for the route | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | environment name | `string` | n/a | yes |
| <a name="input_subnet_1_cidr"></a> [subnet\_1\_cidr](#input\_subnet\_1\_cidr) | Subnet for the first Availability Zone | `string` | `"10.0.1.0/24"` | no |
| <a name="input_subnet_2_cidr"></a> [subnet\_2\_cidr](#input\_subnet\_2\_cidr) | Subnet for the second Availability Zone | `string` | `"10.0.2.0/24"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR for VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_subnet_group_id"></a> [default\_subnet\_group\_id](#output\_default\_subnet\_group\_id) | n/a |
| <a name="output_main_subnet1_id"></a> [main\_subnet1\_id](#output\_main\_subnet1\_id) | main subnet 1 id |
| <a name="output_sg_ec2_id"></a> [sg\_ec2\_id](#output\_sg\_ec2\_id) | n/a |
| <a name="output_sg_postgres_id"></a> [sg\_postgres\_id](#output\_sg\_postgres\_id) | n/a |
| <a name="output_subnet1_id"></a> [subnet1\_id](#output\_subnet1\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
