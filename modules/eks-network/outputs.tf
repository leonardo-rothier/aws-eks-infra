output "public_subnet_ids" {
  value = [for subnet in aws_subnet.publics : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.privates : subnet.id]
}

output "vpc_id" {
    value = aws_vpc.main.id
}

output "nat_gateway_id" {
    value = aws_nat_gateway.nat.id
}

output "nat_gateway_ip" {
    value = aws_eip.nat.public_ip
}