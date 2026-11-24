# rds module

Creates one PostgreSQL instance on Amazon RDS.

- The storage is encrypted with the KMS key you pass in.
- RDS creates the master password and keeps it in Secrets Manager, encrypted with the same key. The password is not in the Terraform configuration or in an output.
- The instance is not publicly accessible and sits in the DB subnet group you pass in.
- The database name is derived from `<environment>-<application>` with hyphens replaced by underscores, because PostgreSQL names cannot contain hyphens.
- By default the instance is a single `db.t3.micro` with 7 days of backups, no deletion protection and no final snapshot on destroy. Change `deletion_protection`, `skip_final_snapshot` and `multi_az` before storing data you need to keep.

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
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Storage size in GiB. gp3 storage needs at least 20. | `number` | `20` | no |
| <a name="input_application"></a> [application](#input\_application) | Application name. | `string` | n/a | yes |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | Days to keep automated backups. 0 turns backups off. | `number` | `7` | no |
| <a name="input_db_sg_id"></a> [db\_sg\_id](#input\_db\_sg\_id) | ID of the security group attached to the database. | `string` | n/a | yes |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | Name of the DB subnet group the instance is placed in. | `string` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Master user name. RDS generates the password and keeps it in Secrets Manager. | `string` | `"appadmin"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Block deletion of the database. Turn it on before real data is stored. | `bool` | `false` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | PostgreSQL version. A major version such as 17 lets RDS pick the current minor version. | `string` | `"17"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name, for example dev or prod. | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | RDS instance class. | `string` | `"db.t3.micro"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | ARN of the KMS key that encrypts the storage and the master password secret. | `string` | n/a | yes |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Run a standby instance in a second availability zone. | `bool` | `false` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Skip the final snapshot when the database is destroyed. Set to false to keep one. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_instance_address"></a> [db\_instance\_address](#output\_db\_instance\_address) | DNS address of the PostgreSQL instance. |
| <a name="output_db_instance_id"></a> [db\_instance\_id](#output\_db\_instance\_id) | Identifier of the RDS instance. |
| <a name="output_db_master_user_secret_arn"></a> [db\_master\_user\_secret\_arn](#output\_db\_master\_user\_secret\_arn) | ARN of the Secrets Manager secret that holds the master password. |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | Name of the database. |
| <a name="output_db_username"></a> [db\_username](#output\_db\_username) | Master user name. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
