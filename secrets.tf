resource "aws_secretsmanager_secret" "tfc_agent_token" {
  name_prefix = "${var.project_name}-hcp-terraform-agent-token-"

  tags = merge(var.common_tags, { Name = "${var.project_name}-hcp-terraform-agent-token" })
}

resource "aws_secretsmanager_secret_version" "tfc_agent_token" {
  secret_id     = aws_secretsmanager_secret.tfc_agent_token.id
  secret_string = var.tfc_agent_token
}
