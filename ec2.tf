resource "aws_launch_template" "agent" {
  name_prefix   = "${var.project_name}-hcp-terraform-agent-"
  image_id      = data.aws_ami.selected.id
  instance_type = var.instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.agent.name
  }

  network_interfaces {
    security_groups = [aws_security_group.agent.id]
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  user_data = base64encode(templatefile("${path.module}/templates/cloud-init.yaml.tftpl", {
    tfc_agent_version         = var.tfc_agent_version
    tfc_agent_token_secret_id = aws_secretsmanager_secret.tfc_agent_token.id
    aws_region                = data.aws_region.current.id
  }))

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.common_tags, {
      Name = "${var.project_name}-hcp-terraform-agent"
    })
  }

  tags = merge(var.common_tags, { Name = "${var.project_name}-hcp-terraform-agent-lt" })
}

resource "aws_autoscaling_group" "agent" {
  name_prefix         = "${var.project_name}-hcp-terraform-agent-"
  desired_capacity    = var.agent_count
  min_size            = 1
  max_size            = var.agent_count * 2
  vpc_zone_identifier = data.aws_subnets.private.ids

  launch_template {
    id      = aws_launch_template.agent.id
    version = "$Latest"
  }
}
