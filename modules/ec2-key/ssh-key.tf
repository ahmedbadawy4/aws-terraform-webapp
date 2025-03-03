# terraform {
#   required_version = "0.14.5"
#   required_providers {
#     local = {
#       source  = "hashicorp/local"
#       version = "2.0.0"
#     }
#     tls = {
#       source  = "hashicorp/tls"
#       version = "3.0.0"
#     }
#   }
# }

# provider "local" {}
# provider "tls" {}

# resource "tls_private_key" "ssh_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "local_file" "cloud_config" {
#   content  = templatefile("cloud-config.yaml.tpl", {
#     public_key  = tls_private_key.ssh_key.public_key_openssh,
#     private_key = tls_private_key.ssh_key.private_key_pem
#   })
#   filename = "cloud-config.yaml"
# }
