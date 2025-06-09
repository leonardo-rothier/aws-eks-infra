resource "aws_subnet" "privates" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    "Name"                                  = each.value.name
    "kubernetes.io/role/internal-elb"       = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }

}

resource "aws_subnet" "publics" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    "Name"                                  = each.value.name
    "kubernetes.io/role/elb"                = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}