resource "aws_kms_key" "this" {
  description = "KMS key to encyrept rds master password"
}

resource "aws_kms_alias" "this" {
  name          = "${local.resource_name}-key"
  target_key_id = aws_kms_key.this.key_id
}

resource "aws_ssm_parameter" "this" {
  name   = "${local.resource_name}-db-password"
  type   = "SecureString"
  value  = random_password.this.result
  key_id = aws_kms_key.this.key_id
}

resource "aws_iam_policy" "SSMRead" {
  name        = "ssmReadOnly"
  description = "Allow get, describe and list parameters store"
  policy      = data.aws_iam_policy_document.ssm_policy.json
}

resource "aws_iam_policy" "kmsEncryptDecrept" {
  name        = "kmsEncryptDecrept"
  description = "Allow encrypt and decrept on rds_kms"
  policy      = data.aws_iam_policy_document.kms_policy.json
}

resource "aws_iam_role" "this" {
  name               = "${local.resource_name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "policy1Attachment" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.SSMRead.arn
}

resource "aws_iam_role_policy_attachment" "policy2Attachment" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.kmsEncryptDecrept.arn
}

resource "random_password" "this" {
  length  = "12"
  special = false
}
