data "aws_iam_policy_document" "agent_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "agent" {
  name_prefix        = "${var.project_name}-hcp-terraform-agent-"
  assume_role_policy = data.aws_iam_policy_document.agent_assume_role.json

  tags = merge(var.common_tags, { Name = "${var.project_name}-hcp-terraform-agent" })
}

data "aws_iam_policy_document" "agent_secrets" {
  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [aws_secretsmanager_secret.tfc_agent_token.arn]
  }
}

resource "aws_iam_role_policy" "agent_secrets" {
  name_prefix = "${var.project_name}-hcp-terraform-agent-secrets-"
  role        = aws_iam_role.agent.id
  policy      = data.aws_iam_policy_document.agent_secrets.json
}

resource "aws_iam_instance_profile" "agent" {
  name_prefix = "${var.project_name}-hcp-terraform-agent-"
  role        = aws_iam_role.agent.name

  tags = merge(var.common_tags, { Name = "${var.project_name}-hcp-terraform-agent" })
}
