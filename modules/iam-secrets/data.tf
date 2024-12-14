data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "ssm_policy" {
  statement {
    effect = "Allow"

    actions = [
      "ssm:Describe*",
      "ssm:Get*",
      "ssm:List*"
    ]

    resources = [
      "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/${local.resource_name}-parameter"
    ]
  }
}

data "aws_iam_policy_document" "kms_policy" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:Encrypt"
    ]

    resources = [
      "arn:aws:kms:${var.aws_region}:${data.aws_caller_identity.current.account_id}:alias/${local.resource_name}-key"
    ]
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}
