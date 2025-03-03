# Generate SSH Key
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save Private Key Locally
resource "local_file" "private_key" {
  content  = tls_private_key.ec2_key.private_key_pem
  filename = "${path.module}/ec2-key.pem"
  file_permission = "0600"
}

# Save Public Key Locally
resource "local_file" "public_key" {
  content  = tls_private_key.ec2_key.public_key_openssh
  filename = "${path.module}/ec2-key.pub"
}
