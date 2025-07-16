output "vpc_id" {
  value = module.MERN_VPC_infra.vpc_id
}

output "public_subnet_ids" {
  value = module.MERN_VPC_infra.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.MERN_VPC_infra.private_subnet_ids
}

# EC2 Module Outputs
output "ec2_instance_id" {
  value = module.default_ec2_instance.instance_id
}

output "ec2_public_ip" {
  value = module.default_ec2_instance.public_ip
}

output "ec2_subnet_id" {
  value = module.default_ec2_instance.subnet_id
}