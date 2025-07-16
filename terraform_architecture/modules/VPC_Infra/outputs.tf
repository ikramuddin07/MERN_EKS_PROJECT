output "vpc_id" {
  value = aws_vpc.MERN_VPC.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.MERN_public_subnets : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private_subnets : subnet.id]
}

output "nat_gateway_id" {
  value = aws_nat_gateway.MERN_NAT.id
}
