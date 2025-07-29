output "vpc_id" {
  value = module.mern_vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.mern_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.mern_vpc.private_subnet_ids
}

output "nat_gateway_id" {
  value = module.mern_vpc.nat_gateway_id
}

output "internet_gateway_id" {
  value = module.mern_vpc.internet_gateway_id
}

# EC2 Outputs
output "jump_ec2_id" {
  value = module.jump_ec2.instance_id
}

output "jump_ec2_ip" {
  value = module.jump_ec2.public_ip
}

output "jump_ec2_subnet_id" {
  value = module.jump_ec2.subnet_id
}