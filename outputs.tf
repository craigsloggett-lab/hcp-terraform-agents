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
