# ec2-key module

Creates an SSH key pair for the EC2 instance. Terraform generates a 4096-bit RSA key, registers the public key in AWS as an EC2 key pair, and writes the private key to `<key_name>.pem` in the root module directory with permissions `0600`. The `.gitignore` of this repository excludes `*.pem`.

The private key is also stored in the Terraform state, so keep the state bucket private and encrypted. For a longer-lived setup, create the key pair yourself and pass its name in instead of generating one here.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.5 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.0 |
| <a name="provider_local"></a> [local](#provider\_local) | ~> 2.5 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [local_sensitive_file.private_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of the EC2 key pair. The private key file is named <key\_name>.pem. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_name"></a> [key\_name](#output\_key\_name) | Name of the EC2 key pair. |
| <a name="output_private_key_path"></a> [private\_key\_path](#output\_private\_key\_path) | Path of the private key file. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
