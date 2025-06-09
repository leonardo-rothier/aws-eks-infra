resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = var.nat_eip_name
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.publics)[0].id

  tags = {
    Name = var.nat_eip_name
  }

  depends_on = [aws_internet_gateway.igw]
}

