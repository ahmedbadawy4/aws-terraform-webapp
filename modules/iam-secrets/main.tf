resource "aws_kms_key" "this" {
  description             = "Encrypts the ${local.resource_name} database storage and its master password secret"
  enable_key_rotation     = true
  deletion_window_in_days = 7

  tags = {
    Name = local.resource_name
  }
}

resource "aws_kms_alias" "this" {
  name          = "alias/${local.resource_name}-key"
  target_key_id = aws_kms_key.this.key_id
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2" {
  name               = "${local.resource_name}-ec2"
  description        = "Role of the ${local.resource_name} EC2 instance"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# The role can read one secret and decrypt with one key. Nothing else.
data "aws_iam_policy_document" "read_db_secret" {
  statement {
    sid       = "ReadDatabaseSecret"
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"]
    resources = [var.db_secret_arn]
  }

  # IAM checks key permissions against the key ARN, not the alias ARN.
  statement {
    sid       = "DecryptWithProjectKey"
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    resources = [aws_kms_key.this.arn]
  }
}

resource "aws_iam_role_policy" "read_db_secret" {
  name   = "read-db-secret"
  role   = aws_iam_role.ec2.id
  policy = data.aws_iam_policy_document.read_db_secret.json
}

resource "aws_iam_instance_profile" "this" {
  name = "${local.resource_name}-ec2"
  role = aws_iam_role.ec2.name
}
