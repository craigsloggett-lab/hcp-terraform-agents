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

resource "aws_iam_instance_profile" "agent" {
  name_prefix = "${var.project_name}-hcp-terraform-agent-"
  role        = aws_iam_role.agent.name

  tags = merge(var.common_tags, { Name = "${var.project_name}-hcp-terraform-agent" })
}
