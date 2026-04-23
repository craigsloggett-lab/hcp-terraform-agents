data "aws_region" "current" {}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}-private-*"]
  }
}

data "aws_ami" "selected" {
  most_recent = true
  owners      = [var.aws_ami.owner]

  filter {
    name   = "name"
    values = [var.aws_ami.name]
  }
}
