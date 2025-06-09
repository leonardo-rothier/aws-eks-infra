resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  # it is required for some addons as EFS CSI driver
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}