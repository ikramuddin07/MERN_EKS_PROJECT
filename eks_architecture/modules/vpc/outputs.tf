output "public_subnet_ids" {
  value = [for s in aws_subnet.public_subnets : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.private_subnets : s.id]
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway.id
}

output "internet_gateway_id" {
 value = aws_internet_gateway.igw.id 
}