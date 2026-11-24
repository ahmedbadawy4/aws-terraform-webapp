# vpc module

Creates the network for the web server and the database: a VPC, an internet gateway, two public subnets in two availability zones, a DB subnet group and two security groups.

- The EC2 security group allows ports 22 and 80 only from `allowed_cidr_blocks`. With the default empty list nothing outside the VPC can connect.
- The PostgreSQL security group allows port 5432 only from the EC2 security group and has no outbound rules.
- Both subnets share the main route table, which has one route to the internet gateway.

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
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_security_group.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.postgres](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_security_group_egress_rule.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.postgres](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | CIDR blocks that may reach the EC2 instance on ports 22 and 80. Empty means no access from outside the VPC. | `list(string)` | `[]` | no |
| <a name="input_application"></a> [application](#input\_application) | Application name. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name, for example dev or prod. | `string` | n/a | yes |
| <a name="input_subnet_1_cidr"></a> [subnet\_1\_cidr](#input\_subnet\_1\_cidr) | CIDR block of the first subnet. It is created in the first availability zone. | `string` | `"10.0.1.0/24"` | no |
| <a name="input_subnet_2_cidr"></a> [subnet\_2\_cidr](#input\_subnet\_2\_cidr) | CIDR block of the second subnet. It is created in the second availability zone. | `string` | `"10.0.2.0/24"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block of the VPC. | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_subnet_group_name"></a> [db\_subnet\_group\_name](#output\_db\_subnet\_group\_name) | Name of the RDS subnet group. |
| <a name="output_sg_ec2_id"></a> [sg\_ec2\_id](#output\_sg\_ec2\_id) | ID of the security group for the EC2 instance. |
| <a name="output_sg_postgres_id"></a> [sg\_postgres\_id](#output\_sg\_postgres\_id) | ID of the security group for the PostgreSQL instance. |
| <a name="output_subnet_1_id"></a> [subnet\_1\_id](#output\_subnet\_1\_id) | ID of the first subnet. The EC2 instance runs here. |
| <a name="output_subnet_2_id"></a> [subnet\_2\_id](#output\_subnet\_2\_id) | ID of the second subnet. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the VPC. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
