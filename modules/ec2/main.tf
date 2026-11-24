resource "aws_instance" "this" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = var.iam_instance_profile

  # Installs the PostgreSQL client so the instance can reach the database with psql.
  user_data = <<-EOF
    #!/bin/bash
    dnf install -y postgresql17
  EOF

  user_data_replace_on_change = true

  # Require IMDSv2 session tokens for the instance metadata service.
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = local.resource_name
  }

  # A newer Amazon Linux release must not replace a running instance by surprise.
  # To pick up a new image, run: terraform apply -replace=module.ec2.aws_instance.this
  lifecycle {
    ignore_changes = [ami]
  }
}
