resource "aws_security_group" "agent" {
  name_prefix = "${var.project_name}-hcp-terraform-agent-"
  description = "Security group for HCP Terraform agent nodes"
  vpc_id      = data.aws_vpc.selected.id

  tags = merge(var.common_tags, { Name = "${var.project_name}-hcp-terraform-agent" })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "agent_all" {
  security_group_id = aws_security_group.agent.id
  description       = "All outbound traffic"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
