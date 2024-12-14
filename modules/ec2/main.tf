resource "aws_iam_role" "ec2_role" {
  name               = "${local.resource_name}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
}
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${local.resource_name}-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "amazone_ec2" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  key_name               = var.aws_keypair_name
  subnet_id              = var.aws_subnet
  vpc_security_group_ids = [var.ec2_sg]
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  user_data              = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install postgresql -y
              EOF
  root_block_device {
    volume_size           = var.ec2_volume_size
    delete_on_termination = "true"
  }
  tags = {
    Name = "${local.resource_name}-ec2"
  }
}
