output "asg_name" {
  description = "Name of the HCP Terraform agent Auto Scaling Group."
  value       = aws_autoscaling_group.agent.name
}

output "iam_role_arn" {
  description = "ARN of the HCP Terraform agent IAM role."
  value       = aws_iam_role.agent.arn
}

output "iam_role_name" {
  description = "Name of the HCP Terraform agent IAM role."
  value       = aws_iam_role.agent.name
}

output "security_group" {
  description = "HCP Terraform agent security group."
  value       = aws_security_group.agent
}

output "tfc_agent_token_secret_arn" {
  description = "ARN of the Secrets Manager secret containing the HCP Terraform agent token."
  value       = aws_secretsmanager_secret.tfc_agent_token.arn
}
